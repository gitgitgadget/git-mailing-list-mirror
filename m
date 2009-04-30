From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Why Git is so fast (was: Re: Eric Sink's blog - notes on git, 
	dscms and a "whole product" approach)
Date: Thu, 30 Apr 2009 21:16:59 +0200
Message-ID: <81b0412b0904301216j7ef73870y775cf6d89b5aa71e@mail.gmail.com>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com>
	 <m3ocugod96.fsf@localhost.localdomain>
	 <m3fxfqnxn5.fsf_-_@localhost.localdomain>
	 <alpine.LFD.2.00.0904301401120.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Apr 30 21:17:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lzbl9-0003Rh-Rw
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 21:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbZD3TRF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Apr 2009 15:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbZD3TRE
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 15:17:04 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:44745 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbZD3TRC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Apr 2009 15:17:02 -0400
Received: by fxm2 with SMTP id 2so2007910fxm.37
        for <git@vger.kernel.org>; Thu, 30 Apr 2009 12:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bVfwmTbekkKXDWuSK7WC+Gb0afeVNwthbQhGtcfqLfU=;
        b=uHGV1rA47qX/+dCipxK9FcTf/z0u2GPOJo5MjHidmAkBk6Or0vMfsbWMwrTmKBrL9J
         65JQQ4F3MCVoZajFHw+ioMpXB9c4eyWBijyMTpqY3EzqXmHbDtSdc5Oyt79tej7h/WTL
         n2c3H/zrS6yeLQ2nRkoPJrU8XSP5iIz5pQhiM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BCFWrv1neYUcf1jyLpiIL8yDegrv0iSgKFJmnzxube1fW4FgcAGUtGAKN+D6CYmE42
         AKumE7LM22yWcO0w4TLuPWICV4bidToI+215YjaGXa+BcxLnKan37gWfkvpiXz/bOd6R
         ADMAMlqqjDYpBO9mQmGPLWG8oJhFtVkeg26NA=
Received: by 10.204.121.131 with SMTP id h3mr1733559bkr.172.1241119019617; 
	Thu, 30 Apr 2009 12:16:59 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0904301401120.6741@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118037>

2009/4/30 Nicolas Pitre <nico@cam.org>:
> Yet, this point is misleading because when people gives to Git the
> reputation of being faster, this is certainly from comparison of
> operations performed on the same source tree. =C2=A0Who cares about s=
cenarios
> for which the tool was not designed? =C2=A0Those "enterprise configur=
ation
> management repositories" are not what Git was designed for indeed, bu=
t

Especially when no sane developer will put in his repository the toolch=
ain
(pre-compiled. For all supported platforms!), all the supporting tools
(like grep,
find, etc.Pre-compiled _and_ source), the in-house framework (pre-compi=
led
and source, again), firmware (pre-compiled and put in the repository we=
ekly),
and operating system code (pre-compiled, with firmware-specific drivers=
,
updated, you guessed it, weekly), and well, there is the project itself=
 (Java or
C++, and documentation in .doc and .xls)...
Now, what kind of self-hating idiot will design a system for that kind =
of abuse?
(And if someone says that's is not true in the most enterprise
f$%cking configurations,
he definitely hasn't had to live through big enough number of them).
