From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] am --abort: merge ORIG_HEAD tree into index
Date: Mon, 17 Aug 2015 07:54:46 -0700
Message-ID: <CA+55aFzvw4ogQCUpEQXtOrpbvehXiVHTfQsPDk0-ZhEaEchm2Q@mail.gmail.com>
References: <CA+55aFwDkQAS8ULiLt9N5NVOYJ242Nd2MOWeiRX8HrVHXf2zog@mail.gmail.com>
	<CA+55aFwwD=K-i9d40N5FtnTLT-ApZOzmgnXhnuA=C0zw2eBt3Q@mail.gmail.com>
	<03631611149f05dbcd862b4c1e8e9d6b@www.dscho.org>
	<20150817094819.GA10375@yoshi.chippynet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 16:54:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRLoJ-0006VP-Vi
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 16:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753631AbbHQOys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 10:54:48 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:34383 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752794AbbHQOyr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 10:54:47 -0400
Received: by iodb91 with SMTP id b91so153504876iod.1
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 07:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=yvbfg6mj9Yie+9SxLPHxWWc5+b+idqlNA6acvUy/xCE=;
        b=LldBSQsP0BM+CQ7OX3gRKu1FUxWpnljQ2ccSZoDhAjkPk9AetaSTDgiha3PNdg/4Xw
         hwnae+1rEnrDgrPtbAFTf6cJuclHaze69uGmoRiGCu9+uxdJGgusDJvJZNeLqJEsnQVW
         8zABlF+V/1uIiJhGa71yOcXHooo+ZDRx6AvqdvifWM/CG7R28Oig05X2jdtuJFgEwm8n
         IWpdicsLTv4jPZP+507ww4SNjKVO3DYtsFPVK8KSklcFjbjPu93nCAFs+PSQuh+Gg190
         dpEEZ1D95l8SgGwNfcEFkCMSn/3zTY2AGJt7RFwS1WWI/UenXp6Kc2KYzmnk602Hbker
         E6AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=yvbfg6mj9Yie+9SxLPHxWWc5+b+idqlNA6acvUy/xCE=;
        b=E17Vv4JRVFiC0lovmQtQw5RLBtyAzQR0t6QlDarXSot40EwL42Pbrvw/T2BZwP2Vn2
         RW7GAtJeSnEOLekfP3sonbaog+xgSp8jLDH/vXSe249eAET3UVzQfdRMqm3NNzwlxHYC
         lEFOSBPerPFwdD+uzp0DqTDsqbMwvalPsseXc=
X-Received: by 10.107.167.134 with SMTP id q128mr2073114ioe.137.1439823286451;
 Mon, 17 Aug 2015 07:54:46 -0700 (PDT)
Received: by 10.36.219.130 with HTTP; Mon, 17 Aug 2015 07:54:46 -0700 (PDT)
In-Reply-To: <20150817094819.GA10375@yoshi.chippynet.com>
X-Google-Sender-Auth: flS0azwxZY1lNAOvAl0JoPWbWPw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276054>

On Mon, Aug 17, 2015 at 2:48 AM, Paul Tan <pyokagan@gmail.com> wrote:
>
> It's true that we need to merge the ORIG_HEAD tree into the index
> instead of overwriting it. Patch below.

Seems to work for me. Thanks,

                     Linus
