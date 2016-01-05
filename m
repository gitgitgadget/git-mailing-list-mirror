From: Andrey Utkin <andrey.utkin@corp.bluecherry.net>
Subject: Re: "git send-email" thru Gmail incurs few minutes delay
Date: Tue, 5 Jan 2016 17:41:41 +0200
Message-ID: <CAM_ZknX6m1UBrMyzovhRAODMzJxBD+gk86+6fmnDJLK6PwgokA@mail.gmail.com>
References: <CAM_ZknWuOSbQcGvXaCDUKAJX7hR5FxJO3a8axPYS4ekyRiczCQ@mail.gmail.com>
	<CAMuHMdUZf2CLyzWVr+KUcgALejWpgEhUt1DMDBg614bKbFEXZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Andrey Utkin <andrey.od.utkin@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
X-From: linux-kernel-owner@vger.kernel.org Tue Jan 05 16:41:53 2016
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1aGTk7-0002Xu-Le
	for glk-linux-kernel-3@plane.gmane.org; Tue, 05 Jan 2016 16:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531AbcAEPlq (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 5 Jan 2016 10:41:46 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:33664 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077AbcAEPlm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jan 2016 10:41:42 -0500
Received: by mail-io0-f173.google.com with SMTP id q21so189885139iod.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2016 07:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=corp-bluecherry-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=H8tGqjvKuP85EUQTfgON+htVwvTR6Sbl7Je38rDKWbE=;
        b=u7mK03RcvQt1BjTQkgha2+DstI4ph9FGl6MD+ndv1QcXLq/MZV9ABzL3z79fptj/0x
         iuFZVrZIFy1UkduhyJeH8ZyqxUZr1OPoEsof2XoY5zotsf8Fp8nd6J63Xe+i4LihmbSX
         p5vvLt1RrYCScWENDJFfw8c/E1Qjni6nh1llM5G8ac3nT7bbgnG1a85YdOVoKFifqYIX
         CORGvNiiX/9PBUc2JQApoo+cqa4LY5Y0/f+JiY0dx6e+JhSmIyEYj8ow2cLbPaM+hkV0
         N8Ywx6wcy228HE+kMGqMBEB1BK063ROhfEZoUELueH8i23lo2LQ1kA6Oq8g5fQ2QENoT
         g/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=H8tGqjvKuP85EUQTfgON+htVwvTR6Sbl7Je38rDKWbE=;
        b=Jo6NPhb3eDyMbElMRlAT8/Yskpl4vdKgEawIfKi1NGR99wFM2MAWFKqPRola6D4wbb
         wgQorf1/EHmRCabAhufBTOYJlH9fvRNYzYO8C/D1KeGVu2BfrVvx5VbLH4nzD6NRXc63
         MFYrXR6sxY0vAU6pGH5l0As1Fzue25FHqVblxQpGmmnFa9kzNSvsB+kNuDBv4Kh9Rkek
         sTSVhEyIN0nOYxn3AH4awvjb8TybAyTU5lrLBpsGQAlAM+9dx2yb3g2B+UGVrgHB7mH9
         APQdePxSgYl376g+WwcTsfMYxVMTCUhIyB+KOCpcXV/nx88GbF7MrCLQiaSkmGojC0ec
         e4Kw==
X-Gm-Message-State: ALoCoQk2Yp6cf5hAZ+fS2/uYtFoKPOJVipgS4FZu68d5MfYfV7ml7eEI2fQMad5kXZF4s2fR+O/iBq+zXO8olH5jSG9LtEGLVVLzrn6PqvI9pquIXBeXtcQ=
X-Received: by 10.107.8.20 with SMTP id 20mr96322129ioi.34.1452008501868; Tue,
 05 Jan 2016 07:41:41 -0800 (PST)
Received: by 10.107.201.13 with HTTP; Tue, 5 Jan 2016 07:41:41 -0800 (PST)
In-Reply-To: <CAMuHMdUZf2CLyzWVr+KUcgALejWpgEhUt1DMDBg614bKbFEXZw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283382>

On Tue, Jan 5, 2016 at 1:27 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Does it work better if you store the (preferably app-specific) password in
> smtppass in .gitconfig?

No.
