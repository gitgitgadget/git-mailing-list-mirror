From: Junio C Hamano <gitster@pobox.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 22:03:24 -0800
Message-ID: <7v8wbg2kpf.fsf@alter.siamese.dyndns.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
 <7vaavwh6yh.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001291833580.1681@xanadu.home>
 <7vy6jgcutb.fsf@alter.siamese.dyndns.org>
 <fabb9a1e1001291618m71f61209v4f26fb66c6ad99ae@mail.gmail.com>
 <7viqakcu56.fsf@alter.siamese.dyndns.org>
 <ca433831001291701m50b8c2b7p16bcc6fd4f3f3d55@mail.gmail.com>
 <alpine.LFD.2.00.1001292013150.1681@xanadu.home>
 <ca433831001291840o751fa02eve1ae301537674325@mail.gmail.com>
 <alpine.LFD.2.00.1001292208470.1681@xanadu.home>
 <ca433831001291959m76ed6adap32a17c10e465af1f@mail.gmail.com>
 <alpine.LFD.2.00.1001292305500.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Lodato <lodatom@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>, Ron1 <ron1@flownet.com>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Jan 30 07:03:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb6Qw-0001I0-82
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 07:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317Ab0A3GDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 01:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233Ab0A3GDm
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 01:03:42 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51504 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209Ab0A3GDl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 01:03:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EFA4B9560C;
	Sat, 30 Jan 2010 01:03:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wDiUgBawteGM+m4UBT0+uhA08fQ=; b=MdTyMQ
	goo4PO4RavugewQy563+5mSEXq+5kPrnNPW6QadZHqm8ikWpnVAUz70RsFIgac8l
	mw8RtORNdRS0WbDhTtEscpvJzZs0j+l8gz/WpW9XJJvq2p9MoZ/5+PlolNgCqUuK
	I9OdRtMZ5fyL6L3pAwRTpdBEGdSdUPDEP6s4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TKNpfHX2GcGiEhD9kYIjVCap2hdCsp6S
	JG2UfOSgPucgJZXRRni70NIz6UvaOfrNMx+dY11bJAi+9zjNTO6RNLKYplzl/Fs4
	JzSgkRSU83lfBC/eaee71woNcLydz9fN8wP3IulwDMhIBsXr+lgR9cD1t7O7X4nS
	qFFh8uaKK4A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A8809560A;
	Sat, 30 Jan 2010 01:03:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D3DF395607; Sat, 30 Jan
 2010 01:03:25 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1001292305500.1681@xanadu.home> (Nicolas
 Pitre's message of "Fri\, 29 Jan 2010 23\:39\:25 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 328D560A-0D65-11DF-84B8-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138451>

Nicolas Pitre <nico@fluxnic.net> writes:

> First, I'm afraid that "Checking out commit 'foobar'" might be confusing 
> as this may happen through either a remote branch, a tag, or any random 
> commit.  It seems to me that "Checking out 'v2.5'" is less confusing 
> than "Checking out commit 'v2.5'".  But that's a minor detail and 
> probably a personal preference.
> ...
> To the contrary: this "detached HEAD" is exactly what you need if you 
> want to relate to any documentation or perform a search for more 
> information.  Like it or not, this detached HEAD term is exactly what 
> this Git concept is all about and how it is designated everywhere.  The 
> sooner Git users see and learn about it the better.

As I am not good at keeping track of different proposals to change this
word here and that word there, I expect this will probably need at least
few rotations of earth to get input from people in different timezones,
and I think this is post 1.7.0 item anyway, I'll queue the attached draft
in 'pu' and keep it there, to make it easier for others to tweak the
message.

-- >8 --
Subject: [PATCH] Reword "detached HEAD" notification

The old "advice" message explained how to create a branch after going into
a detached HEAD state but didn't make it clear why the user may want to do
so.  Also "moving to ... which isn't a local branch" was unclear if it is
complaining, if it is describing the new state, or if it is explaining why
the HEAD is detached (the true reason is the last one).

Give the established phrase 'detached HEAD' first to make it easy for
users to look up the concept in documentation, and briefly describe what
can be done in the state (i.e. play around without having to clean up)
before telling the user how to keep what was done during the temporary
state.

Allow the long description to be hidden by setting advice.detachedHead
configuration to false.

We might want to customize the advice depending on how the commit to check
out was spelled (e.g. instead of "new-branch-name", we way want to say
"topic" when "git checkout origin/topic" triggered this message) in later
updates, but this encapsulates that into a separate function and it should
be a good first step.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |    5 +++++
 advice.c                 |    2 ++
 advice.h                 |    1 +
 builtin-checkout.c       |   18 ++++++++++++++++--
 t/t7201-co.sh            |   32 ++++++++++++++++++++++----------
 5 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 17901e2..fee44d8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -138,6 +138,11 @@ advice.*::
 		Advice on how to set your identity configuration when
 		your information is guessed from the system username and
 		domain name. Default: true.
+
+	detachedHead::
+		Advice shown when you used linkgit::git-checkout[1] to
+		move to the detach HEAD state, to instruct how to create
+		a local branch after the fact.  Default: true.
 --
 
 core.fileMode::
diff --git a/advice.c b/advice.c
index 936d98b..0be4b5f 100644
--- a/advice.c
+++ b/advice.c
@@ -5,6 +5,7 @@ int advice_status_hints = 1;
 int advice_commit_before_merge = 1;
 int advice_resolve_conflict = 1;
 int advice_implicit_identity = 1;
+int advice_detached_head = 1;
 
 static struct {
 	const char *name;
@@ -15,6 +16,7 @@ static struct {
 	{ "commitbeforemerge", &advice_commit_before_merge },
 	{ "resolveconflict", &advice_resolve_conflict },
 	{ "implicitidentity", &advice_implicit_identity },
+	{ "detachedhead", &advice_detached_head },
 };
 
 int git_default_advice_config(const char *var, const char *value)
diff --git a/advice.h b/advice.h
index 9b7a3ad..3244ebb 100644
--- a/advice.h
+++ b/advice.h
@@ -8,6 +8,7 @@ extern int advice_status_hints;
 extern int advice_commit_before_merge;
 extern int advice_resolve_conflict;
 extern int advice_implicit_identity;
+extern int advice_detached_head;
 
 int git_default_advice_config(const char *var, const char *value);
 
diff --git a/builtin-checkout.c b/builtin-checkout.c
index 5277817..c5ab783 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -488,6 +488,20 @@ static void report_tracking(struct branch_info *new)
 	strbuf_release(&sb);
 }
 
+static void detach_advice(const char *old_path, const char *new_name)
+{
+	const char fmt[] =
+	"Note: checking out '%s'.\n\n"
+	"You are in 'detached HEAD' state. You can look around, make experimental\n"
+	"changes and commit them, and you can discard any commits you make in this\n"
+	"state without impacting any branches by performing another checkout.\n\n"
+	"If you want to create a new branch to retain commits you create, you may\n"
+	"do so (now or later) by using -b with the checkout command again. Example:\n\n"
+	"  git checkout -b new_branch_name\n\n";
+
+	fprintf(stderr, fmt, new_name);
+}
+
 static void update_refs_for_switch(struct checkout_opts *opts,
 				   struct branch_info *old,
 				   struct branch_info *new)
@@ -522,8 +536,8 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 		update_ref(msg.buf, "HEAD", new->commit->object.sha1, NULL,
 			   REF_NODEREF, DIE_ON_ERR);
 		if (!opts->quiet) {
-			if (old->path)
-				fprintf(stderr, "Note: moving to '%s' which isn't a local branch\nIf you want to create a new branch from this checkout, you may do so\n(now or later) by using -b with the checkout command again. Example:\n  git checkout -b <new_branch_name>\n", new->name);
+			if (old->path && advice_detached_head)
+				detach_advice(old->path, new->name);
 			describe_detached_head("HEAD is now at", new->commit);
 		}
 	}
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 6442f71..d20ed61 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -166,19 +166,31 @@ test_expect_success 'checkout -m with merge conflict' '
 	! test -s current
 '
 
-test_expect_success 'checkout to detach HEAD' '
+test_expect_success 'checkout to detach HEAD (with advice declined)' '
 
+	git config advice.detachedHead false &&
 	git checkout -f renamer && git clean -f &&
 	git checkout renamer^ 2>messages &&
-	(cat >messages.expect <<EOF
-Note: moving to '\''renamer^'\'' which isn'\''t a local branch
-If you want to create a new branch from this checkout, you may do so
-(now or later) by using -b with the checkout command again. Example:
-  git checkout -b <new_branch_name>
-HEAD is now at 7329388... Initial A one, A two
-EOF
-) &&
-	test_cmp messages.expect messages &&
+	grep "HEAD is now at 7329388" messages &&
+	test 1 -eq $(wc -l <messages) &&
+	H=$(git rev-parse --verify HEAD) &&
+	M=$(git show-ref -s --verify refs/heads/master) &&
+	test "z$H" = "z$M" &&
+	if git symbolic-ref HEAD >/dev/null 2>&1
+	then
+		echo "OOPS, HEAD is still symbolic???"
+		false
+	else
+		: happy
+	fi
+'
+
+test_expect_success 'checkout to detach HEAD' '
+	git config advice.detachedHead true &&
+	git checkout -f renamer && git clean -f &&
+	git checkout renamer^ 2>messages &&
+	grep "HEAD is now at 7329388" messages &&
+	test 1 -lt $(wc -l <messages) &&
 	H=$(git rev-parse --verify HEAD) &&
 	M=$(git show-ref -s --verify refs/heads/master) &&
 	test "z$H" = "z$M" &&
-- 
1.7.0.rc0.187.g226c
