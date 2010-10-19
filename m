From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Mon, 18 Oct 2010 17:03:45 -0700
Message-ID: <7vaamb2gm6.fsf@alter.siamese.dyndns.org>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
 <AANLkTimkovH9OysLSxA+=di89Xi+dTCYL5hRPmNaADDH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 02:04:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7zgU-0008Er-EI
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 02:04:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932900Ab0JSAD7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Oct 2010 20:03:59 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33338 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755306Ab0JSAD7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Oct 2010 20:03:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BD3B3DF7F9;
	Mon, 18 Oct 2010 20:03:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=GC4LAdLIfveS
	vAbNZFglMOSh7/8=; b=c81IJs8ekAm2VvG/ljyb5VWhl8aKQhuKk8vDjhHU2Cqm
	l+eWaAYCD59VhlhFIZG+wlcUmQAocbVt/JqgfLsSnQDBGNqraWqvLQ2p0To0qlHv
	MHrcEmyxuV8jNiXhskYyFAL5SeF+osW7wRhgQNBfbSdswR7D7a5hmwnFZ+ayh4c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fKv3Aw
	uaAk+w+1j/ulhNMpQ/GvT0kN9yjPXfM5ePtqo7EDqq1bOAqmjaFYXM88ox//82H0
	JWbhnyR2PdqsM5xai3BxM98H2LTSyPwHcJUa7GDdm+DEloLjXABesuI+mvbgo1Ut
	EthZQcGGXGlia97eUgYlxXVrXZL9agraoQYSU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D278DF7ED;
	Mon, 18 Oct 2010 20:03:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 45757DF7E6; Mon, 18 Oct
 2010 20:03:47 -0400 (EDT)
In-Reply-To: <AANLkTimkovH9OysLSxA+=di89Xi+dTCYL5hRPmNaADDH@mail.gmail.com>
 (Sverre Rabbelier's message of "Mon\, 18 Oct 2010 16\:35\:32 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5BFBDB7E-DB14-11DF-B21D-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159298>

Sverre Rabbelier <srabbelier@gmail.com> writes:

>> More radically, I am sure some head scratching would be able to find
>> useful terminology for master, origin/master, and origin=E2=80=99s m=
aster. I=E2=80=99d
>> love to see suggestions. As I said, I admire how wonderfully simple
>> and clean this has been implemented, and the documentation, CLI, and
>> terminology should reflect that.
>
> I don't have any objections to changing these terms, but I don't have
> any suggestions on what to change them _to_.

I do not think debating on changing the terminology is a particularly
productive use of our time.  Just like Thore was confused by "index,
cache, add, stage", we would end up adding yet another lingo that cover
the same concept, and the problem is that there is _no way_ older words
will be forgotten.

But I think the way the concepts are explained and taught by our
documentation can and should be improved.  For example, as I've written
before we use 'tracking' for two quite different purposes, which is a
mistake and the source confusion.

 - A "remote-tracking branch" is "a _thing_ whose purpose is to be used=
 to
   track a branch on the remote side", and "fetch" is how you update it=
=2E

 - Sometimes people call a local branch whose purpose is to be used to
   build on efforts made on a branch on a remote repository as "trackin=
g",
   which is quite incompatible with the above one.
