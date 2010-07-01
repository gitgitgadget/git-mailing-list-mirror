From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [PATCH v5 2/4] Introduce "double conversion during merge" more gradually
Date: Thu, 1 Jul 2010 22:13:28 +0200
Message-ID: <2B6AD816-8BF8-4778-A5AD-D31DA154E8F5@gmail.com>
References: <cover.1277974452.git.eyvind.bernhardsen@gmail.com> <3ae294ef30c3539da47d101bc39638e63721eb0e.1277974452.git.eyvind.bernhardsen@gmail.com> <4C2C6BC5.1030905@viscovery.net> <7v630z41ao.fsf@alter.siamese.dyndns.org> <D2F8C67C-F7AE-4523-870F-879B741C2591@gmail.com> <m3iq4znnfr.fsf@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	"git@vger.kernel.orgList" <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 01 22:13:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUQ8f-0000C7-PP
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 22:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089Ab0GAUNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 16:13:32 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45265 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035Ab0GAUNb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jul 2010 16:13:31 -0400
Received: by wwb24 with SMTP id 24so220355wwb.1
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 13:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=nmCgY98aJjwzyb+8enQZP/D+vATR2WHV4w/e8Vtztdo=;
        b=p7XNwm6yg72eSZvwnqDuXlLyg5uu8eUYsjC5dyiPh/DHXBSkZOntCC0gmhL1gyhoQF
         zs8AottXaXCSRbvDhf1YiJDhldGNyDoL/NhiMUMgvzFwQLd6RFB6ihl+38Hq6Oi3Q47w
         b/njbqIfLiIv5yyhz5ku8GHsIPJ+zPHRl4GWY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=oTewFNbp5X16/32o3MkCVFSxl+wnBmQLArNZgpjf/STF7uNFKzp21KwcCPAMtodl3n
         Fybg2nfKKaWfGDJ46NouVRA2ezRo+oeVDXPKxz7GOHH1vbGMu1lr3fjRxXQmG+r3RmE6
         sPszQayHozrmddxOVrVoMx3h9JN4NxRG30VLk=
Received: by 10.213.12.196 with SMTP id y4mr2933045eby.3.1278015209911;
        Thu, 01 Jul 2010 13:13:29 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id v8sm222756eeh.8.2010.07.01.13.13.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 13:13:29 -0700 (PDT)
In-Reply-To: <m3iq4znnfr.fsf@localhost.localdomain>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150069>

On 1. juli 2010, at 19.05, Jakub Narebski wrote:

> Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com> writes:
>> On 1. juli 2010, at 18:25, Junio C Hamano <gitster@pobox.com> wrote:
>>> Somehow to me "prefilter" does not sound to convey what really is going on
>>> here, though.
>> 
>> "Doubleconvert" doesn't really mean anything either though, and
>> "convert" and "normalise" are too generic. I think the problem is
>> that there's no existing name for what convert.c does.
>> 
>> I chose "filter" because of the filter property; the crlf and ident
>> things can be regarded as built-in filters.  -- Eyvind
> 
> What about `merge.renormalize' ;-) ?

I like it, but it's still a bit generic.  "merge.renormalizeContent", perhaps?
-- 
Eyvind
