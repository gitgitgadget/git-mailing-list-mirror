From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-stash: RFC: Adopt the default behavior to other commands
Date: Mon, 17 Dec 2007 16:31:12 -0800
Message-ID: <7vfxy04ze7.fsf@gitster.siamese.dyndns.org>
References: <20071217110322.GH14889@albany.tokkee.org>
	<506C6191-655D-46AE-A5C2-1335A9044F44@lrde.epita.fr>
	<7vk5nd53lp.fsf@gitster.siamese.dyndns.org>
	<57F403E7-AF5B-40F1-AE9D-8EA036675A67@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Harl <sh@tokkee.org>, git@vger.kernel.org
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Tue Dec 18 01:32:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4QNg-00008p-GD
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 01:32:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937019AbXLRAbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 19:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936991AbXLRAba
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 19:31:30 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33732 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936858AbXLRAb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 19:31:29 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BE89C2305;
	Mon, 17 Dec 2007 19:31:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E802D2302;
	Mon, 17 Dec 2007 19:31:19 -0500 (EST)
In-Reply-To: <57F403E7-AF5B-40F1-AE9D-8EA036675A67@lrde.epita.fr> (Benoit
	Sigoure's message of "Tue, 18 Dec 2007 00:32:05 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68672>

Benoit Sigoure <tsuna@lrde.epita.fr> writes:

> On Dec 18, 2007, at 12:00 AM, Junio C Hamano wrote:
>
>> Benoit Sigoure <tsuna@lrde.epita.fr> writes:
>>
>>> ...  The current behavior of git stash is very
>>> dangerous ...
> ...
>> This is a plain FUD, isn't it?  The first Oops should not happen these
>> days.
>
> *git pull in git*
> *reads Documentation/RelNotes-1.5.4.txt*
>
> Blah.  I didn't know follow the development over the past 3 weeks well
> enough, sorry for the noise.  I'm glad that this was improved.

But the original point by Sebastian hasn't been answered.  He wanted to
make the command list the stash without arguments.

This was discussed already in the early days of stash and there indeed
was a suggestion to do so (I think I sided with that), but the users did
not want it.  IIRC, the argument went like: "when I say 'stash', that is
because I want a quick and immediate way to stash, and I do not want a
list.  If I do not have to have a quick way, I would create a temporary
commit on the current branch, or switch to a temporary branch and commit
there."
