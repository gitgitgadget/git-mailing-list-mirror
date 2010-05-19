From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking extra
Date: Wed, 19 May 2010 07:33:32 -0700
Message-ID: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 19 16:33:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEkL8-000709-M3
	for gcvg-git-2@lo.gmane.org; Wed, 19 May 2010 16:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807Ab0ESOdi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 May 2010 10:33:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60496 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044Ab0ESOdh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 May 2010 10:33:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C290AB40BD;
	Wed, 19 May 2010 10:33:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=Zs0WUz9S78FSne6MJDCqovKXx
	qA=; b=MptdmKehxIxE4lFUt7/tossM06tRZiETJQHuyeh6kgA4i7S0PHmwSMnc8
	z6Vt7phqox01KnRT9zFNZK/BcZ5771pmMSLfSVXksZTI+RhxcFuC90P/VYYC8oQ0
	KaoH1sAg5/AsUOFXSP3qLL1fJ2ucXsBvNGRH30+1IG+kks5uYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=bcZhubLvtiXTAetQBU1
	SVkjSDty7jm9EXO07MAvu2M/51NLYSnfKdXf+Jw9Kf3HNVY2Yj8CwELe1SDdedcC
	q8XaNUTY4ik4SaK4+tbzBBbfSmf9wbjfBh27uZLksWCpmN7xmPos6dmk1/bSqbVm
	LTB1sQDJPoKjSOjNZhEu2kyQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AF4CB40BB;
	Wed, 19 May 2010 10:33:35 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 944F9B40BA; Wed, 19 May
 2010 10:33:33 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 81CAE964-6353-11DF-B1A7-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147329>

=46irst, let me thank everybody who participated in the list traffic fo=
r the
past few weeks, reporting problems, answering questions, raising issues=
,
discussing them, sending patches and giving feedback to them, while I w=
as
away.

I took a new day-job (yesterday was my second day) and haven't quite
adjusted yet, but I finally managed to find some time and energy to bro=
wse
through the list traffic and even queued a handful of topics.  I expect
I'll be more productive and back to speed in a week or two, but until t=
hen
I expect to still be slower than my usual self.

Here are the topics I've picked up so far (excluding the ones that were
trivially and obviously correct that went directly to 'maint' or
'master'):

 * ec/diff-noprefix-config (2010-05-02) 1 commit
  - diff: add configuration option for disabling diff prefixes.

 * jk/diff-m-doc (2010-05-08) 1 commit
  - docs: clarify meaning of -M for git-log

 * mc/maint-zoneparse (2010-05-17) 1 commit
  - Add "Z" as an alias for the timezone "UTC"

 * mg/notes-dry-run (2010-05-14) 1 commit
  - notes: dry-run and verbose options for prune

 * mg/rev-parse-lrbranches-locals (2010-05-14) 1 commit
  - revlist: Introduce --lrbranches and --locals revision specifiers
  (this branch uses mg/rev-parse-option-sifter-deprecation.)

 * mg/rev-parse-option-sifter-deprecation (2010-05-14) 3 commits
  - t6018: make sure all tested symbolic names are different revs
  - t6018: add tests for rev-list's --branches and --tags
  - rev-parse: deprecate use as an option sifter
  (this branch is used by mg/rev-parse-lrbranches-locals.)

I am aware of the following topics, that are probably all worthy of
inclusion at some point, but am unclear in what status their discussion=
s
are.  I'd appreciate it if people can help me come up with a list of
topics that are fully discussed, and if patch submitters of these topic=
s
can re-send the final "to apply" copy.

 * (Eyvind Bernhardsen and Linus) Fixing the behaviour of crlf attribut=
e;
   ignoring them when core.autocrlf is not in effect was a wrong design
   decision.

   I agree with what Linus said in the thread; I haven't yet looked at =
the
   discussion in the past few days.  Also I don't know where '[PATCH v2=
]
   Add "core.eol" config variable' fits in the picture.

 * (Chris Lamb, Jeff King, Thomas Rast) "rebase -i" mishandles a patch
   with backslash in the title

 * (Rene) grep on binary files

 * (Linus) "git show ':/this is now a regex'"

 * (Gary V. Vaughan) Portability patches

 * (=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason) cvsserver updates

 * (Bo Yang, Thomas Rast) "log --graph" improvements

 * (Pavan Kumar Sunkara) instaweb and web--browse

 * (Yann Droneaud, Linus) matching utf8 locale in t9129
