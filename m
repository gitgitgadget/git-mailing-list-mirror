From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 4/4] builtin: use builtin.h for all builtin commands
Date: Sun, 14 Nov 2010 16:01:10 +0100
Message-ID: <AANLkTi=SbqD_3yYsRGCsmSxh-B8kpupnjq0XPGjMsxdK@mail.gmail.com>
References: <1289745857-16704-1-git-send-email-avarab@gmail.com> <1289745857-16704-5-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 14 16:01:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHe5J-0004WY-4L
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 16:01:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755933Ab0KNPBc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Nov 2010 10:01:32 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:34001 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755826Ab0KNPBb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Nov 2010 10:01:31 -0500
Received: by gxk23 with SMTP id 23so2577570gxk.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 07:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=0JHlDq2TZBW+yiMikjY3oqW/fzixoU/f4RTWvGz2PTA=;
        b=ET2wHwFeh/05nwoynZQdGhFHEA9WBBdGnohiGSf2fKIzL02LlElms+nwhzFzwJ+Nef
         PWGQb/DdjVdEHdl1mmkChdS9HS7Zi58qH877kWQZS/om8m5UFcgfneURnhWMy1SXms3x
         mDwxSWZ/0T5yfGWZY59ZXaj7Ir8VtgellvhEc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=qz7qRsrcxYPuJ+zEc6QlwRYnIeX4mLw5pQv+zxozz+6apTJzqiOJ3LTkKRS7YwXZ/+
         YAZmUFCIShL3aJElL2/In07CX9iETvNltY5dDDP/zhbPFAnbAWIaQJearkDFSimVdaV0
         hhwg0zoYvI1iqAIXvxZbxqIOi7Nnk6ObQI9Bs=
Received: by 10.150.225.2 with SMTP id x2mr7721283ybg.242.1289746890832; Sun,
 14 Nov 2010 07:01:30 -0800 (PST)
Received: by 10.151.100.3 with HTTP; Sun, 14 Nov 2010 07:01:10 -0800 (PST)
In-Reply-To: <1289745857-16704-5-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161415>

Heya,

On Sun, Nov 14, 2010 at 15:44, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> diff --git a/wt-status.c b/wt-status.c
> index fc2438f..bfc97fb 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1,4 +1,4 @@
> -#include "cache.h"
> +#include "builtin.h"

Doesn't this suggest wt-status.c should be moved to builtin? Or
something like that.

--=20
Cheers,

Sverre Rabbelier
