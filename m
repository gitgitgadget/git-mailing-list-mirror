From: David Kastrup <dak@gnu.org>
Subject: Re: What is missing from Git v2.0
Date: Fri, 25 Apr 2014 17:59:26 +0200
Message-ID: <871twl9z8h.fsf@fencepost.gnu.org>
References: <CAHYYfeHeJYZ67chSTQk2grsFGr07KXcVNR-T6kOPo0bVYDm59g@mail.gmail.com>
	<53588f448d817_59ed83d3084e@nysa.notmuch>
	<CAHYYfeFKW93GH+6-ssR5L_uoo3OL2-LFAsj-4+8uEmL0BhT3ow@mail.gmail.com>
	<5358bae8ab550_1f7b143d31037@nysa.notmuch>
	<877g6fb2h6.fsf@fencepost.gnu.org>
	<5358ca1a55a69_1f7b143d3101c@nysa.notmuch>
	<20140424134106.GA27035@thunk.org> <20140424195559.GA1336@luc-arch>
	<CALZVapn0gEHc7t2fjk7YGd2o0yfpGLu0JCgUtdREvROC8_mqXg@mail.gmail.com>
	<87d2g69ekl.fsf@fencepost.gnu.org> <20140425154104.GB11479@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Javier Domingo Cansino <javierdo1@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 17:59:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdiXX-0005yK-Bb
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 17:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815AbaDYP7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 11:59:41 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:36192 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbaDYP7j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 11:59:39 -0400
Received: from localhost ([127.0.0.1]:35234 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WdiXK-0002KR-Ri; Fri, 25 Apr 2014 11:59:39 -0400
Received: by lola (Postfix, from userid 1000)
	id 65AA5DF3E1; Fri, 25 Apr 2014 17:59:26 +0200 (CEST)
In-Reply-To: <20140425154104.GB11479@google.com> (Jonathan Nieder's message of
	"Fri, 25 Apr 2014 08:41:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247049>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi,
>
> David Kastrup wrote:
>> Javier Domingo Cansino <javierdo1@gmail.com> writes:
>
>>> = Reject non-fast-forward pulls by default =
>>> Not having this introduced yet allows newbie people to use git with
>>> just 4 commands, without bothering around with fetch and merge and so.
>>
>> If you have a gun lying around your house, you should turn the safety
>> catch off or the children will not be able to use it without
>> instruction.
>
> I probably missed a subtlety, but the above comment reminded me of
> some netiquette I think this list is starting to forget.  If I have
> misread it, please let me know and skip the rest of this message.
>
> This is a comment about style, not substance.  Like coding style,
> discussion style matters as a way of making life easier for
> maintainers and new contributors, and different projects have subtly
> different practices.
>
> On the git list, the rule is simple.  Feel free to grumble, but make
> sure there is some contribution in the same message.  For example,
> after the confusing gun analogy you can say "How about this patch?"
> and people reading can follow up by reviewing that patch and
> potentially getting it applied.

Uh, Javier was commenting on a number of concrete proposals regarding
the subject line "What is missing from Git v2.0" and quoted Felipe
directly.  As you seem to have lost the context, let me requote the
respective portion:

    From: Felipe Contreras <felipe.contreras@gmail.com>
    Subject: What is missing from Git v2.0
    Newsgroups: gmane.comp.version-control.git
    To: git@vger.kernel.org
    Date: Sun, 20 Apr 2014 17:41:05 -0500 (4 days, 17 hours, 12 minutes ago)

    [...]

    = Reject non-fast-forward pulls by default =

    Many new-comers end up making merges by mistake when they pull
    because they don't understand what is a non-fast-forward and what
    they should actually be doing. Most people, even Linus Torvalds,
    agreed that by default `git pull` should fail and guide the user,
    instead of silently making a merge which might not be what the user
    wants (even though he doesn't know it), and messing up the project's
    history, which affects other people.

    The patches were sent, the issues were addressed, people agreed, and
    yet nothing happened.

    [3][4]

    [...]

    [3] http://thread.gmane.org/gmane.comp.version-control.git/240030
    [4] http://thread.gmane.org/gmane.comp.version-control.git/235981


> "How do I get feedback on design of a new change without wasting a lot
> of time coding something that might be a bad idea?"  Glad you asked.

I didn't.

> "What about reminders about known bugs?  There's this regression and
> it would not be right to release without fixing it but I think it's
> fallen through the cracks."  Yes, good contribution.
>
> "What about jokes?"  Sure, making people laugh is productive.
>
> "What about cryptic grumbling?"  Sorry, unless you are grumbling to
> get input on how to improve git's documentation or code, it's not
> enough to be worth sending an email to this list.
>
> Hope that helps,

No need to get condescending if you did not get the joke.

-- 
David Kastrup
