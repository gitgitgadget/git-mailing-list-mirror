From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Maintaining historical data in a git repo
Date: Mon, 2 Apr 2012 13:38:17 +0200
Message-ID: <CACBZZX46d8rx4ueY3-mNHfZ7T-zrw8rKsRG7VAoGZSbYEvOpiw@mail.gmail.com>
References: <CA+P+rLeyEcZPudhLWavB74CiDAqpn+iNkk4F8=NK_yGaJPMmyA@mail.gmail.com>
 <201203301510.q2UFAqn6003864@no.baka.org> <CA+P+rLcWT0SZQjW2LtFXXCDRwjMp8daJ2hVup=7cnsRGbKw7xw@mail.gmail.com>
 <7vehsam3pn.fsf@alter.siamese.dyndns.org> <CA+P+rLeDFu4KgEZPw=k67iMWVVGcZ3q48VZjgXNLXn3NdyQnow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Yuval Adam <yuv.adm@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 13:38:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEfau-0006hI-Ju
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 13:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346Ab2DBLik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 07:38:40 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:38544 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807Ab2DBLij (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 07:38:39 -0400
Received: by eekc41 with SMTP id c41so813081eek.19
        for <git@vger.kernel.org>; Mon, 02 Apr 2012 04:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7zQ+gf1JPN2mZzfFXWPNboP3nt+IV5FGnBo/zhXa+jA=;
        b=Hf5J8z/KK8KJWa7t2mvVP6vMqvtJ2O09c/Mo2cPzIJIR031xK0JLbya9skrzTyKWHd
         OM4qJnYIL94Fk7DeaubQ2gYys4wc2sX0OQgAEsDZ1C/QWGIUzZqbeJhC25n5s0MIa3+c
         pu9AsTkTfWtw4qUaz1majmOgPJJ5oO2MWioPfn0n0veVA9IUuokCyPyV0t7mGgaa0Ieu
         ulZQ+DObRk94CoBGjqAXSit1ho6FVCGtP7qvxLZNkwRQxfHvLTK8YIt/KJ6GJS/e+NsY
         R0uoxm2Bfd4mK/uVoKiLb8GzDyVcs8/jhPspei7bZ66HRzw4uUYorji1bsVRz6N8pJxi
         ADog==
Received: by 10.14.99.10 with SMTP id w10mr1135359eef.51.1333366718063; Mon,
 02 Apr 2012 04:38:38 -0700 (PDT)
Received: by 10.213.103.1 with HTTP; Mon, 2 Apr 2012 04:38:17 -0700 (PDT)
In-Reply-To: <CA+P+rLeDFu4KgEZPw=k67iMWVVGcZ3q48VZjgXNLXn3NdyQnow@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194510>

On Fri, Mar 30, 2012 at 22:39, Yuval Adam <yuv.adm@gmail.com> wrote:
> However, we perceive git as a very powerful tool, that can fit
> beautifully with the way legislation works today.
> The challenge for us - should we choose to accept it ;) - is to build
> a set of wrapper tools that allow us to use git in such a way, while
> enabling us to build up past history.

You can always solve this by having two repositories, you have one
canonical Git repository with your laws using some text-based format
to describe when each change was added.

You'd never rewrite the history of this repository since it would
represent the history of your project to give a commit timeline to the
law, and not attempt to make your commit log reflect changes in the
law.

You could then have tools to export another Git history from that
original repository, that one would be constantly rewritten and nobody
would base changes on that.

You could also make the two one and the same, but you don't have to.
