From: =?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>
Subject: Re: [PATCH 4/4] cat-file: print tags raw for "cat-file -p"
Date: Mon, 25 Feb 2013 21:33:28 +0200
Message-ID: <CAPWNY8V=OT_Rt0GfhrmEhf_bqqMhCSR4EDCiX0FOr8EZSPkAUA@mail.gmail.com>
References: <20130225183009.GB13912@sigill.intra.peff.net> <20130225185058.GD14438@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 25 20:34:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA3oQ-0008HV-F0
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 20:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759448Ab3BYTdp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Feb 2013 14:33:45 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:59706 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759188Ab3BYTdp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Feb 2013 14:33:45 -0500
Received: by mail-la0-f46.google.com with SMTP id fq12so3077098lab.19
        for <git@vger.kernel.org>; Mon, 25 Feb 2013 11:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=Qu/edHcOzzcf+kJZd7NSzdTUFTQOV34q9FcZXUz25Cw=;
        b=tCUqVuZwz/0+Jz+gyiyKaTlaW4KTPEJDdhs/5Aa9GkujDxm2HYZl99+q/7n7dcDmpO
         2Bkblu0j9PcybWGsZyU943xM8HOTdmaRHDHy8kU2le8cj0x64XIY8bK8/YJvt/KGu0CD
         5sX2K6OxgxkK8Z8VOkuwtnYw2bhH+fCUPabzomD82Eyl+wZVo3GRj5BqZwrqgYws7bIQ
         NM8u/mzIMcgtVXCmGPi82M/GCJEZmHpu/5ZF1E/WMil6H/QNrdknCMZotthiwOLIKWJ1
         eNDfmPTc4/iHoaz5diRglQe8XnSNIDZApRYIjvvWgGubZ4R4TNOZKi/fp9MD6mLW/L6U
         n9xQ==
X-Received: by 10.112.13.200 with SMTP id j8mr4847073lbc.68.1361820823525;
 Mon, 25 Feb 2013 11:33:43 -0800 (PST)
Received: by 10.112.17.47 with HTTP; Mon, 25 Feb 2013 11:33:28 -0800 (PST)
In-Reply-To: <20130225185058.GD14438@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217094>

On Mon, Feb 25, 2013 at 8:50 PM, Jeff King <peff@peff.net> wrote:
> Note that "git verify-tag" and "git tag -v" depend on
> "cat-file -p" to show the tag. This means they will start
> showing the raw timestamp. We may want to adjust them to
> use the pretty-printing code from "git show".
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I don't use "git tag -v" much, so I'm not sure what is sane there. Bu=
t
> this seems like it would be a regression for people who want to check
> the human-readable date given by GPG against the date in the tag obje=
ct.

Personally, I've found it quite confusing that commits (incl. merged
tags) can be verified with `git show --show-signature`, but for tags I
must use `git tag -v`... took me a while to find the latter.



(`git show --verify` might be even better, but that's just me.)

--=20
Mantas Mikul=C4=97nas <grawity@gmail.com>
