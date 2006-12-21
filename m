From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Re: specify charset for commits (Was: [PATCH] Fix documentation copy&paste typo)
Date: Thu, 21 Dec 2006 19:05:27 +0600
Message-ID: <200612211905.27555.litvinov2004@gmail.com>
References: <11655782712452-git-send-email-zeisberg@informatik.uni-freiburg.de> <200612211623.14236.litvinov2004@gmail.com> <emdorr$kt$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 14:05:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxNcN-0000Bk-TY
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 14:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422728AbWLUNFh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 21 Dec 2006 08:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422640AbWLUNFh
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 08:05:37 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:13190 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422728AbWLUNFg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Dec 2006 08:05:36 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2629080uga
        for <git@vger.kernel.org>; Thu, 21 Dec 2006 05:05:35 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=eMSAAqQ77kv2Yc11kb293JTtJQl5vRRAHrsdlXYa1o6Al3wrwq0TIzWLQcduq254yoEkyh6+/EMgDVDXUyudUdpZ36cY6wl9m9pL5uX/CheLf2WWsoSa4lvN3UxZT4Z7pK+lbJ2d2IQbcOfJM2h7WUFalbosYWKegd5LrkVages=
Received: by 10.78.170.17 with SMTP id s17mr178753hue.1166706334687;
        Thu, 21 Dec 2006 05:05:34 -0800 (PST)
Received: from lan.ac-sw.lcl ( [81.1.223.2])
        by mx.google.com with ESMTP id 20sm11049638huf.2006.12.21.05.05.32;
        Thu, 21 Dec 2006 05:05:33 -0800 (PST)
To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KMail/1.8
In-Reply-To: <emdorr$kt$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35062>

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=
=82 Thursday 21 December 2006 16:52 Jakub Narebski =D0=BD=D0=B0=D0=BF=D0=
=B8=D1=81=D0=B0=D0=BB(a):
> > May we can add new header into commit with commit text encoding ?
>
> I think it should be repository-wide decision. And we have
> i18n.commitEncoding configuration variable (perhaps it should be prop=
agated
> on clone?).

I would disagree with you. Is is not hard to imagine international proj=
ect=20
managed by git. We [developers] can start to use utf-8 or similar unive=
rsal=20
encoding but it is not easy sometimes. Fir example, not long ago all ru=
ssian=20
linux machines has LANG set to ru_RU.KOI8-R, now it tend to be ru_RU.UT=
=46-8.=20
It will not big surprise to me if developr from China or Japan use some=
thing=20
very unusual. And just imagine one developer using Windows and Cygwin -=
 ha ha=20
ha, try to ask him to change the encoding :-)

The easiest way for git is just to store commit encoding and let tool f=
or=20
history browsing deal with encoding. Or as it does now - simply ignore =
all=20
encodings at all and work with bytes not chars. But at this case histor=
y=20
browsing tool must have some magic knowlage about encoding taken from=20
air :-). Or from config file that cover most used encodings.

Alexander Litvinov.
