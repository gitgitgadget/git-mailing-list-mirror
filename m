From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git status: small difference between stating whole repository
 and small subdirectory
Date: Tue, 21 Feb 2012 19:32:49 -0800
Message-ID: <7vvcmzczku.fsf@alter.siamese.dyndns.org>
References: <20120215190318.GA5992@sigill.intra.peff.net>
 <CAA01Cso5y23UMguEe0vwOc6kR3-DjuC8-LTMDsMeeOKU4rVGvg@mail.gmail.com>
 <20120216192001.GB4348@sigill.intra.peff.net>
 <CAA01Csq6vSekW=Fa236bB0H3LVtN43Gb2aLMVE+A1wVyUqYJ7A@mail.gmail.com>
 <20120217203755.GA30114@sigill.intra.peff.net>
 <7vaa4hrtbe.fsf@alter.siamese.dyndns.org>
 <20120217222912.GC31830@sigill.intra.peff.net>
 <CAA01CsozANwtox06iihKBL8iii175FHAhChmNhG1B0ofGKWcEA@mail.gmail.com>
 <20120220140653.GC5131@sigill.intra.peff.net>
 <87ty2l38ay.fsf@thomas.inf.ethz.ch> <20120220143644.GA13938@do>
 <CACsJy8DE86qzA1=GiKZFRCt5aH8X4iMyDvfrhnqwmbq52szhHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, Jeff King <peff@peff.net>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 04:33:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S02xN-00026M-Gq
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 04:33:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546Ab2BVDcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 22:32:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60640 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753081Ab2BVDcx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 22:32:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F38866E4;
	Tue, 21 Feb 2012 22:32:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BesAj2evOCEZE3LY7vlknJOxFfQ=; b=DqjJx1
	tpJiaIBirW5j2ikRWuKiT2XzF92LVlWWIdR0ju0k+bCHnjD5MNefJxEV4Ektbzzx
	nChNptUc7FLGfNumTzQ5WgbAfx6DbHS5ec+F3FHEv2vWL4Ra35OTi9KU8yzEEiM3
	tx/WYuZTlToFuNcfi+lNbdWX4t1KeAjYWZm4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OXyKsAAInPrSv+SwxeZxLcGbeRtnItrb
	2AMI0Q3owRzQ9lDJcq5RNt1oUFVposTudE3ed9R14DqUa0AEBMGSk7Bl++tyo4K3
	RLRo1n+Pf5ZSQeKT/8jooO8j3IvSInavHi5CzDCncdvZAFcqW/d03enTPvNps526
	N2PTX3S+w4U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10B4566E3;
	Tue, 21 Feb 2012 22:32:52 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 58AB266E1; Tue, 21 Feb 2012
 22:32:51 -0500 (EST)
In-Reply-To: <CACsJy8DE86qzA1=GiKZFRCt5aH8X4iMyDvfrhnqwmbq52szhHg@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Tue, 21 Feb 2012 21:45:13 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E60E7988-5D05-11E1-921D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191228>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>> diff --git a/builtin/checkout.c b/builtin/checkout.c
>> index 5bf96ba..c06287a 100644
>> --- a/builtin/checkout.c
>> +++ b/builtin/checkout.c
>> @@ -319,6 +319,10 @@ static void show_local_changes(struct object *head, struct diff_options *opts)
>>                die(_("diff_setup_done failed"));
>>        add_pending_object(&rev, head, NULL);
>>        run_diff_index(&rev, 0);
>> +       if (!DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES)) {
>> +               struct tree *tree = parse_tree_indirect(head->sha1);
>> +               prime_cache_tree(&active_cache_tree, tree);
>> +       }
>>  }

I think this patch is wrong on at least two counts.

 * The run_diff_index(&rev, 0) you reused is doing "diff HEAD" and not
   "diff --cached HEAD".  The added check does not say anything about the
   comparison between the index and the tree at the HEAD.

 * Even if we added an extra run_diff_index(&rev, 1) there, or added a
   call to index_differs_from() to run "diff --cached HEAD" to check what
   needs to be checked, it is still not quite right.

On the latter point, imagine what happens in the two invocations of
checkout in the following sequence:

   $ git reset --hard master
   $ git checkout master
   $ git checkout master

The second one should notice that the cache tree is fully valid, so the
internal "diff --cached" it runs should only open the top-level tree
and scan entries in it, without recursing into any of the subtrees, and
realize that the index is in sync with "HEAD", which should be a very
cheap operation (that is the whole point of the current topic of our
discussion looking at the cache-tree).  Then the new code calls
prime_cache_tree() to read _everything_?

Probably cache_tree_fully_valid() should be called before deciding that we
need to re-populate the cache tree from "HEAD".
