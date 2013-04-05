From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/7] sha1_file, link: write link objects to the database
Date: Fri, 5 Apr 2013 13:29:35 +0530
Message-ID: <CALkWK0=VOPsPg7mC46aP_VZiUv9FD5vZZFkGYKUTjLbWXc0DDA@mail.gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
 <1365100243-13676-3-git-send-email-artagnon@gmail.com> <CALkWK0k=XYPJXEEx8CMYRx_k0d9Z=b_W=wGGvbZsXJEe8K99EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 05 10:00:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UO1Zn-00060q-Qc
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 10:00:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161573Ab3DEIAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 04:00:17 -0400
Received: from mail-ia0-f173.google.com ([209.85.210.173]:56939 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161147Ab3DEIAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 04:00:16 -0400
Received: by mail-ia0-f173.google.com with SMTP id h37so2974075iak.32
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 01:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=bxaoFzFmjJRKrI28vnARenE83Fn8TR/uNhVqQ3K4xTs=;
        b=waxirUtO5olxQRiDk2vQq9nBaj8TsVoCcwo6QlJrHR5sc8TJuUVIDqHGQddUpkZFG6
         OwhRjKdj/YW0iY+xRzV/WCf333kGe5fROc+ZZ5MHi6BUmag2vsR2OF/W+2XzoqywW1aQ
         8FXJZ859AxIF2llyhdHW3/S5tqXM0fJKLC80i1ZcA3EuegoCYWi57k7NHs5r9KiIMg2E
         akXrl3OlQ5WTT2BtsMjfDRMkn/zVs/SHwwmOFLiakNG6jGQdo4kMrF2hpgGdEemgoF/5
         aUro3J4E6gQgobBxiLKGGRPpbMhAGnNiIK5xHqLYbOFFU7mNblKjr5X/AnsYO8BpLHaF
         OeiA==
X-Received: by 10.50.117.3 with SMTP id ka3mr491804igb.107.1365148816089; Fri,
 05 Apr 2013 01:00:16 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Fri, 5 Apr 2013 00:59:35 -0700 (PDT)
In-Reply-To: <CALkWK0k=XYPJXEEx8CMYRx_k0d9Z=b_W=wGGvbZsXJEe8K99EA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220157>

Ramkumar Ramachandra wrote:
> This needs to be replaced by a .git/config parser.  However, I can't
> use the parser from config.c as-it-is, because it expects a section
> like [core] to be present.  So, we have to refactor it to optionally
> parse section-less configs.

Er, sorry about the thinko: I meant that edit-link should use the
.git/config parser.  This one is just fine.
