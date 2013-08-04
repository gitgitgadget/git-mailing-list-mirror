From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-hg: Fix cloning and sharing bug
Date: Sun, 4 Aug 2013 09:24:44 -0500
Message-ID: <CAMP44s1AsxRHZGNwBuX2SA+akh=onkiOnBGU7J=qen3Kp_ZzpA@mail.gmail.com>
References: <1A5ABD76-D3D9-400E-AC8F-26C0DEF43723@joernhees.de>
	<1375612683-9104-1-git-send-email-apelisse@gmail.com>
	<478CA849-148C-4F73-A64F-9A5829523CC3@joernhees.de>
	<CAMP44s2DhS=B3fTD-FCrkUK=h4hWuBN6n6mqEws2qh=YiBegJw@mail.gmail.com>
	<CALWbr2zYD-ELajVkybQfbqXTJSu67K=Y1v3SdtTgCPZHaO46BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?J=C3=B6rn_Hees?= <dev@joernhees.de>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 04 16:25:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5zF9-0003Ud-4O
	for gcvg-git-2@plane.gmane.org; Sun, 04 Aug 2013 16:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877Ab3HDOZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Aug 2013 10:25:00 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:47462 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199Ab3HDOYr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Aug 2013 10:24:47 -0400
Received: by mail-lb0-f179.google.com with SMTP id v1so1463190lbd.38
        for <git@vger.kernel.org>; Sun, 04 Aug 2013 07:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oDKLV3iXOJfaiJ2Zlx6hGYq2WV/UNDq5pgOqO8eXbIU=;
        b=0SV8rgSKlsr5oHe6cP8iC7rjFYoqcZEia4TcT1n8wEjEhkVuVdBoQLuDI01j+8Hr/m
         74odYQzsU2rio+8M07nKCatklMTNL+LkpOTKyKZtuaAl+++Wkox74opaIoOakV54MSk/
         dqDeOrCUZ4mtFoplE4FFLGSFzCjZAoONuRs569WH8NHwfqFSt+D4zYERx9BrfNLvezAt
         AAjCOLxWlKbMM4+NqtBaLI/CpxAbGkNG93xBGAgl2TWJnGY4KsbehRkgHmOVw1S4/x/g
         yyHGX11F3FkZhcOjwvDht8DtcJfxCp9thunRjXleId+pUsUUqe1yjrj26H7DQUQFX79P
         By3w==
X-Received: by 10.152.20.130 with SMTP id n2mr2250280lae.47.1375626284082;
 Sun, 04 Aug 2013 07:24:44 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sun, 4 Aug 2013 07:24:44 -0700 (PDT)
In-Reply-To: <CALWbr2zYD-ELajVkybQfbqXTJSu67K=Y1v3SdtTgCPZHaO46BA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231631>

On Sun, Aug 4, 2013 at 8:59 AM, Antoine Pelisse <apelisse@gmail.com> wrote:

> Would you mind squashing your changes into a patch ?

I actually would, and I'm not going to explain why because people get
offended way too easily in this mailing list.

Maybe later.

-- 
Felipe Contreras
