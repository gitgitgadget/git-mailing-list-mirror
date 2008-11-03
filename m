From: Brian Foster <brian.foster@innova-card.com>
Subject: [Q] Abbreviated history graph?
Date: Mon, 3 Nov 2008 14:39:11 +0100
Message-ID: <200811031439.12111.brian.foster@innova-card.com>
Reply-To: Brian Foster <brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 03 14:41:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kwzg4-0004TX-DN
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 14:41:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755573AbYKCNjb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Nov 2008 08:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755284AbYKCNjb
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 08:39:31 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:1186 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754157AbYKCNja convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Nov 2008 08:39:30 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2233199fgg.17
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 05:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:reply-to:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:sender;
        bh=X9L1UryDcRdbhjs2qvrtdJ6JM8CEZeC6bhA2R83ta08=;
        b=AVve8lGohmr1dx+XtLIcL75wgl/rtnLJCVrK9HzN8wdui0AyDDb0caX1uPNkyCZhB+
         4AodYY7zc68zbuz7199RsElh8gOO00BDtxiSlFEHovDYNIJI5RtZyJQnYKjF3kdf6J17
         rB/oyoRefrG5+ODR4vS2TJHlHpFtY6RftM050=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:reply-to:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:sender;
        b=D4bf//OaGeG+VO/m8ZR4NXSiOkU6S993S/dwxczLSEW4r6XVnVjf9WuiTFMDPCcWsq
         EQoXgY4DjjNOpiPYmKXAHyuv7fxx2TXKQbNhl4Qc4iy+tvsh2fXoHE9daOnJgmRAOTTj
         rKU+cSvdHZ5jut5aaS64dXtzapT8zDBrELCno=
Received: by 10.86.91.12 with SMTP id o12mr170776fgb.16.1225719567620;
        Mon, 03 Nov 2008 05:39:27 -0800 (PST)
Received: from innova-card.com (1-61.252-81.static-ip.oleane.fr [81.252.61.1])
        by mx.google.com with ESMTPS id l12sm8691024fgb.6.2008.11.03.05.39.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 Nov 2008 05:39:25 -0800 (PST)
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99943>


Hello,

  A colleague and I recently wanted to examine the
 history in a broad sense without worrying too much
 about the individual commits.  What we (think we)
 wanted is a =E2=80=98gitk --all=E2=80=99 history graph showing only
 =E2=80=9Cnamed=E2=80=9D historical points; i.e., tags and branch
 HEADs, perhaps with an indication of whether or not
 it's a =E2=80=9Clinear=E2=80=9D change sequence that leads from one
 to another.  That is, hypothetically, if the history
 looks something like (where =E2=80=98A=E2=80=99 &tc has a name as
 per above, and =E2=80=98*=E2=80=99 does not):

     A--->*--->*--->C--->D--->*----->E
      \                   \         /
       \->*-->B            \->*--->*--->F

 What we wanted to see is something like:

     A------>C--->D--->E
      \       \       /
       \->B    \-----/--->F

 Is there some way of doing something similar to that
 (git v1.6.0.2)?  In addition to =E2=80=98gitk=E2=80=99, we also (rathe=
r
 quickly!) tried both =E2=80=98qgit=E2=80=99 and =E2=80=98giggle=E2=80=99=
, but without
 any apparent success.

cheers!
	-blf-

--=20
=E2=80=9CHow many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.=E2=80=9D |      http://www.stope=
sso.com
