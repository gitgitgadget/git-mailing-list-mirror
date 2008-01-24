From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 23 Jan 2008 19:11:40 -0800
Message-ID: <7vk5lzc3yr.fsf@gitster.siamese.dyndns.org>
References: <34103945-2078-4983-B409-2D01EF071A8B@sb.org>
	<4697E0BA-7243-4C35-A384-0BD261EC21AF@sb.org>
	<20080123094052.GB6969@glandium.org> <20080123133802.GC7415@mit.edu>
	<alpine.LFD.1.00.0801230808440.1741@woody.linux-foundation.org>
	<98F90EB6-1930-4643-8C6C-CA11CB123BAA@sb.org>
	<76718490801231218i53c19e22lda34f2eec88627f8@mail.gmail.com>
	<1DC841ED-634F-412C-9560-F37E4172A4CD@sb.org>
	<76718490801231421l7b6552f8sec13f570360198b@mail.gmail.com>
	<4F906435-A186-4E98-8865-F185D75F14D4@sb.org>
	<76718490801231517h6d57e5bfkc19d394d38ad19db@mail.gmail.com>
	<DE7B2DE6-03B1-4781-92C7-096E591369A1@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>, Mike Hommey <mh@glandium.org>,
	Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Jan 24 04:12:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHsWJ-0002FZ-9z
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 04:12:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752320AbYAXDMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 22:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752220AbYAXDMJ
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 22:12:09 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35344 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031AbYAXDMG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 22:12:06 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 25321317D;
	Wed, 23 Jan 2008 22:12:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id ADDE33175;
	Wed, 23 Jan 2008 22:11:52 -0500 (EST)
In-Reply-To: <DE7B2DE6-03B1-4781-92C7-096E591369A1@sb.org> (Kevin Ballard's
	message of "Wed, 23 Jan 2008 21:05:50 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71585>

Kevin Ballard <kevin@sb.org> writes:

> As for dropping this conversation now, I'd love to. If you really want
> to drop it, I urge you to do just that - don't respond to this
> message. Read it, digest it, and then just let it sit. If this is the
> last message on the subject, that would be *wonderful*. But if you
> respond to this message then you have absolutely no ground to accuse
> me of refusing to drop it. So please, don't.

I would not have said that if I were you.  That makes you look
very bad.  The impression I get after reading the above is that
the only thing you care about is to have the last word in the
thread.

People with opinions different from you could tone their message
down and stick to a more neutral sounding statement, "This patch
works around the issue X on HFS+", but not everybody is always
nice-and-calm.  But _you_ do not have to counter fire with fire,
especially if your goal isn't to flame but is to resolve
technical issues with cool head.  As long as you do not get
upset and start the flamewar every time whenever somebody says
"This patch works around the issue only that broken crap HFS+
has due to its stupid filename corruption choice it made", when
he could just have said it in a more neutral way, we can keep
the conversation constructive and civilized.

Let me suggest an alternative, as I think this thread raged on
long enough.  When you read somebody says "HFS+ corrupts", "HFS+
is broken", "this works around the stupidity of HFS+", just take
a deep breath, pretend that you did not hear these words that
make you feel insulted.  Instead pretend that you heard "HFS+
normalizes", "HFS+ is different", and "fixes problem on HFS+".
Do not respond with "No it is not a corruption", "No, HFS+ is
not broken" and "No, that is not a work around, but is a fix"
with another long thread.

I can imagine a civilized conversation to go this way:

	Linus: This patch would hopefully work around the stupid
	and broken normalization choice HFS+ people made years ago.

	You: Ok, I tested that patch, and it does fix the issue
	for me on HFS+ for most cases, but I still have issues
	if I use character X, Y and Z.

	Linus: Yeah, that is another direct consequence of the
	stupidity of HFS+.  At this point I think the previous
	patch bends git backwards enough and I do not know if it
	is worth addressing by bending further...

	You: How about introducing this new structure so that
	these cases can be handled in a way more friendly to
	HFS+, like this patch?

	Linus: Yeah, I can buy that, it looks ugly but it would
	not hurt people on other systems.

Hmm?
