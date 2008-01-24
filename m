From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [StGit PATCH] Homogenize buffer names
Date: Thu, 24 Jan 2008 09:51:27 +0100
Message-ID: <87ejc71u9c.fsf@lysator.liu.se>
References: <20080124075530.25461.20753.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>,
	Karl =?utf-8?Q?Hasselstr?= =?utf-8?Q?=C3=B6m?= 
	<kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 10:21:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHyGj-0008RI-Ep
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 10:21:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579AbYAXJUi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2008 04:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752883AbYAXJUi
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 04:20:38 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:42160 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579AbYAXJUf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jan 2008 04:20:35 -0500
X-Greylist: delayed 1746 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Jan 2008 04:20:35 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id D3C61200A234;
	Thu, 24 Jan 2008 09:51:27 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 16944-01-24; Thu, 24 Jan 2008 09:51:27 +0100 (CET)
Received: from krank (unknown [87.96.142.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 4E126200A225;
	Thu, 24 Jan 2008 09:51:27 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id 5330B7B4077; Thu, 24 Jan 2008 09:51:27 +0100 (CET)
In-Reply-To: <20080124075530.25461.20753.stgit@yoghurt> ("Karl =?utf-8?Q?H?=
 =?utf-8?Q?asselstr=C3=B6m=22's?= message of "Thu\, 24 Jan 2008 08\:55\:59
 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71608>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> It was driving me crazy that I couldn't tab-complete "*stg" to
> "*stgit*" because there was always a "*stgit edit*" buffer lying
> around.

At least I have been annoyed by it as well. So I think it's an ok
change.

> Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
>
> ---
>
> David, do you agree with this fix?
>
>  contrib/stgit.el |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
>
> diff --git a/contrib/stgit.el b/contrib/stgit.el
> index 4d0faca..e8bbb2c 100644
> --- a/contrib/stgit.el
> +++ b/contrib/stgit.el
> @@ -293,7 +293,7 @@ Commands:
>    (let ((patch (if (stgit-applied-at-point)
>                     (stgit-patch-at-point)
>                   (error "This patch is not applied")))
> -        (edit-buf (get-buffer-create "*stgit edit*"))
> +        (edit-buf (get-buffer-create "*StGit edit*"))
>          (dir default-directory))
>      (log-edit 'stgit-confirm-edit t nil edit-buf)
>      (set (make-local-variable 'stgit-edit-patch) patch)
> @@ -313,7 +313,7 @@ Commands:
>  (defun stgit-new ()
>    "Create a new patch"
>    (interactive)
> -  (let ((edit-buf (get-buffer-create "*stgit edit*")))
> +  (let ((edit-buf (get-buffer-create "*StGit edit*")))
>      (log-edit 'stgit-confirm-new t nil edit-buf)))
> =20
>  (defun stgit-confirm-new ()
> @@ -352,7 +352,7 @@ Commands:
>  (defun stgit-coalesce (patch-names)
>    "Run stg coalesce on the named patches"
>    (interactive (list (stgit-marked-patches)))
> -  (let ((edit-buf (get-buffer-create "*stgit edit*"))
> +  (let ((edit-buf (get-buffer-create "*StGit edit*"))
>          (dir default-directory))
>      (log-edit 'stgit-confirm-coalesce t nil edit-buf)
>      (set (make-local-variable 'stgit-patches) patch-names)
>

--=20
David K=C3=A5gedal
