From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Revert "dir.c: don't exclude whole dir prematurely if neg
 pattern may match"
Date: Fri, 8 Jan 2016 19:12:30 +0700
Message-ID: <CACsJy8Bg+xnKxkq8-Da4-GKUWAOjGB6xyya+zzydhMWBEPPT8g@mail.gmail.com>
References: <1452254725-22314-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 08 13:13:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHVup-0005Wq-JM
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 13:13:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754357AbcAHMNB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jan 2016 07:13:01 -0500
Received: from mail-lf0-f53.google.com ([209.85.215.53]:35937 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795AbcAHMNB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jan 2016 07:13:01 -0500
Received: by mail-lf0-f53.google.com with SMTP id i124so6205273lfe.3
        for <git@vger.kernel.org>; Fri, 08 Jan 2016 04:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=LUw7c7iEtefG+Ssfmi5KZdvzsRSvqQ8sY+K7sBT9cuo=;
        b=qm62uSWLQwnTY1O1quY2CFP6ylOnYZeZ+NWR4wq2v7rh/LFPNLHPhKJ31Mw/u97EbQ
         2go9T0GsyZH+t/v1GpBm7OU2BrlWkY9rSI1P2exm73z+0UUifbBkNtc3zFwlP5tS7sNI
         X/oboK82nnAlKOvX67UV6lk6skzxT1MZe2o+juAORTXqHTGaCpP/g3IvyBhCUmjcSw0G
         XrGJiSTgj84NjXS3Kyz5dMuvbLlJ2+j7k4MOTDYkk4oJ5pBAg66T9JNMVfB89f/b57A/
         fKhuzVCrS45t2jyPZwAsLl/IbUorFCqDESiOKEnKciU/m3Fn9OvReWCERr3UKzGUWtes
         ULHw==
X-Received: by 10.25.17.229 with SMTP id 98mr14877097lfr.3.1452255179690; Fri,
 08 Jan 2016 04:12:59 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Fri, 8 Jan 2016 04:12:30 -0800 (PST)
In-Reply-To: <1452254725-22314-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283550>

On Fri, Jan 8, 2016 at 7:05 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> patterns are too loose. The untracked listing and sparse-checkout
> selection can become incorrect as a result.

These two lines should be this instead if you want to keep track of
problem references. I amended the commit then forgot to format-patch
again.

patterns are too loose. The untracked listing [1] and sparse-checkout
selection [2] can become incorrect as a result.

[1] http://article.gmane.org/gmane.comp.version-control.git/283520
[2] http://article.gmane.org/gmane.comp.version-control.git/283532
--=20
Duy
