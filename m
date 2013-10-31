From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/16] pull: cleanup documentation
Date: Thu, 31 Oct 2013 13:43:35 -0700
Message-ID: <xmqqfvrh41e0.fsf@gitster.dls.corp.google.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
	<1383211547-9145-4-git-send-email-felipe.contreras@gmail.com>
	<xmqqiowd71kv.fsf@gitster.dls.corp.google.com>
	<CAMP44s3AKnZUJy0O0Hg+G=ER2bRn1nHMBeoJQ=ugCzO4d2WZ-g@mail.gmail.com>
	<xmqqob655kqi.fsf@gitster.dls.corp.google.com>
	<ADB546B4-992E-4B54-953E-B721BECD19B2@quendi.de>
	<xmqqzjpp447x.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Thu Oct 31 21:43:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbz5o-00034B-Sx
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 21:43:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755477Ab3JaUnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 16:43:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40668 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755473Ab3JaUnj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 16:43:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81BF54D4BA;
	Thu, 31 Oct 2013 16:43:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xbXXXzI4xmSs7UEqd7GLPuEjRTo=; b=surQiQ
	nrosjLsexMiB0J0IZElciRqC5FkQeLUxtS1/gWq4XbqIAffdRX52vFigKU++tBXn
	0UvML/NKCQbHpkx3oyiuKCbYgSyVGmxCN3opQKA1P/C5nssXhZCMtq3vVSfhg+5q
	OkQLmKTrAEhnUqiqCk636Ic3SZ2FM+DQvIH8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R1Npls6eLlTRdwrdbv6onDyFWWO1RoR8
	Ol/r+IQRH5mzYwusTquTwrZuwt1bDf7hCc94Z7V5hLk0MUJ+jY1bBbHV9DAT47s/
	9pAzmmZyb6wBVuYsILYIMvUZwQbpX7QzXIjiQaaLQINgNOx0GNR098+C5ZQvKOHn
	P7XZ0XoR4M4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F6CB4D4B9;
	Thu, 31 Oct 2013 16:43:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B4D644D4B7;
	Thu, 31 Oct 2013 16:43:37 -0400 (EDT)
In-Reply-To: <xmqqzjpp447x.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 31 Oct 2013 12:42:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1E3E434E-426D-11E3-8679-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237180>

Junio C Hamano <gitster@pobox.com> writes:

> Max Horn <max@quendi.de> writes:
>
>>> ... The "reality" is more like this:
>>> 
>>>      origin/master in your repository
>>>      |
>>>      v
>>>      A---B---C master at origin
>>>     /
>>>    D---E---F---G master in your repository
>>> 
>>> if you really want to write origin/master somewhere in this
>>> illustration.
>>
>> Actually, I kind of like that. After just reading the existing
>> phrasing in git-pull.txt, I doubt that a newbie would catch the
>> difference between "origin/master" and "master at origin". With this
>> illustration, it's very clearly conveyed that there is a difference.
>
> Yeah, after re-reading the part of the documentation with the
> illustration replaced with the above, I was coming to the same
> conclusion.

As Felipe spotted in his response, "A" is not something you already
have, so the picture need to look like the amended patch below.

The other reason the original did not say "origin/master" is because
this holds true even if you do not have such a remote-tracking
branch for the master at the origin, but the illustration that shows
the history after "git pull" finishes spells remotes/origin/master
out, so I think it would be an improvement to make the two pictures
consistent by drawing where the origin/master is before this "git
pull" is run.

Something like this, perhaps.  Note that I think "on" sounds funny
and it should probably be "at" instead, but this weatherbaloon patch
does not change it.

-- >8 --
Subject: doc/pull: clarify the illustrations

The second illustration that shows the history after "git pull"
spelled the remote-tracking branch with "remotes/" prefix, which
is not necessary.  Drop it.

To match the assumption that a remote-tracking branch is used to
keep track of the advancement of the master at the origin, update
the first illustration that shows the history before "git pull"
to show the distinction between the master currently at origin and
the stale origin/master remote-tracking branch.

Noticed-by: Felipe Contreras <felipe.contreras@gmail.com>
Helped-by: Max Horn <max@quendi.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-pull.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index beea10b..e83f3ce 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -42,6 +42,8 @@ Assume the following history exists and the current branch is
 	  A---B---C master on origin
 	 /
     D---E---F---G master
+        ^
+	origin/master in your repository
 ------------
 
 Then "`git pull`" will fetch and replay the changes from the remote
@@ -51,7 +53,7 @@ result in a new commit along with the names of the two parent commits
 and a log message from the user describing the changes.
 
 ------------
-	  A---B---C remotes/origin/master
+	  A---B---C origin/master
 	 /         \
     D---E---F---G---H master
 ------------
