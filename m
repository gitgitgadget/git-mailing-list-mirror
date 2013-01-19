From: Thomas Ackermann <th.acker@arcor.de>
Subject: Aw: Re: [PATCH 1/2] Change old system name 'GIT' to 'Git'
Date: Sat, 19 Jan 2013 16:01:16 +0100 (CET)
Message-ID: <310504838.1116553.1358607676116.JavaMail.ngmail@webmail10.arcor-online.net>
References: <CAJDDKr5_AWFF6MR2Kwt5FzA0vaSE-wx8xFO3xcRnKZ168hXBrg@mail.gmail.com> <732444561.1327663.1358589465467.JavaMail.ngmail@webmail24.arcor-online.net>
	<379071741.1327695.1358589560822.JavaMail.ngmail@webmail24.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: davvid@gmail.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Sat Jan 19 16:01:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwZvQ-0002pZ-Ew
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 16:01:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317Ab3ASPBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2013 10:01:18 -0500
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:43629 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751120Ab3ASPBR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Jan 2013 10:01:17 -0500
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mx.arcor.de (Postfix) with ESMTP id 26C005A907;
	Sat, 19 Jan 2013 16:01:16 +0100 (CET)
Received: from mail-in-15.arcor-online.net (mail-in-15.arcor-online.net [151.189.21.55])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id 215867FE52C;
	Sat, 19 Jan 2013 16:01:16 +0100 (CET)
Received: from webmail10.arcor-online.net (webmail10.arcor-online.net [151.189.8.93])
	by mail-in-15.arcor-online.net (Postfix) with ESMTP id 1914B1AB51F;
	Sat, 19 Jan 2013 16:01:16 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-15.arcor-online.net 1914B1AB51F
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1358607676; bh=Ob7GVDMZSMtSMtJHCpEPcEM4FoOiXdGF8APyP8akSGY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=OlkvFB5a0gz1AB+3V5UrkDp2l83pKI9PbAuMlN3i4qZpeOYD1QF6H9KWrU7ncZTXz
	 l9S7VHyaShXMXqXs4dlpfi8I7VgF6J4ilIEdQAxmiM2y+PKWenkfm5Tc40Ad+YcZj9
	 /CLdR8AE7Ae/yGkSMyKKrRu7b2gE4bAacLmmSQog=
Received: from [188.105.103.171] by webmail10.arcor-online.net (151.189.8.93) with HTTP (Arcor Webmail); Sat, 19 Jan 2013 16:01:15 +0100 (CET)
In-Reply-To: <CAJDDKr5_AWFF6MR2Kwt5FzA0vaSE-wx8xFO3xcRnKZ168hXBrg@mail.gmail.com>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.105.103.171
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213981>

 
> 
> What about GITweb?
> 
You are right; I missed that because I grepped only for 'GIT' as a whole word.
'gitweb' and 'GITweb' should be changed to 'Gitweb'.

> 
> IMO some of these look nicer when everything is lowercase.
> e.g. "standard git committer ident format".
> 
IMHO what seems nicer here is the spelling we are all accustomed to.
The whole point of my patch is to use 'Git' consistently when 
we are talking about the system and not the individual command.

> 
> $ git grep 'git repositor' | wc -l
> 226
> 
> These changes touch, for example, git-clone.txt to make it
> say: "Make a 'bare' Git repository".  Why not lowercase?
>
When you also apply my second patch you only get 17 occurences of "git repository" 
which I missed to change to 'Git repository' ...

Thanks for looking into this!


---
Thomas
