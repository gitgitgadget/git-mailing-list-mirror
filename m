From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v7 03/10] Add colors to interactive git-clean
Date: Mon, 13 May 2013 10:47:41 +0800
Message-ID: <CANYiYbGqZ6FiHTZgejrA3a-njffQNJyaefFmCWfycuE6PGjwbA@mail.gmail.com>
References: <ad26375dece854339d64dcb82c17f19f8edccf48.1368011946.git.worldhello.net@gmail.com>
	<6a7931a0bb14f8c71479e16175812bedb6b826cb.1368011946.git.worldhello.net@gmail.com>
	<cover.1368011946.git.worldhello.net@gmail.com>
	<d7302adabb4269dd94698090fb20c739f723f00a.1368011946.git.worldhello.net@gmail.com>
	<vpqfvxsi0gw.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon May 13 04:47:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubinj-0000m6-Ti
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 04:47:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753804Ab3EMCrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 22:47:43 -0400
Received: from mail-wg0-f53.google.com ([74.125.82.53]:56195 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753424Ab3EMCrn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 22:47:43 -0400
Received: by mail-wg0-f53.google.com with SMTP id y10so6036486wgg.32
        for <git@vger.kernel.org>; Sun, 12 May 2013 19:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=xJU+3rXV0YIfLgOXTkoW60QX3vwbOWvWPTPt+aRjCGw=;
        b=yqp+i+5unnmegHdZlJzaI1E1TB+2z6R7E1tIOXKLZxiM5Bv/PCL5mrFuXG6MDnFW8R
         uJibvpknNepErxUYO5giUodvZ3MwGs+oTk4xBZlcJq2n2S8hYw90qaFyJlR8yarowrqE
         xx3uPkGk/MJBtYunhEU5MAoBHqGm1/L7VLP7lTLwdy8XqgFLQglc8FJuL19dC6YU2sg+
         lccwwVGA2pBjDkRZzaaqMK81wjmXpLqONgPwzcOeqzV32QfXeYQ3MMkEVu9j1M7Dh9aq
         nYuPZ/KudVmrIuqABcBxQfEYs5aoXADFG95grU6YDh8t0dRZTjY/EJZgiPYP8RaNE5Uk
         n7Lg==
X-Received: by 10.194.59.132 with SMTP id z4mr36863647wjq.57.1368413261990;
 Sun, 12 May 2013 19:47:41 -0700 (PDT)
Received: by 10.194.175.72 with HTTP; Sun, 12 May 2013 19:47:41 -0700 (PDT)
In-Reply-To: <vpqfvxsi0gw.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224077>

2013/5/13 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
> Jiang Xin <worldhello.net@gmail.com> writes:
>
>>  * color.interactive.<slot>: Use customized color for interactive
>>    git-clean output (like git add --interactive). <slot> may be
>>    prompt, header, help or error.
>
> This should go to the documentation (a short summary is welcome in the
> commit messages in addition, but users won't read this...)
>
>> +     if (!prefixcmp(var, "color.interactive.")) {
>> +             int slot = parse_clean_color_slot(var, 18);
>
> For readability and maintainability: please use
> strlen("color.interactive."), not 18.

Feel like conventional:

    git grep -C2 prefixcmp builtin/apply.c builtin/archive.c
builtin/branch.c builtin/checkout.c

But maybe 18 characters are too long. ;-)


-- 
Jiang Xin
http://www.worldhello.net/
