From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git status: small difference between stating whole repository
 and small subdirectory
Date: Tue, 21 Feb 2012 18:55:10 -0800
Message-ID: <7v7gzfefw1.fsf@alter.siamese.dyndns.org>
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
 <7v8vjwgfoq.fsf@alter.siamese.dyndns.org>
 <CACsJy8C3Myqs4=GvURWqCTxGp0R1RWotdiHGnnvBSaxyTteujw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, Jeff King <peff@peff.net>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 03:55:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S02MT-0000xe-DF
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 03:55:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755467Ab2BVCzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 21:55:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45992 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753747Ab2BVCzN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 21:55:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD66C7EDE;
	Tue, 21 Feb 2012 21:55:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hiOApm41RQtt1BWHCzWz1fi8ELA=; b=bpE/cq
	B74c4OozwY0SR+uASMogUhVLo9xQJDFvmv69qIFlIeVGvlk7DJY6RH4Lo1Xh+r20
	vqrVvZlfHiubTRHnV389cvAGzNA9Z/VeyTayOlSfsr7b1VOSA4DWvb/rncAppWi8
	IRMgKVDy82aR4T1K1RUHgxE3K8leb6KBf45/w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SROPwhhAfWG2F825ZcFZeWS8lGgirE/q
	fFr7kFgkg1XY6Rgs8F77U//qgfQBtoAjcdHQULrCV8WChM7aet1MVOVkEKdqjBaY
	8bwWJAPYNwDaCgOy4oKPV0YmASTPZqIsDkAIJ0cBQLNrM+tU1Xs12qnBF4UXXnwn
	c9G4Jk3Uduk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B47097EDD;
	Tue, 21 Feb 2012 21:55:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BE3BC7EDB; Tue, 21 Feb 2012
 21:55:11 -0500 (EST)
In-Reply-To: <CACsJy8C3Myqs4=GvURWqCTxGp0R1RWotdiHGnnvBSaxyTteujw@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 22 Feb 2012 09:12:22 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A34317E4-5D00-11E1-A5D2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191226>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> That makes me think if "diff --cached" can take advantage of
> cache-tree to avoid walking down valid cached trees and do tree-tree
> diff in those cases instead. Not sure if it gains us anything but code
> complexity.

Why do I have this funny feeling that we saw that comment in this thread
already?
