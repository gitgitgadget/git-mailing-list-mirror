From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 14/44] ruby: bind dwim_ref()
Date: Sun, 29 Sep 2013 10:47:58 +0530
Message-ID: <CALkWK0mutBpqvu31uZARUFtGzN6zwP4A=915u=xBoc+PXQp+_A@mail.gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com> <1380405849-13000-15-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 29 07:18:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ9PE-0003NE-RQ
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 07:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323Ab3I2FSl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Sep 2013 01:18:41 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:35634 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073Ab3I2FSk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Sep 2013 01:18:40 -0400
Received: by mail-ie0-f169.google.com with SMTP id tp5so7641854ieb.28
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 22:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YQsAklPU95sRIo9NtIBqD5jaHOGxMZZQ0zf2JLNxH90=;
        b=iGadmxtZ19K2yXenespSV7lYD70Ym/XkoygDqGQE7U4d6QS0A8zidcSYV1V5ayaI0j
         8HlGe/qBYjCy6cSrO57bGsB7m+u+bFO5BEE5F0GvOvRlihv0yKV8abnlJJ5jkLesJd3U
         k/asSWSEHVUDhbGvC6x7a2P9d1024lyv1GaM7Px80Bb8VSSxGVzKTZpAdS5sERBTY3Vo
         32d2QeLCPU00ePd6ntdDnOG1EhRgyeFeQPI9JCGKrMvOlqkkqkeNyhliZdW9t6fKMiXR
         gY+gBN0LLoLcWzXn6Hlb/uTy19N8asAN5fybU7BHQQWfLtTxa/rXdowG6GTD3E/nRsJG
         YkPQ==
X-Received: by 10.50.97.35 with SMTP id dx3mr8800157igb.55.1380431919577; Sat,
 28 Sep 2013 22:18:39 -0700 (PDT)
Received: by 10.64.73.36 with HTTP; Sat, 28 Sep 2013 22:17:58 -0700 (PDT)
In-Reply-To: <1380405849-13000-15-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235590>

Felipe Contreras wrote:
>  static void git_ruby_init(void)
>  {
>         rb_define_global_function("setup_git_directory", git_rb_setup_git_directory, 0);
>         rb_define_global_function("for_each_ref", git_rb_for_each_ref, 0);
> +       rb_define_global_function("dwim_ref", git_rb_dwim_ref, 1);
>  }

At this point, global functions is probably the way to go. We might
like to put them in classes to create a beautiful Rugged-inspired API
in the future.
