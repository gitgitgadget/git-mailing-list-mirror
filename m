From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Default for color.ui (was Re: is this a bug of git-diff?)
Date: Wed, 15 May 2013 05:37:11 -0500
Message-ID: <CAMP44s2PAzoDEJ3WP0WQet8QiXs4qq83U8JUdLx+VthcC7nbUQ@mail.gmail.com>
References: <CABwUO_X8oTzuJh8+v3Oqca2W4ht-cQRNGQ+a1DbEruq5jY+vgA@mail.gmail.com>
	<CALWbr2z338CJgavC9sVGffHSoqr0Sb9nCsr4LKURDYpkOog2TQ@mail.gmail.com>
	<CABwUO_Wyq34S=CwbLeAqmzaFLxORkvGEvrjUzMXjkJdE1jnbhA@mail.gmail.com>
	<CALWbr2z2jB53=2UsEneqymU2peiL4OW9Tyace_8BN3=1gA9jNg@mail.gmail.com>
	<vpqhai4y4b2.fsf@grenoble-inp.fr>
	<20130515095025.GV2299@serenity.lan>
	<vpq61yky2zp.fsf_-_@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>,
	Antoine Pelisse <apelisse@gmail.com>,
	eric liou <accwuya@gmail.com>, git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 15 12:37:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcZ5I-0006l7-Vx
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 12:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755850Ab3EOKhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 06:37:14 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:57434 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699Ab3EOKhN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 06:37:13 -0400
Received: by mail-la0-f50.google.com with SMTP id ed20so1580338lab.37
        for <git@vger.kernel.org>; Wed, 15 May 2013 03:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=kc2rKPrKcbHvkXcSDTf+ZvZvcswcE8sVweSNGgK2ZRA=;
        b=JrKyq75WGKTQ7iwEHbCQzi4J2biEQqblCPwMdHa5JXwMritqM0lzRSfaGaocwxJiRK
         iJGprzjpL7jA7KcqmNJiYc8wOSfdQp3kVYxBZgpLFLKn2qhx8JW7S0h4sxJokR5wg7Z2
         IzpA08l6o9y6HCCenZyvIRz7P0lIqpNKK5hALI44WSzwxrLoX89+7SSR1mg8cGm+u+Zw
         dlh8D4e7/fZpk41lpvCYxtLqC8Fsat70NOdWWGZmnTO1G5TdYu8eQFL556qSfwHdQoDE
         VfenPdXKzxBvor8PSdCN5h9u9iXrYJG/K7hzea8/YvCZMqjBbFaVhJFeD3QWsjf/WaeZ
         qnJQ==
X-Received: by 10.152.3.103 with SMTP id b7mr8154904lab.8.1368614231818; Wed,
 15 May 2013 03:37:11 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Wed, 15 May 2013 03:37:11 -0700 (PDT)
In-Reply-To: <vpq61yky2zp.fsf_-_@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224395>

On Wed, May 15, 2013 at 5:03 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> John Keeping <john@keeping.me.uk> writes:
>
>> I wonder if that should be the default.  I've advised a lot of people to
>> turn it on and it seems to me that a user is much more likely to go
>> looking for a "turn color off" option than realise that color is an
>> option at all.
>
> I'd love to see this by default, yes. Maybe a 2.0 change?
>
> If people agree that this is a good change, would we need a transition
> plan? I'd say no, as there is no real backward incompatibility involved.
> People who dislike colors can already set color.ui=false, and seeing
> colors can hardly harm them, just temporarily reduce the comfort for
> them.

I vote for this. It's the first thing I do in any setup, even the ones
that are note mine. I've also seen it in basically all the tutorials,
even before setting user.name/email.

I also don't see the point of a transition plan.

-- 
Felipe Contreras
