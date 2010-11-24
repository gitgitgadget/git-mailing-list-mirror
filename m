From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [StGIT PATCH] contrib/vim: Add vim syntax highlighting for StGit
 commit messages
Date: Wed, 24 Nov 2010 13:38:41 +1300
Message-ID: <AANLkTinS7LrG9ROy+3BLchWEi3=-7E0FFy+9_eJiaswW@mail.gmail.com>
References: <20101123154538.12513.39180.stgit@zaneb-dl.ws.alliedtelesyn.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: catalin.marinas@gmail.com, git@vger.kernel.org
To: Zane Bitter <zane.bitter@alliedtelesis.co.nz>
X-From: git-owner@vger.kernel.org Wed Nov 24 01:39:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PL3OC-0004bh-8X
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 01:39:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756285Ab0KXAjD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Nov 2010 19:39:03 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50915 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755171Ab0KXAin convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Nov 2010 19:38:43 -0500
Received: by qwb7 with SMTP id 7so198677qwb.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 16:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GE9DvpVDep7nrieWu5LGJ77i4BfsZX5LIAT/fpP6uFc=;
        b=b9Rm75PFc5M0QgN70Wm8DuWuxTObULaeiGIwj9kX2AaxmuxoJTLSLVILcw0gWGWjc1
         IZI3KEE1NSIA+G8VwpClk7hWU4wTmLjQ/tx+8ujiAvmjNeE0d3X4YnenKPdFSQirL3E8
         /u6HR8uotiYNSu6+WYSO0sw6z+AMa8KeV9FJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=umU1SxGRHaDYcf2ha450i+yBsoZYbWRoOLp+JQV/jwbGSFTeLFQCHw9lISnD8/TyjY
         IUIV5O+GVhmEKQx4yLutBBeKA8li6o4ggOfy0vqPVT6qEtk+JYWDp3Oq+W0AI/Rk3AZb
         Ij3q1ji3rkUIQnxRwOzNG+vnz+zC7OLceiVUY=
Received: by 10.229.232.15 with SMTP id js15mr6814999qcb.161.1290559122072;
 Tue, 23 Nov 2010 16:38:42 -0800 (PST)
Received: by 10.229.41.207 with HTTP; Tue, 23 Nov 2010 16:38:41 -0800 (PST)
In-Reply-To: <20101123154538.12513.39180.stgit@zaneb-dl.ws.alliedtelesyn.co.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162038>

Hi Zane,

On Wed, Nov 24, 2010 at 4:46 AM, Zane Bitter
<zane.bitter@alliedtelesis.co.nz> wrote:
>

I'm not sure about how Catalin runs stgit, but in for git having a
Signed-off-by: line is mandatory and usually indicates that the patch
considered ready for inclusion and acts as the "developers certificate
of authenticity" (i.e. it is the developers own work or the developer
has based it on other compatibly licensed code).

A commit message would also be nice but in this case I think it just
does what it says on the tin.

=46or the reviewers I can add that I've been using Zane's patch for a
while now and it works well for me (although I'm not exactly a vim
guru).

> ---
>
> =C2=A0contrib/vim/README =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 11 ++++++++++
> =C2=A0contrib/vim/ftdetect/stg.vim =C2=A0 =C2=A0 | =C2=A0 44 ++++++++=
++++++++++++++++++++++++++++++
> =C2=A0contrib/vim/syntax/stgedit.vim =C2=A0 | =C2=A0 40 +++++++++++++=
++++++++++++++++++++++
> =C2=A0contrib/vim/syntax/stgmail.vim =C2=A0 | =C2=A0 33 +++++++++++++=
++++++++++++++++
> =C2=A0contrib/vim/syntax/stgnew.vim =C2=A0 =C2=A0| =C2=A0 33 ++++++++=
+++++++++++++++++++++
> =C2=A0contrib/vim/syntax/stgsquash.vim | =C2=A0 40 ++++++++++++++++++=
+++++++++++++++++
> =C2=A06 files changed, 201 insertions(+), 0 deletions(-)
> =C2=A0create mode 100644 contrib/vim/README
> =C2=A0create mode 100644 contrib/vim/ftdetect/stg.vim
> =C2=A0create mode 100644 contrib/vim/syntax/stgedit.vim
> =C2=A0create mode 100644 contrib/vim/syntax/stgmail.vim
> =C2=A0create mode 100644 contrib/vim/syntax/stgnew.vim
> =C2=A0create mode 100644 contrib/vim/syntax/stgsquash.vim
