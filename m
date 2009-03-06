From: jean-luc malet <jeanluc.malet@gmail.com>
Subject: Fwd: how to have --no-ff be the default for all branch
Date: Fri, 6 Mar 2009 11:45:32 +0100
Message-ID: <1de9d39c0903060245u45373b8cq10d52f353c2214e2@mail.gmail.com>
References: <1de9d39c0903060244t2d39e9c8kd5791d097c84bbeb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 11:47:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfXa3-0006s2-3t
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 11:47:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754254AbZCFKpf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Mar 2009 05:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753951AbZCFKpf
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 05:45:35 -0500
Received: from rv-out-0506.google.com ([209.85.198.233]:47457 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864AbZCFKpe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Mar 2009 05:45:34 -0500
Received: by rv-out-0506.google.com with SMTP id g9so446053rvb.5
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 02:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=CYAfCn3AJA2Cju1EbGtOGUEa2I10Tjo5vI9JP+t3d3w=;
        b=VWus+lX7A9E87BG/xhnFTbSb3eOWyzUC7ctYsVQJrDOajZ6hp6HQnf0SiBcdmf/2Bb
         0T6V5JO5lHFBVn3JGpMhp5DtFia/4WDSYiw2QvJx9fgGBy1j2PngM2UtKedaWggyz63h
         xoLZ3JC4DWlnDl5+oeu3jW5XyeuTkxlKuNIxo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=bw94rD7uLH7hK7PWG54XypQHsYMBIGc6X/vFwmx52Uw4JTyXEU9whuU4Mk1l9L9q5H
         AvO9914bM3u6brFrG/uQ5TG9QoR0zapQ2AkP+Ov5H7DJCUfMQyyuYalTT3XpekWwgycQ
         Go4zoPidczB3OzLHwJ2D+fzKik5YSRPJfS+bs=
Received: by 10.142.237.20 with SMTP id k20mr1044280wfh.136.1236336332683; 
	Fri, 06 Mar 2009 02:45:32 -0800 (PST)
In-Reply-To: <1de9d39c0903060244t2d39e9c8kd5791d097c84bbeb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112420>

---------- Forwarded message ----------
=46rom: jean-luc malet <jeanluc.malet@gmail.com>
Date: Fri, Mar 6, 2009 at 11:44 AM
Subject: how to have --no-ff be the default for all branch
To: git@vger.kernel.org


Hi all!
I'm using git for a time now and the thing that annoyed me the most is
that git "loose" branch information, ie if I have branch1 and master
that I do dev on branch1 (let say 3 commit) and that I want to deliver
on master, if there has not been any commit on master, when I do
git checkout master
git merge branch1
git branch -d branch1

then git resolve as fast forward and then make branch1 "disapear" (ie
on gitk I can't notice just by looking at the tree that there was a
branch there)
the solution is to use
git merge --no-ff branch1

I would like that it is the default for all branch and that I use --ff
when I want to do fast forward merge
I know that I can set it up for one branch
git config add branch.master.mergeoption --no-ff
but I want it to be the default no just for one branch but for all bran=
ch
git config add branch.*.mergeoption --no-ff
don't work....

how can I do that?
thanks
JLM

--
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



--
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
