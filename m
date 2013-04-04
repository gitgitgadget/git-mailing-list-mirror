From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-commit: reword the --amend explanation
Date: Thu, 04 Apr 2013 10:04:34 -0700
Message-ID: <7va9pejkgt.fsf@alter.siamese.dyndns.org>
References: <1364994441-15961-1-git-send-email-cmn@elego.de>
 <7v4nfn7j5i.fsf@alter.siamese.dyndns.org>
 <7vtxnn4c02.fsf@alter.siamese.dyndns.org>
 <50CA4F4141DD484D97CA8BA571529F65@PhilipOakley>
 <1365094159.30466.60.camel@centaur.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Apr 04 19:05:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNnb2-0007Vk-5i
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 19:05:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763562Ab3DDREi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Apr 2013 13:04:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63687 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763473Ab3DDREh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Apr 2013 13:04:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE023130E7;
	Thu,  4 Apr 2013 17:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=bl4orFlckYcj
	HACBM1yuA/BeVOY=; b=bxnzZYDm+GMQ3dqoHj7WCZ8DPpaaOQl2GGX6tBaYxNYU
	Rk9DR8wwaADpmopAcWJ4SvPqUL0MqzIe8qugeuaPsvYJtO5IEnh1e6hQxfu5CBtb
	ivlLCxkf/mtXNoU0ONB/jE1VZNEFd8SopKcNZOokqZAdS8/WO5piJRxgyq1pUfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qiqpfE
	Og7PGQ8fkAgEt5BHt2eIB9jNn9uJaRa3xIxQ7xZ/72SsfUiSX5+5En8Jwa0wn5oY
	umZooNRZspz8ytT/XCWtOwcJxdg7+Hp942TrVLd7BDjUx1k01mGMoyUZN3BD4RtF
	wWe5v4frHL5It8+6PsfaeBsSqieXSjSdNca9M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5F46130E6;
	Thu,  4 Apr 2013 17:04:36 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F6EF130E4; Thu,  4 Apr
 2013 17:04:36 +0000 (UTC)
In-Reply-To: <1365094159.30466.60.camel@centaur.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Thu, 04 Apr 2013 18:49:19
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BA7BB904-9D49-11E2-88D8-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220036>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> On Wed, 2013-04-03 at 23:25 +0100, Philip Oakley wrote:
>
>>  + Replace the tip of the current branch with a fresh commit.
>> [or updated commit, or new commit, or ...]
>
> Ack, we should lead with the goal, I'd go for the
>
>     "Replace the tip of the current branch with a new commit"
>
> wording.

We would want to be careful to make sure that the reader understands
that the "new commit" is created by running this command (i.e. it is
not like "git branch -f $current_branch $new_commit"), but other
than that, sounds sensible.

Perhaps like this?

 Documentation/git-commit.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.tx=
t
index bc919ac..61266d8 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -190,8 +190,8 @@ OPTIONS
 	without changing its commit message.
=20
 --amend::
-	Create a new commit and replace the tip of the current
-	branch. The recorded tree is prepared as usual (including
+	Replace the tip of the current branch by creating a new
+	commit. The recorded tree is prepared as usual (including
 	the effect of the `-i` and `-o` options and explicit
 	pathspec), and the message from the original commit is used
 	as the starting point, instead of an empty message, when no
