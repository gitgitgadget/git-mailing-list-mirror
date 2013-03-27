From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/45] parse_pathspec and :(glob) magic
Date: Wed, 27 Mar 2013 08:39:26 -0700
Message-ID: <7vboa4q2c1.fsf@alter.siamese.dyndns.org>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
 <1363781779-14947-1-git-send-email-pclouds@gmail.com>
 <7v1ubaeyph.fsf@alter.siamese.dyndns.org>
 <20130321053326.GA17446@duynguyen-vnpc.dek-tpc.internal>
 <20130321054349.GA18101@duynguyen-vnpc.dek-tpc.internal>
 <7v4ng4br1y.fsf@alter.siamese.dyndns.org>
 <7vvc8kabhx.fsf@alter.siamese.dyndns.org> <20130323031334.GA10484@lanh>
 <CACsJy8AAyV9FyZ3ff1=FQtHB60Kpz57jrNVuxSVdSaoRO=BCzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 16:40:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKsSL-0002Ya-0d
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 16:40:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811Ab3C0Pjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 11:39:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52837 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543Ab3C0Pjg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 11:39:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A3A5A853;
	Wed, 27 Mar 2013 11:39:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jJrCQ9XzCRRj+CFGx/ngg7uieQ8=; b=LH+w5P
	/B5s53Y2xNnp3ZC7YlMC7SPDc8QIzQRVgoJt96j+WO80nibTUDNoqP0qPm/tv364
	lg5GmCVE5rDJl/p5TxHM857gH4VClQe8c22rRKtGivKKvvrxPLSHzcK9PfJja5dg
	2TXDo7WmfNKBkvrGZt3qQmW4GQuPBEWWshe1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LaHqkBqGOPPvayJNe8zr3WThK63pmYf0
	yZzVwAMWOA2ayIO3/om5ACnW0ZtgDjTxcNvhW2U20j8Qy5uztFyb/QSxIb/ULHPo
	zrHW9KX4KPLlgtLOqrSz4CU4AMGvDn14IKXiTK/V7VgIuZXlhFL3tcnJuWlSEwTT
	gKOyUhpViyc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E7C6A852;
	Wed, 27 Mar 2013 11:39:28 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 03520A850; Wed, 27 Mar 2013
 11:39:27 -0400 (EDT)
In-Reply-To: <CACsJy8AAyV9FyZ3ff1=FQtHB60Kpz57jrNVuxSVdSaoRO=BCzA@mail.gmail.com> (Duy
 Nguyen's message of "Sat, 23 Mar 2013 10:15:28 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8280E91C-96F4-11E2-B2F6-B1692E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219258>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Mar 23, 2013 at 10:13 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> which also includes all document bugs reported so far.
>
> s/all/fixes for all/

Slurped from your github repository and didn't find anything
questionable relative to the original series that was posted here.

Thanks.  Will requeue.
