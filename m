From: Junio C Hamano <gitster@pobox.com>
Subject: Re: submodules' shortcomings, was Re: RFC: display dirty submodule
 working directory in git gui and gitk
Date: Wed, 06 Jan 2010 12:01:46 -0800
Message-ID: <7vbph7uhn9.fsf@alter.siamese.dyndns.org>
References: <4B3F6742.6060402@web.de>
 <alpine.DEB.1.00.1001042217370.4985@pacific.mpi-cbg.de>
 <4B42F425.4010901@web.de> <7v1vi428w0.fsf@alter.siamese.dyndns.org>
 <4B43292C.5060106@web.de> <7vd41oz9mp.fsf@alter.siamese.dyndns.org>
 <4B439A86.3020500@web.de> <7vbph8oxg0.fsf@alter.siamese.dyndns.org>
 <4B4498BC.5040400@web.de> <7vbph7181x.fsf@alter.siamese.dyndns.org>
 <fcaeb9bf1001060923m6559f00bp794bb5fdd4af704c@mail.gmail.com>
 <7vljgbw21x.fsf@alter.siamese.dyndns.org> <4B44D73F.6000607@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Lars Hjemli <hjemli@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jan 06 21:02:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSc5C-0003iT-Q2
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 21:02:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424Ab0AFUCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 15:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413Ab0AFUCM
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 15:02:12 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45044 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932411Ab0AFUCL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 15:02:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 558D58E596;
	Wed,  6 Jan 2010 15:02:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=23Scklh37giCCghScPrx5t/V3Bs=; b=Swv21Z
	Q+LWhO9yTPKCrO1+prdzi+9my0a3YUSQsv2CdvzC96McFMT8eY4SpfgnXGEcJ3+N
	mdAhW8dzCOzh+GlihklO6kkfzl0N1YYm1/dW7TPJL6iYbmHRUEt8kx+2AdAKRyTP
	2XWv+/NqFqqwjFM6yjD+kKIX068toAfQ0/kAI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QHFcBdSg6DslR1l1kKH1bEleTjB+b9JI
	qHQewBo5KzYr/xJEFMI3bJOyh1jE8n249zN5WqAIsFJXywhMl64u0tVo7S1Ex5ZX
	JLiV9hDZqQtUnDfX7zzW6hydlkv1tZco0dqnfKODzL728dZKTWffHmFx6q51bgo0
	SmFGa9/Rz0Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AD7F88E58F;
	Wed,  6 Jan 2010 15:01:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14B278E573; Wed,  6 Jan
 2010 15:01:47 -0500 (EST)
In-Reply-To: <4B44D73F.6000607@web.de> (Jens Lehmann's message of "Wed\, 06
 Jan 2010 19\:32\:31 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 58D6A4DE-FAFE-11DE-BDB5-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136291>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 06.01.2010 18:55, schrieb Junio C Hamano:
>> I was envisioning that the "git status" in submodule will be run with its
>> recent --porcelain option, and "git status" or "git commit" would read it
>> to postprocess and incorporate into its own output.
>
> And i thought about printing just one line for each dirty submodule that
> contains uncommitted and/or new files. I did not intend to list every
> file, for the same reason a "git diff --submodule" only shows the first
> line of the commit messages, not the actual differences of all changed
> files in the submodule. I am not against being able to show all files
> too, but i really would want to have an option to get a short output for
> git gui and gitk.

I don't think what you are saying is inconsistent with "git status/commit
that reads from 'git status --porcelain' it runs in a submodule directory,
postprocesses it and incorporates it into its own output."  When the
sub-status reports changes, your "postprocess" would condense it down to
"this has a potential change that user could want to commit".  How the
dirtiness is shown is entirely up to the caller that detected that change.

Let's explain it in another way.

The original "diff" for a submodule entry was implemented by preparing a

	"Subproject commit %s\n"

line for the submodule commit recorded in the preimage and postimage, and
compare these as if they are one-line files.  When the postimage was work
tree, it looked at submodule's .git/HEAD to learn what to stuff in %s
there.

But nobody forced you to limit the check only to .git/HEAD in the
submodule.  To make the comparison richer, you could check if the
submodule directory is dirty (and we have already discussed the potential
definition of dirtiness earlier), and add "-dirty" in the string as well.
With such a change, if you make some changes to a file in the work tree of
the submodule after a clean "clone", "git diff" between the index and the
work tree would report:

	-Subproject commit 37bae10e38a66e4f1ddd5350daded00b21735126
	+Subproject commit 37bae10e38a66e4f1ddd5350daded00b21735126-dirty

The suggestion to read from "status --porcelain" that is run in the
submodule directory was about how to implement the part that determines
this "dirtiness" information, and not about how that dirtiness is
expressed in the output.  The above is an illustration that even the
traditional output format can be made aware of this submodule dirtiness
check.  "diff --submodule" can express that dirtiness information in any
way it wants.
