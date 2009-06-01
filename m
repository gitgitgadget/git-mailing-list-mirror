From: jean-luc malet <jeanluc.malet@gmail.com>
Subject: remotely deleting a branch
Date: Mon, 1 Jun 2009 12:16:46 +0200
Message-ID: <1de9d39c0906010316v657f2624i3f16b8b5bea73122@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 01 12:17:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MB4Zf-0003yL-U0
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 12:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756585AbZFAKQr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Jun 2009 06:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755831AbZFAKQq
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 06:16:46 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:55828 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754690AbZFAKQq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jun 2009 06:16:46 -0400
Received: by fxm12 with SMTP id 12so5677026fxm.37
        for <git@vger.kernel.org>; Mon, 01 Jun 2009 03:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=/N4zKbl5AlprWZwoDJkL9N0bdw3nHMMXQQKQp1yylPk=;
        b=skh8I26SVUkHawf1v2XMaC5nC+iqDF1E18sDuC1EXwgOUpam3jR9uxMiX3cM0MiHcx
         LjxWs3WOPZEFGqTLrsTIf7kFDdZAMlQcLmKzNI3nMYhKu/EnWfnhFF0tquB+5l30stpT
         aT5PQrpSWajjoDC6r9RGIG4kJWlW+54MWKuR4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=BHaeALotFedB5XAF47NBmx054z9bUbp0Mx6vRdbrKrWxtjm5M2nz4Qe+8aGGVbtkJG
         hayfNkHmazT3B3Fu5Km7+MyMJEVSUjvqGrFDq+5bvt0SWdSXehW+wZEMycWsRWYoh+Cy
         H0+s8qM35NPooj8TzCMDUS6QOSL9wCVoAGi04=
Received: by 10.103.224.2 with SMTP id b2mr3164252mur.30.1243851406223; Mon, 
	01 Jun 2009 03:16:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120455>

hi!
I created a remote branch by doing
$ git push origin mynewbranch
I done some work on mynewbranch, commited, pushed changes to origin,
merged it to master and pushed to origin and deleted the mynewbranch
localy because I don't need it anymore
now I want to "undo" the git push origin mynewbranch ie remotely
delete the branch from the repository
I tried git push --mirror but it deleted all remote branches that I
didn't worked on... I don't want to have it be a mirror... but
something like
$ git branch -r -d origin/mynewbranch
$ git push
   ---> deleting origin/mynewbranch

how shall I do that?
thanks
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
