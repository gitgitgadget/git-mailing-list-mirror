From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [msysGit] [PATCH/RFC] autocrlf: Make it work also for
 un-normalized repositories
Date: Mon, 10 May 2010 11:48:43 -0700
Message-ID: <7v1vdj8ues.fsf@alter.siamese.dyndns.org>
References: <20100510171119.GA17875@pvv.org>
 <alpine.DEB.1.00.1005101921460.7651@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org,
	msysgit@googlegroups.com,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 10 20:49:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBY2O-0004xG-4M
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 20:49:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755280Ab0EJStB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 14:49:01 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41003 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754985Ab0EJStA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 14:49:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 64220B1760;
	Mon, 10 May 2010 14:48:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iUEpX85JKtLFo1IxxBKt3GRQDBI=; b=Y/k0ga
	Xq7KfloLiY9DSLTb83Dm30qIKIMEeAq6+gzEcYdgOyCFAWoPT4X3ir5ubm7a6LB5
	sM8bNMU/ZwkRu4TuI04TGhPZPjbwXqoCoquRDFRS4f9aN+nxRzL+Dv0lsiidONAA
	EpvL/DmUVLA9Ah5QtYtufHateV2GhBzZmqnzI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y9hpWYrl1J/R6XCa5SPDNoU6eHiWItpC
	aMWxA/99BzXqKh2tKxv4DxkG5I3OGdOUJkxZ9+K5SAAlaYAa8WkhN2T1Pt0PU7Df
	0KhAMtki8HDpSRxMWHplb1TF/7/YmDESb4s65aDu/bvAyBJm/dawRbWT9E9IT1fC
	smdSLFY/llI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EAFBAB175B;
	Mon, 10 May 2010 14:48:52 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE98CB1752; Mon, 10 May
 2010 14:48:45 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.1005101921460.7651@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Mon\, 10 May 2010 19\:29\:34 +0200
 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ADF3C5B0-5C64-11DF-8AAE-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146845>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Note that ALL the tests still pass unmodified. This is a bit
>> surprising perhaps, but think it is an indication that no one ever
>> intented autocrlf to do what it does to files containing CRs.
>
> Indeed. But a test of its own would be nice, no? If you do not have time, 
> I will come up with one.

Thanks for a review.  This is a good stuff.
