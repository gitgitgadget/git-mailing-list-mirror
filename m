From: Johan Herland <johan@herland.net>
Subject: Re: Recording the current branch on each commit?
Date: Mon, 28 Apr 2014 18:38:35 +0200
Message-ID: <CALKQrgeFJf5RZTR7df1CeAAta1vdjDccj2Y+zXTfzCS9Zy9SYQ@mail.gmail.com>
References: <535C47BF.2070805@game-point.net>
	<CALKQrgfmBByMwMhxu3HkJqJGWy2Rwvij6Hi1_4npjfsxcSgpaQ@mail.gmail.com>
	<535D4085.4040707@game-point.net>
	<CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com>
	<87zjj656my.fsf@fencepost.gnu.org>
	<535E276E.8090306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Kastrup <dak@gnu.org>, Jeremy Morton <admin@game-point.net>,
	Git mailing list <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 18:39:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Weoa2-00019G-VE
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 18:38:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756672AbaD1Qir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 12:38:47 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:39790 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756580AbaD1Qim (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 12:38:42 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1WeoZk-0001It-1T
	for git@vger.kernel.org; Mon, 28 Apr 2014 18:38:40 +0200
Received: from mail-pb0-f51.google.com ([209.85.160.51])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1WeoZj-000Glx-5h
	for git@vger.kernel.org; Mon, 28 Apr 2014 18:38:39 +0200
Received: by mail-pb0-f51.google.com with SMTP id rq2so1114920pbb.10
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 09:38:35 -0700 (PDT)
X-Received: by 10.69.15.2 with SMTP id fk2mr26469322pbd.123.1398703115274;
 Mon, 28 Apr 2014 09:38:35 -0700 (PDT)
Received: by 10.70.59.4 with HTTP; Mon, 28 Apr 2014 09:38:35 -0700 (PDT)
In-Reply-To: <535E276E.8090306@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247380>

On Mon, Apr 28, 2014 at 12:03 PM, Sitaram Chamarty <sitaramc@gmail.com> wrote:
>> Johan Herland <johan@herland.net> writes:
>>> Obviously, the feature would necessarily have to be optional, simply
>>> because Git would have to keep understanding the old commit object
>>> format for a LONG time (probably indefinitely), and there's nothing
>>> you can do to prevent others from creating old-style commit objects.
>
> Johan: I seem to have missed your previous email (fat-fingered something
> on my mail client I expect).
>
> Your **reasons** for making it optional are all wrong.  People like me
> (and David) who are opposed to this run the risk that if the **format**
> were to officially change in some way or for some reason (like, say, if
> SHA1 is no longer in favour, or whatever), then this "feature" is
> foisted on us willy-nilly.
>
> That's not good.
>
> So, while I appreciate your point that it should be optional, please
> let's accept that in the end it should be optional because **not
> everyone likes it**!

You may have missed more than just one previous email... I tried (but
obviously failed) to make it clear from the start that I personally
don't support this feature (although, as long as it's optional I'm
mostly indifferent to it).

Trying to steer the discussion towards a constructive end, I then
argued that even IF we were to agree that this was a good change (and
this thread CLEARLY demonstrates that we DO NOT agree), it would STILL
be better to first implement this change within the confines of the
existing object model, without making any changes to Git itself.

Having done an initial implementation "outside" of the git core (which
should be fairly straightforward with hooks + git-interpret-trailers),
Jeremy would have gotten the feature he wanted (or at least a close
approximation), and we could then observe if this feature became
popular/useful enough to consider integrating it into core Git.

So, the only constructive way forward (whether we like the feature or
not) is for Jeremy (or someone else) to first implement it "outside"
the Git core.

THIS is my point, and I really, REALLY tried to explain it while
AVOIDING the inevitable flamewar about what "belongs" in a commit
object or not. It's not that I don't have an opinion on that subject;
it's that everybody has their own opinion, and it's largely a
philosophical discussion that boils down to peoples workflows,
preferences, backgrounds, and whatnot. As such, it's perfect material
for the flamewar we're currently observing...


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
