From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: [PATCH v3] blame: add support for --[no-]progress option
Date: Sun, 22 Nov 2015 23:15:22 -0600
Message-ID: <CAOc6etakufQKCMu-+bOe+A=GHZtjCcWMVpYj6HEKLUJzetRZMw@mail.gmail.com>
References: <1448255548-25346-1-git-send-email-eantoranz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Edmundo Carmona Antoranz <eantoranz@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 23 06:15:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0jTK-0006z4-Lu
	for gcvg-git-2@plane.gmane.org; Mon, 23 Nov 2015 06:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753203AbbKWFPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2015 00:15:23 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35458 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbbKWFPW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2015 00:15:22 -0500
Received: by pacej9 with SMTP id ej9so179505974pac.2
        for <git@vger.kernel.org>; Sun, 22 Nov 2015 21:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oQGk3GUsZaRPZtb8V3u5tl6OI8GrLQMg58MMca4BikI=;
        b=BemWzwXGBXM4pSqofcUF34TcakHvRqeakiNbKBeKf8cA6Wv8tLyKa8kzG0YhFcOwQP
         IPak7UJvkj29DhiwoqsJP6/+blYK6SEt9KOlu0zVuJaWvsGFo2PbUygi1CMrtK3930/z
         ZyNfmkNX0NQfjltVsejCvjYAIyYlNdkdvFX1nwavGo+FVXxj9Yvxc4mtEzN7GQYE1zy4
         f3yWJ0swp4MJhwSB+dWk261RxLCKN1oOgQ0hPaInVMJv1r9hLdEPWZdzC1+iAVT7JFI4
         QM6eNP6x5kqF+9hTYLesvoXa7UmI6k0crK7/jIvHgZ9/4ZshVbReYcyb+rZsuEkpYTQ5
         xB1Q==
X-Received: by 10.66.142.136 with SMTP id rw8mr33959054pab.36.1448255722269;
 Sun, 22 Nov 2015 21:15:22 -0800 (PST)
Received: by 10.66.89.42 with HTTP; Sun, 22 Nov 2015 21:15:22 -0800 (PST)
In-Reply-To: <1448255548-25346-1-git-send-email-eantoranz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281573>

On Sun, Nov 22, 2015 at 11:12 PM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> +struct progress_info {
> +       struct progress *progress;
> +       int blamed_lines;
> +};
> +

This is valid, right? Adding 2 more parameters to found_guilty_entry()
sounded like an overkill so I joined them into a new struct.

Thanks in advance.
