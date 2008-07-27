From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-scm.com
Date: Sun, 27 Jul 2008 11:33:29 -0700
Message-ID: <7v3alv2n46.fsf@gitster.siamese.dyndns.org>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>
 <7v3alxr0fd.fsf@gitster.siamese.dyndns.org>
 <d411cc4a0807251759m1d83d7c4w4724806b19f7c02a@mail.gmail.com>
 <7vsktwfu5z.fsf@gitster.siamese.dyndns.org>
 <20080727113707.GC32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Jul 27 20:41:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNBBD-0001Tq-NF
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 20:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbYG0Sdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 14:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbYG0Sdi
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 14:33:38 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49922 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbYG0Sdh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 14:33:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A445B3F2F8;
	Sun, 27 Jul 2008 14:33:36 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 83BA63F2F7; Sun, 27 Jul 2008 14:33:32 -0400 (EDT)
In-Reply-To: <20080727113707.GC32184@machine.or.cz> (Petr Baudis's message of
 "Sun, 27 Jul 2008 13:37:07 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 86794854-5C0A-11DD-976D-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90353>

Petr Baudis <pasky@suse.cz> writes:

>> If you are going to list 30 or so top contributors in 8 rows times 4
>> columns, because visually the columns are much more distinct than the
>> rows, it makes the result look more sorted.  This is the same reasoning
>> hwo "git help --all" was fixed with 112d0ba (Make "git help" sort git
>> commands in columns, 2005-12-18).
>
> Actually, this is strange for me: I would never think about reading git
> help --all by rows, and I would never think about reading the authors
> list by columns! It's difficult for me to point out why, possibly
> because the authors list has less items per row and the items are longer
> (and multi-word), but that's just a speculation. Maybe cultural
> background (Japanese books are written in columns, right?) plays some
> role too, I don't know.

I do not think the default mode of "ls" output to tty (aka "ls -C") was
invented by/for Japanese people.

>> And for the "giving credit" purpose, I do not think truncating the list at
>> 5 commits or less threshold, as suggested earlier and already done, makes
>> much sense, either.
>
> The point here is that the list is awfully long and also can contain
> a lot of duplicates or people with broken unicode, etc. - it gets hard
> to maintain, and it makes the about page too long. I would be of course
> fine with a tiny link at the bottom "(show all contributors)".

Your "incentive to move up" argument suggests otherwise.  Even if it takes
efforts to maintain on somebody's part, it is worth to be inclusive, *IF*
the purpose of that bottom list is to give credits to people.

The list on the site originally was not utilizing .mailmap and I asked
Scott to use it to merge duplicate entries, which he did.  People whose
names are misspelled and/or split will now have incentive to tell Scott
about the problem so that they can clean up *their* own names, and Scott
can help maintaining .mailmap and feed the changes to me.

This is my ulterior motive behind this suggestion; I can outsource the
maintenance of .mailmap to people who care about it more than myself.
