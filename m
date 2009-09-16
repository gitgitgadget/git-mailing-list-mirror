From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 13/14] Add README for MSVC build
Date: Tue, 15 Sep 2009 22:22:09 -0300
Message-ID: <a4c8a6d00909151822p6f9d8dffr9391d7e58077de2@mail.gmail.com>
References: <cover.1253021221.git.mstormo@gmail.com>
	 <ffd7cfd6114f08c6502b21140d56d9bcd5d2a554.1253021728.git.mstormo@gmail.com>
	 <4924c3de4fa490d1f41b75d18864f0a57fbd0eda.1253021728.git.mstormo@gmail.com>
	 <88c817f030cfcc1e3b9e08f80d7ccfbcdfad7ecb.1253021728.git.mstormo@gmail.com>
	 <8bcd4b022f59a5f55b63f87c9cf6a4dadc71cc44.1253021728.git.mstormo@gmail.com>
	 <606db5a89cc49818fa225312a3bb6dbda18867a6.1253021728.git.mstormo@gmail.com>
	 <65347d022ba857d57d3c081f28b239b9b665c587.1253021728.git.mstormo@gmail.com>
	 <cover.1253021728.git.mstormo@gmail.com>
	 <9fc49662e1ec00388adb3d50c41d20561ed58939.1253021728.git.mstormo@gmail.com>
	 <22e0abb5a1e91c3ca95f8538d8396c167bb1028d.1253021728.git.mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com, raa.lkml@gmail.com,
	snaury@gmail.com
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 03:22:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnjDz-00083B-IF
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 03:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587AbZIPBWN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Sep 2009 21:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbZIPBWM
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 21:22:12 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:34451 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019AbZIPBWM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Sep 2009 21:22:12 -0400
Received: by yxe1 with SMTP id 1so6048142yxe.21
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 18:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+HblVm8RtUPQkQXgFlkgmu7+uSBPonssYHVOP1EkzFk=;
        b=rLcf3XPdiiZEkgW+ZlQZePh/4QsKlbEAwgC+NiSZPdqyDbv/QQdOHOXYDgpI28vmPq
         9EBi8rPdkYxLa2ZE28/EG/gprQC0fPMnWhVFyc7l44vvXRDzOCYzLjlm4bMBSg/haOIc
         5gxbuoPs3IRYG7fNjce8rG2x9vZdYJWmZ4LnE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=keHDsCXUmAG3X0cugoZ51wa+RfDQ+UY+fr7YXKGrI+RFMgKSUONQdeEAl6/xB3Jngi
         4I9nnifsltsBKMGcfledgO+qzVnjQ/CYosZl6DDmiP3KIspAW2N9GRuAVdlTYbIczpJl
         XalxDoDFVqKBsp0RbffS1Y2y7wJ4lXOOB0UGQ=
Received: by 10.101.47.6 with SMTP id z6mr8284203anj.140.1253064130032; Tue, 
	15 Sep 2009 18:22:10 -0700 (PDT)
In-Reply-To: <22e0abb5a1e91c3ca95f8538d8396c167bb1028d.1253021728.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128601>

On Tue, Sep 15, 2009 at 10:44 AM, Marius Storm-Olsen <mstormo@gmail.com=
> wrote:
> Based on original README patch from Frank Li
>
> Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
> ---
> =A0compat/vcbuild/README | =A0 39 +++++++++++++++++++++++++++++++++++=
++++
> =A01 files changed, 39 insertions(+), 0 deletions(-)
> =A0create mode 100644 compat/vcbuild/README
>
> diff --git a/compat/vcbuild/README b/compat/vcbuild/README
> new file mode 100644
> index 0000000..5d7a07a
> --- /dev/null
> +++ b/compat/vcbuild/README
> @@ -0,0 +1,39 @@
> +The Steps of Build Git with VS2008
> +
> +1. You need the build environment, which contains the Git dependenci=
es
> + =A0 to be able to compile, link and run Git with MSVC.
> +
> + =A0 You can either use the binary repository:
> +
> + =A0 =A0 =A0 WWW: http://repo.or.cz/w/msvcgit.git
> + =A0 =A0 =A0 Git: git clone git://repo.or.cz/msvcgit.git
> + =A0 =A0 =A0 Zip: http://repo.or.cz/w/msvcgit.git?a=3Dsnapshot;h=3Dm=
aster;sf=3Dzip
> +
> + =A0 and call the setup_32bit_env.cmd batch script before compiling =
Git,
> + =A0 (see repo/package README for details), or the source repository=
:
> +
> + =A0 =A0 =A0 WWW: http://repo.or.cz/w/gitbuild.git
> + =A0 =A0 =A0 Git: git clone git://repo.or.cz/gitbuild.git
> + =A0 =A0 =A0 Zip: (None, as it's a project with submodules)
> +
> + =A0 and build the support libs as instructed in that repo/package.
> +
> +2. Ensure you have the msysgit environment in your path, so you have
> + =A0 GNU Make, bash and perl available.
> +
> + =A0 =A0 =A0 WWW: http://repo.or.cz/w/msysgit.git
> + =A0 =A0 =A0 Git: git clone git://repo.or.cz/msysgit.git
> + =A0 =A0 =A0 Zip: http://repo.or.cz/w/msysgit.git?a=3Dsnapshot;h=3Dm=
aster;sf=3Dzip
> +
> + =A0 This environment is also needed when you use the resulting
> + =A0 executables, since Git might need to run scripts which are part=
 of
> + =A0 the git operations.
> +
> +4. Inside Git's directory run the command:
Shouldn't be 3.?
> + =A0 =A0 =A0 make common-cmds.h
> + =A0 to generate the common-cmds.h file needed to compile git.
> +
> +5. Then build Git with the GNU Make Makefile in the Git projects roo=
t
4.?
> + =A0 =A0 =A0 make MSVC=3D1
> +
> +Done!
> --
> 1.6.2.1.418.g33d56.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
