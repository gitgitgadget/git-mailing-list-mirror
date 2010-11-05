From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Test failures in pu: 4046, 950[012]
Date: Fri, 05 Nov 2010 04:28:01 -0700 (PDT)
Message-ID: <m3zktof1u0.fsf@localhost.localdomain>
References: <201010201148.51551.trast@student.ethz.ch>
	<7vvd4wvmv6.fsf@alter.siamese.dyndns.org>
	<201010201856.54756.trast@student.ethz.ch>
	<201011042237.01801.trast@student.ethz.ch>
	<AANLkTinZJFb_sAH6AGD+ZMwj5boERAU3-NDkA3ve1+=F@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 05 12:28:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEKSr-00078o-Sc
	for gcvg-git-2@lo.gmane.org; Fri, 05 Nov 2010 12:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958Ab0KEL2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Nov 2010 07:28:07 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47834 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401Ab0KEL2F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Nov 2010 07:28:05 -0400
Received: by fxm16 with SMTP id 16so2220532fxm.19
        for <git@vger.kernel.org>; Fri, 05 Nov 2010 04:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=ZlzDOeGrtun2LeXtj47fGhZ8GAhVog0KEtafDvrNgDw=;
        b=XBUyqBnjKEIndrPMU7ROcQb/QkYQnYp095rFQ59GIERhBdWno1IQS+6ofh09SNeOn9
         tmKhkLO7Yn55qXCUMbjbZP2pNNDP97SwiExeRHzjbaBb/icLSF6QJSuXhQuh/cvPtD9L
         MLLdmdsqyaUzu+7Afletmiw13wwJT0wc/UINI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=ePiE8obP8+Pv6teEQXMRcBsiC8FC9u8AzeTJYVBKW4dotKzs2T2Uif1Oppf3Sq3R/w
         o6bNRy4YWnLoiWIxucwgIiLufTiS8pjtK3d0aYiWncMjszJXHco4qp/U1pZHMjOYgCCF
         u5fSvZlk2Hyv6JSwC7wClY3PVpYMmM0FP2w+c=
Received: by 10.223.97.10 with SMTP id j10mr823596fan.112.1288956483049;
        Fri, 05 Nov 2010 04:28:03 -0700 (PDT)
Received: from localhost.localdomain (abvw48.neoplus.adsl.tpnet.pl [83.8.220.48])
        by mx.google.com with ESMTPS id k4sm543955faa.32.2010.11.05.04.28.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Nov 2010 04:28:01 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oA5BRH8I007515;
	Fri, 5 Nov 2010 12:27:28 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oA5BQlse007510;
	Fri, 5 Nov 2010 12:26:47 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTinZJFb_sAH6AGD+ZMwj5boERAU3-NDkA3ve1+=F@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160811>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On t9500.1, I get
> 
> [Fri Nov  5 02:09:15 2010] gitweb.perl: Undefined subroutine
> &main::cache_fetch called at
> /home/pclouds/w/git/t/../gitweb/gitweb.perl line 1124.
> 
> Setting PERLLIB makes it work, but shouldn't the test script have done
> that already?

See http://article.gmane.org/gmane.comp.version-control.git/160395

Fixed in http://thread.gmane.org/gmane.comp.version-control.git/160147/focus=160476
(minimal fixup), not yet in 'pu'.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
