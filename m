From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] merge: add instructions to the commit message when editing
Date: Mon, 30 Jan 2012 22:43:00 +0100
Message-ID: <878vkoamu3.fsf@thomas.inf.ethz.ch>
References: <7vd3a1caxb.fsf@alter.siamese.dyndns.org>
	<0c9a880c7dca27520f957446c6b0e72e93609b03.1327954927.git.trast@student.ethz.ch>
	<7vy5soaons.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 22:43:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrz0K-0005Ld-Dq
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 22:43:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446Ab2A3VnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 16:43:06 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:20823 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751975Ab2A3VnF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 16:43:05 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 30 Jan
 2012 22:43:01 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (80.219.158.96) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 30 Jan
 2012 22:43:02 +0100
In-Reply-To: <7vy5soaons.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 30 Jan 2012 13:03:35 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [80.219.158.96]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189430>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> The sentence about justification is one of the few things about
>> standard git that are not agnostic to the workflow that the user
>> chose.
>
> We try to be agnostic at plumbing level, but I do not think we ever made
> such a promise at the Porcelain level like "git merge". On the contrary,
> we try to encourage good workflows by coding behaviours to support BCP to
> Porcelain commands.  Am I misreading what you were trying to say here?

Oh, I was just trying to preempt a possible argument why this is wrong.
Maybe I was a bit over-eager in doing so ;-)

>> +static const char merge_editor_comment[] =
>> +N_("Please enter the commit message for your merge commit.  You should\n"
>> +"justify it especially if it merges an updated upstream into a topic\n"
>> +"branch.\n"
>> +"\n"
>> +"Lines starting with '#' will be ignored, and an empty message aborts\n"
>> +"the commit.\n");
>
> I am tempted to rewrite this a bit, perhaps something like ...
>
>   Please enter the commit message for your merge commit.  Explain
>   why the merge is necessary, especially if it merges an updated
>   upstream into a topic branch.
>
> ... because people who need to be told to "justify it" would probably be
> helped by a more explicit "explain _why_ it is needed".

Why not.  The "explain..." might be construed as a bit too coercive, but
I cannot come up with a way to defuse it (well, except again tacking on
"you should") and yours is certainly much clearer.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
