From: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] test-lib.sh: Add explicit license detail,
 with change from GPLv2 to GPLv2+.
Date: Mon, 22 Feb 2010 19:42:30 -0800
Message-ID: <7vljekipnd.fsf@alter.siamese.dyndns.org>
References: <87ljf8pvxx.fsf@yoom.home.cworth.org>
	<87hbpwpoko.fsf@yoom.home.cworth.org>
	<5641883d1002060727ia4e6c16lf800a92fc8735430@mail.gmail.com>
	<201002081614.24284.sojkam1@fel.cvut.cz>
	<871vgr78lr.fsf@yoom.home.cworth.org>
	<87iqa2y0gz.fsf@steelpick.localdomain>
	<87r5oqe7mi.fsf@yoom.home.cworth.org>
	<871vgmki4f.fsf@steelpick.localdomain>
	<7vaav8hpfo.fsf@alter.siamese.dyndns.org>
	<87tytdiqob.fsf@steelpick.localdomain>
	<alpine.DEB.1.00.1002191138280.20986@pacific.mpi-cbg.de>
	<873a0xhwxs.fsf@yoom.home.cworth.org>
	<alpine.DEB.1.00.1002192204050.20986@pacific.mpi-cbg.de>
	<87eikfhec1.fsf@yoom.home.cworth.org>
	<7vaav3bnr5.fsf@alter.siamese.dyndns.org>
	<87y6ilf4w7.fsf@yoom.home.cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t-FFprn4rPSa4@public.gmane.org>,
	Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>,
	Pierre Habouzit <madcoder-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org,
	Sverre Rabbelier <srabbelier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Carl Worth <cworth-4HiWtcSh4w0dnm+yROfE0A@public.gmane.org>
X-From: notmuch-bounces-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org Tue Feb 23 04:43:03 2010
Return-path: <notmuch-bounces-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org>
Envelope-to: gmn-notmuch@m.gmane.org
Received: from u15218177.onlinehome-server.com ([82.165.184.25] helo=olra.theworths.org)
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <notmuch-bounces-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org>)
	id 1Njlfq-0001uN-W8
	for gmn-notmuch@m.gmane.org; Tue, 23 Feb 2010 04:43:03 +0100
Received: from localhost (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id EC71F431FBC;
	Mon, 22 Feb 2010 19:43:01 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at olra.theworths.org
Received: from olra.theworths.org ([127.0.0.1])
	by localhost (olra.theworths.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HnNAitydclg9; Mon, 22 Feb 2010 19:42:59 -0800 (PST)
Received: from olra.theworths.org (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id 5FF80431FBF;
	Mon, 22 Feb 2010 19:42:59 -0800 (PST)
X-Original-To: notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org
Delivered-To: notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org
Received: from localhost (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id C3272431FAE
	for <notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org>; Mon, 22 Feb 2010 19:42:57 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at olra.theworths.org
Received: from olra.theworths.org ([127.0.0.1])
	by localhost (olra.theworths.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i6bW-iv9Cfyg for <notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org>;
	Mon, 22 Feb 2010 19:42:55 -0800 (PST)
Received: from sasl.smtp.pobox.com (a-pb-sasl-quonix.pobox.com [208.72.237.25])
	by olra.theworths.org (Postfix) with ESMTP id 021AF431FBC
	for <notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org>; Mon, 22 Feb 2010 19:42:54 -0800 (PST)
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B2D769CA3F;
	Mon, 22 Feb 2010 22:42:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4Xw9As5Hxpwjp3V87Z/Ru6Rn2B4=; b=qSPbPL
	BuuxjhuCyjeI8bGAY7tls0u8dKJBM7YQ3q5j3X5kpuvXK04SmNVKsHrKB+mDNxlr
	bzyM2n/QNVxOULUEe8kyqDAz5luW2C0TwNOMAIwXX4bLvxEYxaiN5YGnYdyt2Egk
	JGo+je94GxG/K0uVkfagiKCNXhKYj14JtIDeA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OOd53tdQd0lT9GgeXm6994+4iAGrA3Ym
	2QJb8DD3YJyQPCeBtSwemLnIUN6M8Tb78B7ulKbLxSpsVTAeLBXTywwPjDY6Lo+l
	lt28fd2d9vgHKBLPxpKeuJY2wqxJyxRjC6RY4W/ExSAV3GF8yendTpvpA7qPA8+l
	ZfDyd1CNu5k=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0814E9CA3D;
	Mon, 22 Feb 2010 22:42:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
	DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
	a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C60539CA39;
	Mon, 22 Feb 2010 22:42:33 -0500 (EST)
In-Reply-To: <87y6ilf4w7.fsf-dGZf2j/AgvDc+SJF09bjuWD2FQJk+8+b@public.gmane.org> (Carl Worth's message of
	"Mon\, 22 Feb 2010 11\:26\:48 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 80BEFF42-202D-11DF-B459-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
X-BeenThere: notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: "Use and development of the notmuch mail system."
	<notmuch.notmuchmail.org>
List-Unsubscribe: <http://notmuchmail.org/mailman/options/notmuch>,
	<mailto:notmuch-request-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org?subject=unsubscribe>
List-Archive: <http://notmuchmail.org/pipermail/notmuch>
List-Post: <mailto:notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org>
List-Help: <mailto:notmuch-request-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org?subject=help>
List-Subscribe: <http://notmuchmail.org/mailman/listinfo/notmuch>,
	<mailto:notmuch-request-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org?subject=subscribe>
Sender: notmuch-bounces-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org
Errors-To: notmuch-bounces-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140766>

Carl Worth <cworth-4HiWtcSh4w0dnm+yROfE0A@public.gmane.org> writes:

> From 8693995fde71e8b028318e1e83bdbb6ae759335a Mon Sep 17 00:00:00 2001
> From: Carl Worth <cworth-4HiWtcSh4w0dnm+yROfE0A@public.gmane.org>
> Date: Sat, 20 Feb 2010 11:41:24 -0800
> Subject: [PATCH] test-lib.sh: Add explicit license detail, with change from GPLv2 to GPLv2+.

Please drop the above the next time.

> The relicensing was agreed to by Junio C Hamano here:
>
> http://thread.gmane.org/gmane.mail.notmuch.general/1389/focus=140156
>
> and in follow-up messages by Sverre Rabbelier, Johannes Schindelin,
> Pierre Habouzit, and Johannes Sixt.

FWIW, I only said "_at least_ you need consent from them", and it was not
meant to be an exhaustive list.  "blame -C -C -C" may tell you more.

You are the party that wants this relicensing, not me.  Please do not
burden me with excessive legwork for you, but help me a bit more
proactively to make this happen.

> Meanwhile, a message ID lives forever and can be used in multiple
> contexts.

Oh, I never said "do not use message ID".  I said "message ID alone is not
good enough for most people".  Users of gmane and notmuch who know the
tool they use would benefit from having message ID, _too_, but even if you
were a user of notmuch, unless you have subscribed to the list and have
your own archive, you wouldn't be able to say "show id:frotz".
