From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Zile as git core editor?
Date: Fri, 26 Apr 2013 16:28:25 +0800
Message-ID: <CALUzUxpZ9=8aVEMBfFUH2hN5ZkwzKVX31J79MVzkCEGRX++LPw@mail.gmail.com>
References: <877gjp91w5.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Thorsten Jolitz <tjolitz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 10:28:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVe1Y-0007Gg-8v
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 10:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215Ab3DZI2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 04:28:52 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:37701 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932147Ab3DZI2p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 04:28:45 -0400
Received: by mail-ie0-f179.google.com with SMTP id 16so4587886iea.38
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 01:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=IgUlTSTRV53Hqz0Gxi10qpmup8UzZZHkzii6B5QhGgQ=;
        b=K5rap7hl+c5USC6PH7zQPWqWe+l2fw0zP8aff0Z4SdQzjgctNa3HLSXavB7CJre+Yr
         ciPJhc69fHhoM9mbTsZdd/iWnCj81qkQoOJAF+52SD/2ZRA/JxFHSJaRBWQxrfY17Kdp
         KMNyOIUwrV9SNH/SAJsY2CfJIQjNZ8kojKbSgZB7u+Y9ADUkVlbbIb0deUP+n4yN/iST
         dhM60XdsbhfvMErGZMw2wlqN7dHuX669Lv1Oov3ACcBTlZ2FmFL5Y/thBxyI8Jt6pNxD
         EG4nWxNLZSmDWgSZDESiAb9Pl8OvyrWvhHH8kBO0me8UgNJ2OURLmvYRerClhb9aTmIp
         WgKA==
X-Received: by 10.50.154.105 with SMTP id vn9mr1246759igb.8.1366964925253;
 Fri, 26 Apr 2013 01:28:45 -0700 (PDT)
Received: by 10.64.44.165 with HTTP; Fri, 26 Apr 2013 01:28:25 -0700 (PDT)
In-Reply-To: <877gjp91w5.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222510>

Hi,

Is the GIT_EDITOR or EDITOR environment variable set? They may be
overriding the core.editor setting.

--
Cheers,
Ray Chuan

On Fri, Apr 26, 2013 at 3:39 PM, Thorsten Jolitz <tjolitz@gmail.com> wrote:
>
> Hi List,
>
> after experiencing one crash to many, I'm back to Standard Emacs
> (instead of Emacsserver/Emacsclient), thus using 'emacs' (instead of
> emacsclient) as git core editor triggers reading my huge init file and
> is way to slow.
>
> I would like to use Zile (a small Emacs clone) instead, and although
> otherwise it works alright on my system, it does not seem to work as git
> core editor.
>
> Is it possible to use 'git config --global core.editor zile'?
>
> --
> cheers,
> Thorsten
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
