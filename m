From: Junio C Hamano <gitster@pobox.com>
Subject: Re: jc/add-2.0-delete-default (Re: What's cooking in git.git (Apr 2013, #05; Mon, 15))
Date: Sun, 21 Apr 2013 21:54:45 -0700
Message-ID: <7vehe3qi5m.fsf@alter.siamese.dyndns.org>
References: <7vd2tr6833.fsf@alter.siamese.dyndns.org>
	<20130418180017.GA5714@sigill.intra.peff.net>
	<7v61zj66wu.fsf@alter.siamese.dyndns.org>
	<20130418203035.GB24690@sigill.intra.peff.net>
	<7vvc7j4j0u.fsf@alter.siamese.dyndns.org>
	<20130418214427.GA10119@sigill.intra.peff.net>
	<7vobdb4hii.fsf@alter.siamese.dyndns.org>
	<20130419043142.GA5055@elie.Belkin>
	<7vbo9a3011.fsf@alter.siamese.dyndns.org>
	<20130419213455.GB20873@sigill.intra.peff.net>
	<20130421073918.GD10429@elie.Belkin>
	<7vsj2jqqmu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org, Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 06:55:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UU8mW-0003J5-0s
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 06:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029Ab3DVEy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 00:54:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34584 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750926Ab3DVEyz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 00:54:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E40C128AF;
	Mon, 22 Apr 2013 04:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tX7xn4fP0h0Erb4GPMij1K7Qd3U=; b=H/D+pm
	HUFJFwazZIc5juQcx5VNhpyFlKn2DmGHOo2Q0QjWy+ypFSzUXARTiRgtS/YKVsVj
	7ryMrh5jN3cJaXAAFt9Krc9zjgbg6TuAB9gM5HWZRdBW30hbuzOuqJ7spnpY9Erl
	br/YtWflTqOrBVOczv2HhtwQFcRTN+bo/CUUk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TLYVEN+hbg1pqMwi48d5QZ3bvNy9h5gN
	jVeRM6dyxToWfuClNPv72NSHsKVoc3hO7cHbf0XajWPsICevFYTahKWsJQ/O/UlL
	g9RJn6y2E6CbSvYvX726ZS7XIDuE/17wlXnrr9bHQg98YIJZrTEsHAyIFSw7N3HN
	CPo4jQoGHyo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 443C0128AE;
	Mon, 22 Apr 2013 04:54:53 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 892EB128AC;
	Mon, 22 Apr 2013 04:54:52 +0000 (UTC)
In-Reply-To: <7vsj2jqqmu.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 21 Apr 2013 18:51:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C4E1998C-AB08-11E2-9A7E-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221987>

Junio C Hamano <gitster@pobox.com> writes:

>> Then the --ignore-removals option could be added using a patch like
>> the following.
>
> adding ignore-removals as a synonym (and keeping it) would be a good
> idea.
>
> We would still need to carry --all and --no-all that have been with
> us ever since we added "-A" option, though.

The final step to turn "-A" the default will be held back until Git 2.0 release,
but I've inserted the following patch before that step.

I am thinking that it would be a good idea to merge up to this step
to 'master' tomorrow, and have you guys tweak it further on 'master'
with a patch like the one I am responding to, before the 1.8.3
final.  We will have to tweak the 2.0 endgame version as we go but
that is outside 'next' for now, so it should be manageable.

-- >8 --
Subject: [PATCH] git add: rephrase the "removal will cease to be ignored" warning

Now the logic to decide when to warn has been tightened, we know the
user is in a situation where the current and future behaviours will
be different.  Spell out what happens with these two versions and
how to explicitly ask for the behaviour, and suggest "git status" as
a way to inspect the current status.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/add.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 4242bce..20f459a 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -52,15 +52,22 @@ static int fix_unmerged_status(struct diff_filepair *p,
 		return DIFF_STATUS_MODIFIED;
 }
 
+static const char *add_would_remove_warning = N_(
+	"You ran 'git add' with neither '-A (--all)' or '--no-all', whose\n"
+"behaviour will change in Git 2.0 with respect to paths you removed from\n"
+"your working tree. Paths like '%s' that are\n"
+"removed are ignored with this version of Git.\n"
+"\n"
+"* 'git add --no-all <pathspec>', which is the current default, ignores\n"
+"  paths you removed from your working tree.\n"
+"\n"
+"* 'git add --all <pathspec>' will let you also record the removals.\n"
+"\n"
+"Run 'git status' to check the paths you removed from your working tree.\n");
+
 static void warn_add_would_remove(const char *path)
 {
-	warning(_("In Git 2.0, 'git add <pathspec>...' will also update the\n"
-		  "index for paths removed from the working tree that match\n"
-		  "the given pathspec. If you want to 'add' only changed\n"
-		  "or newly created paths, say 'git add --no-all <pathspec>...'"
-		  " instead.\n\n"
-		  "'%s' would be removed from the index without --no-all."),
-		path);
+	warning(_(add_would_remove_warning), path);
 }
 
 static void update_callback(struct diff_queue_struct *q,
-- 
1.8.2.1-650-g3c8b519
