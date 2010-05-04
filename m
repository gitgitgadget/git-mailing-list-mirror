From: Ricky Clarkson <ricky.clarkson@gmail.com>
Subject: I've been pushing to one branch from both git-svn and git
Date: Tue, 4 May 2010 12:43:23 +0100
Message-ID: <z2h7eeb06461005040443ib2fb7405i39e7d5b4220bfb08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 04 13:43:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9GXW-0006cz-Qv
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 13:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221Ab0EDLnp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 May 2010 07:43:45 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45830 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432Ab0EDLno convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 May 2010 07:43:44 -0400
Received: by fxm10 with SMTP id 10so3106016fxm.19
        for <git@vger.kernel.org>; Tue, 04 May 2010 04:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=TXajr5B5LdbfxS77Btd0Z731ZgQDO+GR7pU+YVtdc/M=;
        b=mYT+xhVv8lgnbq+hkE36A4ll8sE9e+vVPsP6RtD2v9AI1xjwJJx/FE8hVNXaP4fbZr
         DXsZfZbln5BC/YMZcj3xc3X2fQxtL1vky73wWA76CYyQiNTCy3xPzt/cba82LZIp2DEC
         gnCurv/lTFNf3Prg6hDW+pNF/WW7LDaZTxMKo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=uv/WvivGZd3gLNTQC+VYT1g+xIFxOUcuKqcx3S0cFy6gtXkX2Kcqn2BpSO9odSl7zT
         2EAnomNloWOI0PF2P1KxsVbbX8guqidP061XriQDlHWDMSp8eZN/vf1+OBVpg5SLzvzm
         LR7UjezPgvmBqxtDh9ja7zZddxbcJ0cnCveiE=
Received: by 10.223.24.133 with SMTP id v5mr4118561fab.46.1272973423225; Tue, 
	04 May 2010 04:43:43 -0700 (PDT)
Received: by 10.223.126.3 with HTTP; Tue, 4 May 2010 04:43:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146310>

Hi,

I have a git repository we'll call the git svn repo, in which I only
perform git svn fetch and git push bare.

bare is a bare git repository, which I push to from a local
repository. =C2=A0The mistake I've been making is to push to the branch
'trunk' in bare, from my local repository. =C2=A0The reason this is a
mistake is because git push bare from the git svn repo also pushes to
there.

Today I've been forced to learn of my mistake, as I cannot push from
the git svn repo without possibly losing commits. =C2=A0It turns out (w=
hich
is probably obvious to you all) that I should have been pushing to,
say, bare's 'master' branch instead of its trunk one.

I don't intend to push back to svn from any of these repos, but I
would like to be able to continue pulling changes from svn at least
for the time being. =C2=A0What should I do?

Thanks,
Ricky.

--
Ricky Clarkson
Java and Scala Programmer, AD Holdings
+44 1928 706373
Skype: ricky_clarkson
Google Talk:=C2=A0ricky.clarkson@gmail.com
Google Wave:=C2=A0ricky.clarkson@googlewave.com
