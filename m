From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 7/7] rebase: implement --[no-]autostash and rebase.autostash
Date: Mon, 13 May 2013 13:57:45 +0530
Message-ID: <CALkWK0kRW07qW_A1Rcyx7gML9ZNJ=g-hvE1O==zFpzToQtTg3g@mail.gmail.com>
References: <1368359801-28121-1-git-send-email-artagnon@gmail.com>
 <1368359801-28121-8-git-send-email-artagnon@gmail.com> <vpq1u9be18t.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon May 13 10:28:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubo7T-00014k-C9
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 10:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499Ab3EMI21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 04:28:27 -0400
Received: from mail-bk0-f54.google.com ([209.85.214.54]:45388 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218Ab3EMI20 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 04:28:26 -0400
Received: by mail-bk0-f54.google.com with SMTP id it16so78525bkc.13
        for <git@vger.kernel.org>; Mon, 13 May 2013 01:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=jd1zH++mI3B1KntbPmCBeG54iFuld+rCLGqm9NijZjA=;
        b=jM4dziwMGjHl7xBQCq51dG+X/7B5Z3U1J6YI0SnhynDPGch5PBM0gxoq7yUR7PDJHe
         jNkzQAchoheH+WqRUkhhzhUxD1B6YOmXKLMIo7K+HSGDp0jf+zLYM+daeigwR8px9fh+
         b8etFPsO9HwbX/tXekwuGgku4/dqNI029F0kpj6LymvEJl8jX4q6JqvHuPEo5kODgl46
         8HMcMJKpw2bSNG+x11p5Nv4o4GvJoST2nR3EcaQzEQkK7g3zHHElavHM4DYn2O+zFu2T
         twazYQ0TwhabslvNTQiVjZ3B/CerLVLskx6/LKkmnKSan8cPu2S0aXOoZkIR0tDT1Lek
         Yk/g==
X-Received: by 10.205.34.132 with SMTP id ss4mr5250113bkb.125.1368433705458;
 Mon, 13 May 2013 01:28:25 -0700 (PDT)
Received: by 10.204.172.209 with HTTP; Mon, 13 May 2013 01:27:45 -0700 (PDT)
In-Reply-To: <vpq1u9be18t.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224111>

Matthieu Moy wrote:
> Any reason why this is not using gettext and the other messages do.
>   You can run "git stash apply" or "git stash drop" at any time.

Fixed.  Thanks.
