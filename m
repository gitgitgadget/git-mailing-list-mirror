From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/2] Lazily generate header dependencies
Date: Tue, 05 Jan 2010 17:06:56 -0800
Message-ID: <7vwrzwnirz.fsf@alter.siamese.dyndns.org>
References: <4B0F8825.3040107@viscovery.net>
 <alpine.DEB.1.00.0911271033460.4521@intel-tinevez-2-302>
 <20091127174558.GA3461@progeny.tock>
 <20100101090550.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 02:07:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSKMs-0006wZ-Bi
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 02:07:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755184Ab0AFBHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 20:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755180Ab0AFBHM
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 20:07:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53345 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754379Ab0AFBHK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 20:07:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7ADE4AD4B8;
	Tue,  5 Jan 2010 20:07:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=huGljWOap7K69R47c9AOb9q5BYE=; b=SHaroFhthCo0h4GG9EXK8qJ
	LzqobPFhdsNPHe1YcIibm2eg30GBkC565a3AEilkunu1aLq9muwWas3E06BF/Nvt
	xOqrHt7rvkNJtSdrBOuXDAtiqUQghVzYE5b3WDS1ZuP7js0FZpynZucIo7iIF1ft
	tSeE9d3PUteKgZhiQ/qI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=bmAHq2sN3oef9YrGX2+QaCWmE0EE4y4GiBmGTYhVDhVi15vu6
	J4Bo/acDJ6422Ij95fOIzv7MOn31MR2CornT64CINzbuR6iVoFs6uSratP79Qu3e
	VBhlTnrKkdEen1tv0DpYAov/hCEftbB0fWGJQPJBrQbJT1RkRfTWFEya2Q=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2AF34AD4B7;
	Tue,  5 Jan 2010 20:07:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EC100AD4B6; Tue,  5 Jan 2010
 20:06:57 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CDEA90E0-FA5F-11DE-B62C-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136230>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Junio, could you tell us what happened to this thread?
>
> Makefile improvements.  No discussion.

I was mildly interested in the series, but after this:

http://thread.gmane.org/gmane.comp.version-control.git/133872/focus=133911

the progress seems to have stopped.
