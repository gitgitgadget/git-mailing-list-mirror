From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] completion: Add PS1 configuration for submodules
Date: Tue, 7 Dec 2010 13:15:35 +0100
Message-ID: <AANLkTin8JstkjEWaCGZuqpEXZnLMyudFm24K7Y3iCgX6@mail.gmail.com>
References: <1291677763-55385-1-git-send-email-scott@appden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Scott Kyle <scott@appden.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 13:15:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPwSM-0000H2-BS
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 13:15:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629Ab0LGMPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 07:15:37 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43568 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142Ab0LGMPg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 07:15:36 -0500
Received: by fxm20 with SMTP id 20so5251779fxm.19
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 04:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=fjZF1btyReoMxTOxIYYKhbS2GJbQVmDBl7c8FAF7rPE=;
        b=TlYayHcBXoJdTSyLzB6yzm4uR/Vf8AmguFkpX8ZxMgIi0p0+O5i9q/OVqeUrRwn3ZU
         TWJhJbP3xAUz5fFrTXh6ICmmf62hcjiHDTsodz16hlb75Dcq218HM32O3JyVLiZavzt2
         E0wDVAvKiLUM9GPJkjaptbZfmCgpP6r9WB8aQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=jyeidG3nKKtnPbzQGFeKKLzRCCZxup1ZD2L4zlG8SM0zLN0ORwC+RL4ERVWWTe12xg
         GEN6425cCWLr1cgVFvlrAwlda5CItP1GkVGAs0NT3VOTtr1nLttAVb2fVzu+U+GXtpqJ
         AbnajxGhOHym8TREtp+FarwFJ6bBCe4Dis5MA=
Received: by 10.223.69.140 with SMTP id z12mr1458589fai.142.1291724135389;
 Tue, 07 Dec 2010 04:15:35 -0800 (PST)
Received: by 10.223.74.207 with HTTP; Tue, 7 Dec 2010 04:15:35 -0800 (PST)
In-Reply-To: <1291677763-55385-1-git-send-email-scott@appden.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163076>

On Tue, Dec 7, 2010 at 00:22, Scott Kyle <scott@appden.com> wrote:
> For those who often work on repositories with submodules, the dirty
> indicator for unstaged changes will almost always show because development
> is simultaneously happening on those submodules. The config option
> diff.ignoreSubmodules is not appropriate for this use because it has larger
> implications.

Wouldn't it be a lot better to instead add support for showing
submodule dirtyness as distinct from the main tree's dirtyness? Then
you could easily spot if you had either your tree / submodule tree
changes, without just ignoring them.
