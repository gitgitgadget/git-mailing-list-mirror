From: Joshua Juran <jjuran@gmail.com>
Subject: Re: Back-dating commits--way back--for constitution.git
Date: Tue, 3 Aug 2010 10:37:26 -0700
Message-ID: <2D8CEA56-63B7-425E-A92B-89E2D1548679@gmail.com>
References: <i372v0$3np$1@dough.gmane.org> <m3hbjcptyr.fsf@localhost.localdomain> <4C57D997.5010003@drmicha.warpmail.net> <FF986C58-37A5-41ED-B2AF-1EA4C045B9F7@gmail.com> <20100803124456.GA11608@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jakub Narebski <jnareb@gmail.com>,
	"Joel C. Salomon" <joelcsalomon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 03 19:38:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgLR8-0006mK-Eg
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 19:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757352Ab0HCRhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 13:37:32 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:34833 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757344Ab0HCRha (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 13:37:30 -0400
Received: by pwi5 with SMTP id 5so1746675pwi.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 10:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=mWAyy4M5hwW6UwBiZe07aW7Bir00QEf65caPUWaPUOM=;
        b=oy7zkg5URcAQNuWPBB2WrI2aQcdQ/OLUftoZxVzadXjKSYIR+x0pkCdHREzWd8Eex3
         8RJ6ebegk9dtBPRxQmVmFmdKVueIiftdNrymjz0sO5Bubljly/pzLyYosNpb4pUYXTys
         uRmtmYx8g5D8tCzmIJJFvoExGe7+AUXliaH/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=AU/yCLTcpHIWT7Tngvm57kNC0dy0vlU/gzOrL5ZfZB7FR1ge1N5EQokeSCOXJK5zIv
         KazmNThaCR8lrul9054b0SjrJ4mLBdx06GAnDFEGUs3VtB3VBDZxBf0jiNs84c4qwir4
         lPC0IaAOZ0zky35AoeVyKKa2GvYJbTR9Mz1C8=
Received: by 10.114.60.6 with SMTP id i6mr8919990waa.214.1280857049866;
        Tue, 03 Aug 2010 10:37:29 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id q6sm14038934waj.22.2010.08.03.10.37.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Aug 2010 10:37:28 -0700 (PDT)
In-Reply-To: <20100803124456.GA11608@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152528>

On Aug 3, 2010, at 5:44 AM, Jeff King wrote:

> On Tue, Aug 03, 2010 at 02:32:06AM -0700, Joshua Juran wrote:
>
>>> - use signed long long as our git_time_t (I think long is less  
>>> system
>>> dependent then long but I could be wrong)
>>
>> Obviously you mean "I think long long is less system dependent than
>> long".
>>
>> Does any system exist where long long is not 64 bits?  In any case,
>> you can future-proof it by spelling it "int64_t".  That symbol is not
>> guaranteed to exist (nor is <stdint.h>), but neither is the long long
>> type in the first place.
>
> C99 specifies that "short" and "int" be at least 16 bits, that  
> "long" be
> at least 32 bits, and that "long long" be at least 64 bits. See  
> section
> 5.2.4.2.1.

Right, but there's no guarantee that long long won't be *larger* than  
64 bits.  Though maybe that wouldn't be a problem.

Josh
