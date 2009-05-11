From: jean-luc malet <jeanluc.malet@gmail.com>
Subject: merging multiple commit into one?
Date: Mon, 11 May 2009 15:21:27 +0200
Message-ID: <1de9d39c0905110621p6858bca8y8bb036a167754672@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 11 15:21:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3VRr-0006yO-Uj
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 15:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699AbZEKNV3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 May 2009 09:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbZEKNV3
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 09:21:29 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:14394 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbZEKNV2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2009 09:21:28 -0400
Received: by yx-out-2324.google.com with SMTP id 3so1651228yxj.1
        for <git@vger.kernel.org>; Mon, 11 May 2009 06:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=WqHQDAtHuqA/K04n2wfH1s9p+anrb203CQL6tvgZSb8=;
        b=x11F/7ySY0o+zAO6dLr/itXmc8ndztQH2DigfYQI0PivmsbzlWpwLJPXBAlBbmIGt7
         Icjj91wIj4f353Svvo5Ou2DxH+kJ8NcIjzdrEExfzal7EuMe3jtQxdfwneE8EhWXkcdz
         iNRawUYBFpOMEwVUFENtwvK+MOIYo6AZIIl2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=tnv1HD7ayNc8R3hbtrLSwFi8Yw62fL+BSXn3nNH7lPtL5oo1x+c1DdXQDYxp+3Xtow
         Dd//cO3zSdd48RlhrJtg/MVp2ekrBQ+pKvdmvOFPpRM5zzNrgDTIbNRLYa7zCpfvh8Lr
         ZFZr+EdZKj4FluQb8nsawLv4s15vuxYcW9OPQ=
Received: by 10.90.31.8 with SMTP id e8mr6177650age.45.1242048087419; Mon, 11 
	May 2009 06:21:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118795>

Hi,
I often commit "useless" code, for example before going into weekend
or for saving some state during a dev process
often thoses commit are simply useless and the commit message looks
like "COMPILE ERROR - temporary save .... "
at the end I have LOT of theses commits that are useless and I want to
save some space/time/tree complexity merge multiple sequential commits
(without branch) into one
is it possible?
according to my knowledge of git, removing the commit and rewriting
the last commit log so that it better reflect the modification will do
the job but I'm not sure git allow it...
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
