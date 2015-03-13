From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Documentation] Submitting Patches
Date: Fri, 13 Mar 2015 00:02:15 -0700
Message-ID: <xmqqa8zhz8g8.fsf@gitster.dls.corp.google.com>
References: <CAHWMk2YuUvYYb-nxdANVxZ0tLsyttnqNzpF74Nxz1zpFcGEnGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Cody Taylor <cody.taylor@maternityneighborhood.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 08:02:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWJby-00027g-It
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 08:02:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbbCMHCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2015 03:02:18 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56880 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751769AbbCMHCR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2015 03:02:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EDE1E3A8FA;
	Fri, 13 Mar 2015 03:02:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hCsRQ/cSMC2drKZOd4eZJ+7IBBU=; b=R0yaA6
	CqZMcwTdwZipZFIqOiD2i26a3jHKodZH0pDIOcXTfgKVbQjItQkRy6ns+UmaqJgW
	MYPkKrMyDvav2uD0vewm3gAhCPoLp+LOrKVRg5+CNqmvxyZVI+SoorzY3dZ+mp4z
	R7/DuA9Xtc9WK+RPWclSbKvfkEYt1XUjvM2CE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hox6+vqZ8we1El9tbN3K0sbQiDHYvdRb
	EF5e+sGl9uIterc8CJjVKmyBgHVREcJA7AFHBVVzes39YqTm1dYkcTI2UKPTZRU0
	XTecp6g0igtxVGfmPuHDS6sg82OGfY0I6iuPcNEsi2BKFSbLTeKzkccpQECr3jGi
	RFdpFoZEgik=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E63F03A8F9;
	Fri, 13 Mar 2015 03:02:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5B38B3A8F8;
	Fri, 13 Mar 2015 03:02:16 -0400 (EDT)
In-Reply-To: <CAHWMk2YuUvYYb-nxdANVxZ0tLsyttnqNzpF74Nxz1zpFcGEnGg@mail.gmail.com>
	(Cody Taylor's message of "Fri, 13 Mar 2015 02:31:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E1FA82B6-C94E-11E4-A495-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265407>

Cody Taylor <cody.taylor@maternityneighborhood.com> writes:

> Anyway, this brings up the point that `git send-email` should at least
> get a mention in the "Documentation/SubmittingPatches" file. Likely
> the best place for this is a paragraph after `git format-patch` is
> mentioned in section 4 ("Sending your patches.").

[removed others who are not to be blamed for the lack of doc from cc]

I very much agree with that---actually I am somewhat surprised that
the documentation doesn't do so already.

Perhaps something like this?

-- >8 --
Subject: SubmittingPatches: nudge to use send-email

In step "(4) Sending your patches", we instruct users to do an
inline patch, avoid breaking whitespaces, avoid attachments,
use [PATCH v2] for second round, etc., all of which send-email
knows how to do.

Mention send-email at least once to gently nudge the user to (learn
to) use it.

Suggested-by: Cody Taylor <cody.taylor@maternityneighborhood.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index ef0eeb4..2b10569 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -154,7 +154,8 @@ you send off a message in the correct encoding.
 
 WARNING: Be wary of your MUAs word-wrap
 corrupting your patch.  Do not cut-n-paste your patch; you can
-lose tabs that way if you are not careful.
+lose tabs that way if you are not careful.  If you can use the
+"git send-email" command, please do so.
 
 It is a common convention to prefix your subject line with
 [PATCH].  This lets people easily distinguish patches from other
