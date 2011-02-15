From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Consistent terminology: cached/staged/index
Date: Mon, 14 Feb 2011 16:12:36 -0800
Message-ID: <7vaahyqhor.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
 <20110213193738.GA26868@elie> <7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
 <87k4h34bhj.fsf@catnip.gol.com> <7vr5bbupj4.fsf@alter.siamese.dyndns.org>
 <AANLkTi=PDhVgpTeFjTxFuVJGbAKTHzHhsNVcquqSD3Qq@mail.gmail.com>
 <4D58D2DF.1050205@viscovery.net>
 <AANLkTikTfyHBOvQmjhT8yTziL4R67+AAk0O-Nk1tBSaL@mail.gmail.com>
 <4D5906FD.7030502@drmicha.warpmail.net>
 <buod3muswq7.fsf@dhlpc061.dev.necel.com>
 <7vtyg6tu9e.fsf@alter.siamese.dyndns.org>
 <AANLkTinnCLVDEZpNPVYZ2fq1BY=257BTxkzNj44-Yz3O@mail.gmail.com>
 <7vzkpyql2r.fsf@alter.siamese.dyndns.org>
 <AANLkTikyc5QEou8Em-3HkLSHWHQyx+MnYMQ9OSN33_QS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 15 01:13:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp8XN-0007fB-HB
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 01:13:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577Ab1BOAM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 19:12:57 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39977 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398Ab1BOAMz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 19:12:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5990B451B;
	Mon, 14 Feb 2011 19:13:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sIGhAvOBmPVvpbDE0jWUekfANLY=; b=DesScH
	7xPDrv6/KbNy72Mim+LDpv1c1s8G9o3jRxPe+QFSyPhAwN0zVJajzv0f9ORcw4ob
	RwQH+S+YRSZ1+erwLsRIEaX0Uj0qacLi82HAMpYwh4BxSpbHOcSH/RGACG+jiyg+
	2hdpW+NHVOr32gp7OM5sdKYcaNvWOU32L+4o4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HOINH0YSaq1iU8V9jRwYTQNSB8w5ei6j
	SdNti1I7Nn/zO3oP+SWkUUO81FlaHU6wP4avIXvA/A0ligcw5lKAKYLbYdP7okIK
	QYQA/zRjLFhCZ3q50TsUPOCYbvxxxKV9wZGenKnd2kvd69usVm/Mk6hFdEOXRCvd
	73pkfFsrU+U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EE752450F;
	Mon, 14 Feb 2011 19:13:49 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1211A450A; Mon, 14 Feb 2011
 19:13:41 -0500 (EST)
In-Reply-To: <AANLkTikyc5QEou8Em-3HkLSHWHQyx+MnYMQ9OSN33_QS@mail.gmail.com>
 (Miles Bader's message of "Tue\, 15 Feb 2011 08\:47\:00 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 76BC7A5E-3898-11E0-A25D-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166799>

Miles Bader <miles@gnu.org> writes:

> [BTW, isn't the name "--index-only" something of a misnomer?  If
> something is called "--XXX-only", that implies that the default
> operation uses "XXX + something else" instead of XXX, but that
> otherwise they are the same.  However in fact the difference in
> behavior resulting from --cached is more subtle: it changes _both_
> sides of the diff (default: worktree<->index; --cached: index<->HEAD).

Not really.

There are three entities involved: a tree-ish, the index, and the working
tree.  Because the index is a singleton, when you say "compare the index
with...", you only have two choices, either compare it against a tree-ish,
or compare it with the working tree.  If you want to do the latter, you
just use the command without --cached nor tree-ish.

The --cached form defaults to HEAD only because --cached mode is about
comparing the index against a tree-ish (think about "diff --cached HEAD^").

The same thing for --index-only.  The moment you said "compare the index
with...", there are only two other things to compare it against and that
is the only reason why you do not have to write HEAD.

This is a tangent, but the natural patch-flow is for you to prepare your
change in the working tree, add the changes to the index, and then build a
tree out of the index into a commit.

That is why "diff" shows changes in the working tree relative to what is
in the index, "diff --cached [<tree-ish>]" shows changes in the index
relative to the tree-ish (defaulting to HEAD).  The natural flow of the
development determines the natural direction of comparison between these
entities.

It does not make sense to compare in the other direction (i.e. how is the
index different compared to the working tree) _unless_ you are
contemplating to revert some changes you have made, and -R is there
exactly for that reason (here I am responding to the idea some people had
in an earlier incarnation of this thread of saying "diff INDEX HEAD",
"diff HEAD WORKTREE" etc., using pseudo <ref> syntax, and explaining why
it is not such a good idea---and why this is a tangent).
