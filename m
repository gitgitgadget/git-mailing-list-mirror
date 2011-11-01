From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCHv2] Compile fix for MSVC
Date: Tue, 1 Nov 2011 01:36:27 +0100
Message-ID: <CABPQNSaW+ciEzAMruYVgK_y2xf=sExYiFfdbS4xonKe=h-APjA@mail.gmail.com>
References: <1320088364-25916-1-git-send-email-vfr@lyx.org> <7vd3dcq4s5.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Vincent van Ravesteijn <vfr@lyx.org>, git@vger.kernel.org,
	ramsay@ramsay1.demon.co.uk, msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 01 01:37:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RL2Ls-0000Wt-KZ
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 01:37:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755137Ab1KAAhK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Oct 2011 20:37:10 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:45713 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625Ab1KAAhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2011 20:37:09 -0400
Received: by ggnb1 with SMTP id b1so6481011ggn.19
        for <git@vger.kernel.org>; Mon, 31 Oct 2011 17:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=xOWcV7mVg5bS0H4YQT/Yp0mnT9cGJ2dpO0usUfQJtSU=;
        b=PbB9/+E6Bj+JDJJQzKCxQSqiyG8pCtUeyyQnEWzkAr604UleBgEwWyk3ECLT7lgHEa
         PHoj3B2GnDqou70l22yHUag7tse/yi/alNvcOH0tp85uoFM+cNV/5JqEat9GsNXph0iO
         wsQx2JCzYfz/73z8jkhMqGzvBKcmk2EPkcIaU=
Received: by 10.68.0.68 with SMTP id 4mr22179269pbc.51.1320107828044; Mon, 31
 Oct 2011 17:37:08 -0700 (PDT)
Received: by 10.68.71.135 with HTTP; Mon, 31 Oct 2011 17:36:27 -0700 (PDT)
In-Reply-To: <7vd3dcq4s5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184548>

On Mon, Oct 31, 2011 at 9:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Thanks. The patch looks good from a POSIX person's point of view, and I do
> not immediately see how this would break other variants of Windows build
> at least from the code inspection.
>
> So I'll queue this, but I'll leave it to you and msysgit folks to decide
> if this topic should be merged to 1.7.8-rc1, as I do not have equipment,
> expertise, nor time to judge it myself (other than the code inspection we
> have already done here).
>
> Please give me an Ack or two by the end of this week. Thanks.

The result of applying this on top of the current master (1.7.8-rc0)
compiles and seem to runs fine for me, both with the MinGW supplied by
msysGit, and MSVC (as outlined by compat/vcbuild/README). Without the
patches, it fails to build with MSVC. In addition, the changes looks
good to me. So:

Acked-by: Erik Faye-Lund <kusmabite@gmail.com>
