From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] completion: be nicer with zsh
Date: Thu, 02 Feb 2012 16:17:18 -0800
Message-ID: <7vhaz8vkhd.fsf@alter.siamese.dyndns.org>
References: <1328145320-14071-1-git-send-email-felipe.contreras@gmail.com>
 <20120202084859.GC3823@burratino> <7v8vklvxwh.fsf@alter.siamese.dyndns.org>
 <CAMP44s1gWNG+jJ6M7OnLS-1VA5YPa07LJfnrvdbsQb0MOJB7PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 01:17:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt6qQ-0001T7-9m
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 01:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755451Ab2BCARc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 19:17:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34674 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755398Ab2BCARV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 19:17:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C97660C2;
	Thu,  2 Feb 2012 19:17:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nBupIKjVzmmkUjs1gcAx/b4yuls=; b=ECB+wP
	iDC/HOdZ/5gmMuvxHFoBV/uccMmKPfT4Q9CE2OzUpyYaBf9NTiJ4piB/X0Rv0Q5f
	WeXnavqyJonzmZgeVWifrxGgRGPi44SNvj6xcAMZPXaDG56Ks4oazHYg52nHxJ77
	VxeXeUpbNaq1vp2iho4dBVUt5GLLQQqjolEqI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mMFvnFGQnOsUCzTq+JnfRghHuNyj3/BU
	wiaPdBoLFFasK2GDRLSQJ/nv9+NWZgGAugpWOztBcQtnatggXW8nzYMSqPKBr2Ch
	/4L7mmDvP2w0aCdeSihZGE/1lgaZAK8qmFBQRFIQzgcwxqk2hUK2ya9BR+pzFy3w
	dB6Iq8IP4hI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63F7F60C1;
	Thu,  2 Feb 2012 19:17:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C30DB60C0; Thu,  2 Feb 2012
 19:17:19 -0500 (EST)
In-Reply-To: <CAMP44s1gWNG+jJ6M7OnLS-1VA5YPa07LJfnrvdbsQb0MOJB7PA@mail.gmail.com> (Felipe
 Contreras's message of "Thu, 2 Feb 2012 22:45:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6FA670CE-4DFC-11E1-9A44-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189722>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, Feb 2, 2012 at 9:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>> However, clearly I did not say it clearly enough. :) I guess it's
>>> better to take a cue from storytellers and show rather than tell.
>>
>> Very big thanks for this ;-)
>
> Not a single comment regarding what I said?

What entitles you to force me to refraining from commenting at all until I
read everything in my mailbox and after waiting for a while to make sure
there is no more to come to the thread?

In any case, "be nicer with zsh" conveys no more meaningful information
than "this is some patch about zsh".  Let's try to avoid warm and fuzzy
words that imply "goodness", e.g. "improve" and "be nicer with" because
nobody sends a patch to purposefully make Git worse and expects it to be
applied.

I found Jonathan's alternative "avoid default value assignment on : true
command" at least a bit better for the purpose of jogging the short-term
memory in the "'git shortlog v1.7.9.. contrib/completion/' tells us that
we have applied several patches, and I remember that : ${var=word} one!"
sense.  It is not super-useful for the longer term, though.

Here is what I ended up in preparation for queuing the series.  I still
haven't seen any version of 4/4, but please check $gmane/189683 and see if
that matches what you intended.  Also I am assuming $gmane/189606 relayed
by Jonathan is a squash between your 2 and 3 (which didn't reach me), so
please advise if that does not match what you want to have.

Thanks.

-- >8 --
From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] completion: work around zsh option propagation bug

zsh versions from 4.3.0 to present (4.3.15) do not correctly propagate the
SH_WORD_SPLIT option into the subshell in ${foo:=$(bar)} expressions.  For
example, after running

	emulate sh
	fn () {
		var='one two'
		printf '%s\n' $var
	}
	x=$(fn)
	: ${y=$(fn)}

printing "$x" results in two lines as expected, but printing "$y" results
in a single line because $var is expanded as a single word when evaluating
fn to compute y.

So avoid the construct, and use an explicit 'test -n "$foo" || foo=$(bar)'
instead.  This fixes a bug tht caused all commands to be treated as
porcelain and show up in "git <TAB><TAB>" completion, because the list of
all commands was treated as a single word in __git_list_porcelain_commands
and did not match any of the patterns that would usually cause plumbing to
be excluded.

[jn: clarified commit message, indentation style fix]

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1496c6d..c636166 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -676,7 +676,8 @@ __git_merge_strategies=
 # is needed.
 __git_compute_merge_strategies ()
 {
-	: ${__git_merge_strategies:=$(__git_list_merge_strategies)}
+	test -n "$__git_merge_strategies" ||
+	__git_merge_strategies=$(__git_list_merge_strategies)
 }
 
 __git_complete_revlist_file ()
@@ -854,7 +855,8 @@ __git_list_all_commands ()
 __git_all_commands=
 __git_compute_all_commands ()
 {
-	: ${__git_all_commands:=$(__git_list_all_commands)}
+	test -n "$__git_all_commands" ||
+	__git_all_commands=$(__git_list_all_commands)
 }
 
 __git_list_porcelain_commands ()
@@ -947,7 +949,8 @@ __git_porcelain_commands=
 __git_compute_porcelain_commands ()
 {
 	__git_compute_all_commands
-	: ${__git_porcelain_commands:=$(__git_list_porcelain_commands)}
+	test -n "$__git_porcelain_commands" ||
+	__git_porcelain_commands=$(__git_list_porcelain_commands)
 }
 
 __git_pretty_aliases ()
-- 
1.7.9.172.ge26ae
