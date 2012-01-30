From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: i18n: Avoid sentence puzzles
Date: Mon, 30 Jan 2012 22:12:34 +0100
Message-ID: <CACBZZX6HiGNGEbvCF=Ba2BwUuJ09XFn56nMnF0SDt4T_7OyOhA@mail.gmail.com>
References: <201201301231.21090.schwarzerf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Frederik Schwarzer <schwarzerf@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 22:19:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrydF-000305-1F
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 22:19:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439Ab2A3VTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 16:19:17 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:56639 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752023Ab2A3VTQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jan 2012 16:19:16 -0500
Received: by lagu2 with SMTP id u2so2472056lag.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 13:19:15 -0800 (PST)
Received-SPF: pass (google.com: domain of avarab@gmail.com designates 10.112.40.72 as permitted sender) client-ip=10.112.40.72;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of avarab@gmail.com designates 10.112.40.72 as permitted sender) smtp.mail=avarab@gmail.com; dkim=pass header.i=avarab@gmail.com
Received: from mr.google.com ([10.112.40.72])
        by 10.112.40.72 with SMTP id v8mr6094849lbk.49.1327958355052 (num_hops = 1);
        Mon, 30 Jan 2012 13:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JnWfXoxOOFI9yMZymMCvdm83B6ivLQy9QWpDXmFkE8M=;
        b=SuHTgSu0PDGlMe7l8VXzhsnZDqklPkWPj+VUbC1KpClmycFIO68Y9B9QOQlCMM0+45
         FTXq542L6Y1r3258g76pL0xi9H9H4KoVb4wwaOretAGPpSr2VyXeltr+qW7PrRnIkKSp
         RY1QiPhG5DK9VrwgEbGiR/EmIqbNAN7q/gKxM=
Received: by 10.112.40.72 with SMTP id v8mr5001672lbk.49.1327957974139; Mon,
 30 Jan 2012 13:12:54 -0800 (PST)
Received: by 10.112.30.67 with HTTP; Mon, 30 Jan 2012 13:12:34 -0800 (PST)
In-Reply-To: <201201301231.21090.schwarzerf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189428>

On Mon, Jan 30, 2012 at 12:31, Frederik Schwarzer <schwarzerf@gmail.com> wrote:
> in order to enable translators to prepare proper translations,
> sentence puzzles have to be avoided. While it makes perfect sense for
> English, some languages may have to separate those words to sound or
> even be correct.
>
> The attached patch demonstrates a change to achive that. I did not
> test it because its purpose is only to raise awareness and start a
> discussion about this topic. After all the question is, how important
> translations are for a tool like Git. I have started a German
> translation but many things are really hard to translate.

I added the i18n support you're having problems with, and I completely
agree that this is the sort of thing we need to do.

Unfortunately when I added the i18n support I didn't have time to get
rid of all these sentence puzzles (or, to put it another way "lego"
sentences). You should never force translators to translate partial
sentences, you should always provide them with full sentences that
they can translate completely, even if that means that there's some
duplication for some languages.

Problem reports like this one are exactly what we need at this point
for i18n, we need people spotting these issues, and then we can fix
them.
