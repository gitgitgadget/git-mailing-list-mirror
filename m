From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 2/2] Mention "git blame" improvements in release notes
Date: Mon, 28 Apr 2014 19:39:05 +0200
Message-ID: <87y4yp4ame.fsf@fencepost.gnu.org>
References: <1398470210-28746-1-git-send-email-dak@gnu.org>
	<1398470210-28746-2-git-send-email-dak@gnu.org>
	<7vmwf8huey.fsf@alter.siamese.dyndns.org>
	<87zjj86j4a.fsf@fencepost.gnu.org>
	<xmqqzjj5s8hs.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:12:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeqyE-00085L-3Y
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753873AbaD1TLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:11:31 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:41432 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834AbaD1TL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:11:28 -0400
Received: from localhost ([127.0.0.1]:38946 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WepWD-0000i7-UC; Mon, 28 Apr 2014 13:39:06 -0400
Received: by lola (Postfix, from userid 1000)
	id 7C097E05FE; Mon, 28 Apr 2014 19:39:05 +0200 (CEST)
In-Reply-To: <xmqqzjj5s8hs.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 28 Apr 2014 09:51:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247389>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>>> Thanks, but no thanks---I do not see it tasteful.
>>
>> Well, begging rarely is....
>> ...
>> If that's not worth anything to the Git community,...
>
> Concurred on the first point.  If you thought in any way I meant
> to say that blame improvements do not matter, then I am sorry, I did
> not mean that.
>
> But still, I am not convinced that the release notes is a good place
> to do this, and would be happier if you can think of a better venue.

"This change has been contributed by an independent developer on a
contingency base.  To make this approach work, please contact him if you
consider it worth recompensating."

This sort of text can be placed in the commit message (where it will be
mostly visible to actual other developers) and in the "What's cooking"
reports while, well, it's cooking.  It won't reach the mass of "ordinary
users", but while they are quite a large audience, they are also least
likely to care enough about isolated performance changes.  And while it
will be a limited run, "What's cooking" is also read by non-developers.

Those are the two venues I can currently think of that would seem
"scalable", at least with a text of that size.  Namely where it would
not become quite a total nuisance (though naturally less effective) if
everybody tried doing the same.

-- 
David Kastrup
