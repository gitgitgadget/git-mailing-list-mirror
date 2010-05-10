From: Bill Winspur <bwinspur@gmail.com>
Subject: git-gui disagrees with git status
Date: Mon, 10 May 2010 15:32:09 -0600
Message-ID: <y2m3b1db1e51005101432je9e75a53vbb3781fa33aa83e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 10 23:32:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBaaH-0006q6-SW
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 23:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755814Ab0EJVcN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 May 2010 17:32:13 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:44203 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819Ab0EJVcK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 May 2010 17:32:10 -0400
Received: by yxe1 with SMTP id 1so2986018yxe.33
        for <git@vger.kernel.org>; Mon, 10 May 2010 14:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=1WGuu8HNCE909zNmykh0ixcBd9eCEPo7P2TxDIGhJSQ=;
        b=OyZjp2XyFFmrJakTyRs2bNpyJZ5+MpMnGzvsWWkIGJV1xQiMevhWY9CP4qoBkGuz0n
         h9CRkFe6tjNAW2q9jzW/j1Sf5yINrlkygHs5dRSZOnsdctSco2vdV4Bb1DRSGQGQtmiz
         8xFML1R7H6vKxh5CnCEym1X9tIakufss2uT04=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=H0MWGQKesPMVgBj+1K1ykLk6ZFRVtlpsxJj9eVa8vIe+62BeODTly5Qi5BjZhGDm/E
         lQJWqR0sfnrMZxkq4/pZ/ydIzDb9Na3rEt6p/3zpbm35w4LHGCEElnognAfE9PbY1+PY
         37YFbwG0YOydHy2jj1g8jxHre3FkuFF4nLkcY=
Received: by 10.231.59.203 with SMTP id m11mr2923429ibh.72.1273527129995; Mon, 
	10 May 2010 14:32:09 -0700 (PDT)
Received: by 10.231.147.207 with HTTP; Mon, 10 May 2010 14:32:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146855>

Using git version 1.6.0.4

- Created an eclipse wkspace, with a couple of projects in it.
- Created a git repos at the workspace route, using cli.
- Using cli added the two projects to git - at this point git status
shows the following

=3D=3D=3D=3D=3D
bwinspur@elm:~/ca.wydv.
workspaces/008-leaning-group/git-lrng-wksp$ git status
# On branch master
#
# Initial commit
#
# Changes to be committed:
#=A0=A0 (use "git rm --cached <file>..." to unstage)
#
#=A0=A0=A0 new file: git.trial.help.bundle/.classpath
=A0=A0=A0=A0=A0=A0=A0 =3D=3D=3D omitted details from this post =3D=3D
#=A0=A0=A0 new file: git.trial.ui.bundle/.classpath
=A0=A0=A0=A0=A0=A0=A0 =3D=3D=3D omitted details from this post =3D=3D
#
# Untracked files:
#=A0=A0 (use "git add <file>..." to include in what will be committed)
#
#=A0=A0=A0 .metadata/
bwinspur@elm:~/ca.wydv.workspaces/008-leaning-group/git-lrng-wksp$
=3D=3D=3D=3D=3D

which is what I expected: my project folders are tracked, and
=2Emetadata/ is untracked.

- now I bring up git gui and it shows all the files under .metadata/ as
unstaged changes, which conflicts with git status, and may be due to a
git-gui bug

Regards,

Bill Winspur
