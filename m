From: jean-luc malet <jeanluc.malet@gmail.com>
Subject: git push don't setup tracking?
Date: Mon, 11 May 2009 13:46:10 +0200
Message-ID: <1de9d39c0905110446h5a0b54e3ic7cf58dda24d4bc4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 11 13:46:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3Txf-0005vY-8q
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 13:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754696AbZEKLqN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 May 2009 07:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754229AbZEKLqN
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 07:46:13 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:13261 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754054AbZEKLqM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2009 07:46:12 -0400
Received: by an-out-0708.google.com with SMTP id d40so9813959and.1
        for <git@vger.kernel.org>; Mon, 11 May 2009 04:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=UHlVEPJ4euf73cKJyfk2b0Y32lN4jRg/qh8VWKvdTLc=;
        b=ZVMd607IlEr+KBl8kSeANWQuxKCtpXEQshIZG7nqnVIvlI+gLT46pxD5b0voBrSzgC
         PIT33ViGL1G6+6Zx/iv/TO8bYo9Eto9/jXYgp/8gXaGmsnnBTycocFSrCKh2QBHoivLk
         m2M3zzH8S7svG+g0b99/gzuPBQ1JvrBp9DD48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=QxoKoSTQeJe8XeeffMifb47wFN/ClweRXjXdH8mH/tFmIB5h+EsSZFHDgvO5jSxbAS
         +c0hdqk5kdL42i9mAOukKhmup8mY5v1pJ7KD7cEJUg5ndADIVu3X8TRw3+wwvqPZFfzq
         6pr8vIfMfq2GJwWOvJFonfofDFD1O0EntaYIA=
Received: by 10.100.95.11 with SMTP id s11mr13901678anb.112.1242042370717; 
	Mon, 11 May 2009 04:46:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118792>

Hi!
I want to use git in a "star" configuration.
I have  "repository" and 2 client "home" and "work"
I cloned repository on home and work, then I created a branch at work,
and pushed it to repository, at home I "git branch --track
origin/newbranch" and done some work... all ok there... then I pushed
again to repository
come back at work I wanted just to do a git pull.... and there it says
me that it don't have any tracking information... so I add to add by
hand the following lines into .git/config :
[branch "newbranch"]
	remote =3D origin
	merge =3D refs/heads/newbranch

and now it's working.... I think there shall be a way like "git push
--track newbranch origin" so it store tracking information
thanks and regards
JLM

--=20
KISS! (Keep It Simple, Stupid!)
(garde le simple, imb=C3=A9cile!)
"mais qu'est-ce que tu m'as pondu comme usine =C3=A0 gaz? fait des chos=
es
simples et qui marchent, esp=C3=A8ce d'imb=C3=A9cile!"
-----------------------------
"Si vous pensez que vous =C3=AAtes trop petit pour changer quoique ce s=
oit,
essayez donc de dormir avec un moustique dans votre chambre." Betty
Reese
http://www.grainesdechangement.com/citations.htm
