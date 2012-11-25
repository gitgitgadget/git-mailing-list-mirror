From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Sun, 25 Nov 2012 12:19:19 +0100
Message-ID: <CAMP44s1oRpm4QkhcbfAuxK8UTZnuSVfNhAQnmUd1xiwhwLEqGw@mail.gmail.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
	<CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
	<20121125095356.GA22279@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Sun Nov 25 12:19:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcaFR-0002gi-2u
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 12:19:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091Ab2KYLTU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 06:19:20 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:64743 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838Ab2KYLTT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 06:19:19 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so9969217oag.19
        for <git@vger.kernel.org>; Sun, 25 Nov 2012 03:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FhrsjoLLo+4OK4FJPQFaBjjAb30DPuYWakTD6C1TFK4=;
        b=GHtealEM3RCI4iS1QE7IOjwyIpXLGRiXgH411dSVYqhCqMScvl5Gmwkq5SaGjV9Bs2
         K0J7tjFyniht6/w/MMuubgzA2hdUFLgIFyap8klIjZemzluZOymuEpRcv5D5AfK2BEDM
         D2lfS7NKtaZi2RUHe0GV1zzVTxitMJNwUgO4dC/S1i+n5tptmMYlkIFn5XY2WVQMqZrg
         CsrZ0jf5ffGoTxgOmmN3FW7o/TppZYlIPgwmjiGz/0ZDXzBh3ZTsQayYyLqtddMD2tIY
         uJfj8mCWQjRr/rpGB+s/8fjoU5+HKYcNtP5CzVqlSMME44huRd4QOCWJQtG5BFhsjz9n
         MJGA==
Received: by 10.60.30.70 with SMTP id q6mr6664035oeh.103.1353842359313; Sun,
 25 Nov 2012 03:19:19 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Sun, 25 Nov 2012 03:19:19 -0800 (PST)
In-Reply-To: <20121125095356.GA22279@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210363>

On Sun, Nov 25, 2012 at 10:53 AM, Eric S. Raymond <esr@thyrsus.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com>:
>> If your friends jump off a bridge, would you? Yes, using python has
>> served them well, but as opposed to what? Other scripting languages? I
>> don't think so.
>
> The competition that Python won was *precisely* against other scripting
> languages, notably shell and Perl.  Both used to be much more heavily
> used in system scripting than they are now.

Against shell and perl yes, not against the rest.

>> What if my extension only supports python 2.7? Or what if my extension
>> wants to support 2.0?
>
> I propose that if 2.6 can't support it, then that should be considered
> grounds to reject it.

Seems sensible, but I don't know what "rejection" would actually mean.
My "extensions" are on the way to the contrib area. Is the contrib
area supposed to have different rules? I don't know.

Either way, making a script work on python 2.6 is probably easier than
trying to "reject" it.

>> Yes, they should _if_ they know what version they need. In my
>> extensions I really have no idea.
>
> Then you shouldn't submit those extensions to be folded into core git.

Too late.

>> > 3) We should be unconditionally be encouraging extensions to move
>> > from shell and Perl to Python.  This would be a clear net gain is
>> > portability and maintainability.
>>
>> NO! It's up to the developer to choose what language to use,
>
> I agree.  You seem to be raising a lot of straw men.  'Encouragement'
> does not equate to beating anyone who makes an unpopular choice over
> the head.

I don't see what this means in practical terms. People are going to
write code in whatever language they want to write code in. How
exactly are "we" going to "encourage" them not to do that is not
entirely clear to me.

I don't think there's such a thing as "git leadership" that would be
able to take these policy decisions, and if there was one, I don't
think the evidence presented would be enough to weigh in either way.

> I am also not suggesting that the whole git core ought to be hoicked
> over to Python.  I was thinking mainly about extension subcommands,
> not what's in libgit now.

Subcommands are also probably more efficient in c. And lets remember
that most people use git through the *official* subcommands.

Cheers.

-- 
Felipe Contreras
