From: jean-luc malet <jeanluc.malet@gmail.com>
Subject: git svn : some feedback and wonder...
Date: Mon, 11 May 2009 17:52:48 +0200
Message-ID: <1de9d39c0905110852v65b07bebl47cc9a58046c5288@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 11 17:53:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3XoX-0006rI-GO
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 17:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755110AbZEKPwx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 May 2009 11:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754570AbZEKPww
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 11:52:52 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:52643 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbZEKPwu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2009 11:52:50 -0400
Received: by an-out-0708.google.com with SMTP id d40so10139285and.1
        for <git@vger.kernel.org>; Mon, 11 May 2009 08:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=OFcH6X5lKDEht652Jtg2cZ7YSQ4GyUz48PsVQikUhog=;
        b=cLdy62gcvQLM0k29zDUlSiyobDxycmUGMYpFH8fIgQ/pgN8a9h0eAkx2VbBnbhUzJJ
         p/u2Vy/SvvM48H0tdr7era+yOjhPQWKrdEBznHFdjDObOAOsH/2kVVe+fOclBYK6rxYi
         fAV1mJTV8TI1Zbf+EZ0S1s7vk7uIAce4ZMz+o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=aOVn9c1D1iwVf9W+UQm6zmyCTGmaYBpeFP4ZKhMu5nLjUN5YYADNQybWelqT1JhIgj
         nQM6CUru7VGkc2pHst6hZFzowKj5DNbU5BpTXgP3sUiGxFaD/riAHLROXpbAPs+pv4QB
         f4vNONlgGfFdSy1NGp3sv+xEsnRM1naiRGK5k=
Received: by 10.100.166.7 with SMTP id o7mr15920350ane.90.1242057168714; Mon, 
	11 May 2009 08:52:48 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118808>

hi
I'm just toying with git svn....
so I have an svn repository and I do a git svn clone -s
http://path.to/my/repository
here all is fine it checkout my trunk into master branch

1) when I do a git branch -a, it show 2 branches : master and trunk,
shouldn't it be master and svn/trunk?
2) when I create a branch using git svn branch it create an empty
directory and not as expected a branch from the current revision of
trunk
3) the branch appears in git branch -a without a remote
information.... not easy to track
4) you can't do git branch --track newbranch (where new branch is the
svn branch), since the branch name isn't prefixed by svn/ you can't
reuse the same name
5) why having called dcommit instead of push? it would have been more
understable (more coherent) git svn push would have pushed current
branch on corresponding svn branch and git svn push somebranch would
have do a git svn branch followed by the commits...
6) why having called rebase instead of pull? git svn pull would have
fetched svn/trackedbranch and merged into current branch, git svn pull
somebranch would have merged into current branch the svn/somebranch
(without traking info)

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
