From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Fri, 23 Jul 2010 18:33:31 -0400
Message-ID: <AANLkTinb8YqBesa5Uh7+uuKAF0BhNjAGmvai5bNO3hV4@mail.gmail.com>
References: <4C472B48.8050101@gmail.com> <AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com> 
	<AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com> 
	<AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com> 
	<AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com> 
	<4C4778DE.9090905@web.de> <AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com> 
	<m31vavn8la.fsf@localhost.localdomain> <AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com> 
	<20100723083149.GD27082@arachsys.com> <AANLkTinBtXmMei2Q6MZrXWxa3t+_quGdzpcq46EZvgvG@mail.gmail.com> 
	<4C49B10A.8060900@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Chris Webb <chris@arachsys.com>, Jakub Narebski <jnareb@gmail.com>,
	"?var Arnfj?r? Bjarmason" <avarab@gmail.com>,
	Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Jul 24 00:34:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcQoX-0001hj-Gh
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 00:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757572Ab0GWWdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 18:33:53 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62677 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756524Ab0GWWdw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 18:33:52 -0400
Received: by wwj40 with SMTP id 40so5129160wwj.1
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 15:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=zEgQYhvnTwO7t1WR3wdu6rC9h20YbQeudk4iZnaMTWQ=;
        b=e7RaGOzAdRDPJ+QwBwiiFgitZzd8x+Ac868V2klhOdfcU//MJTTL6BO86UP4ylMnmH
         Xw7ZZqI5ynFp8QF8LWKh3UhRyy/DD/OND1AhEue7WCTCAECJ6cQE5E5M3uexYcllOX7C
         UOz2w8lVk8LCWi2WZ7VAC/ZdkBsoZGfddXsz8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=JoNWxn9TpVju5AhqV7D+EHq5/wZ0TzR8+fsMjxF1K5uRwldZ+gOvmPHFfXHUIjmj9M
         HlFKOQblRnRpd8yjVVmM7bJOTzDV6ba5jxMGV2ctdgRJYLoGSv7Nz5ahdlXfduUu++J0
         x/T27CPoRvCTjFZhQ2qe5VoSOUKDfTqLwm33U=
Received: by 10.216.159.202 with SMTP id s52mr4141340wek.33.1279924431128; 
	Fri, 23 Jul 2010 15:33:51 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Fri, 23 Jul 2010 15:33:31 -0700 (PDT)
In-Reply-To: <4C49B10A.8060900@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151580>

On Fri, Jul 23, 2010 at 11:11 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 23.07.2010 10:40, schrieb Avery Pennarun:
>> I think it would be better if we could abandon .gitmodules entirely;
>> it's really only useful for listing repository URLs, and listing
>> repository URLs is a major part of the problem.
>
> Then where do you get the URL to clone the submodule from on "git
> clone --recursive"?

If you're asking that question, you're missing my point entirely.  In
my proposed model, the submodule objects are all in the same repo as
the superproject, so there *is* no separate URL.  And thus there is no
more need for .gitmodules.

Have fun,

Avery
