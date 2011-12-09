From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 0/13] credential helpers
Date: Fri, 09 Dec 2011 15:56:44 -0800
Message-ID: <7vaa71cn9f.fsf@alter.siamese.dyndns.org>
References: <20111206062127.GA29046@sigill.intra.peff.net>
 <7v7h29fkfy.fsf@alter.siamese.dyndns.org>
 <20111207064231.GA499@sigill.intra.peff.net>
 <7vmxb2hhne.fsf@alter.siamese.dyndns.org>
 <20111209022913.GA2600@sigill.intra.peff.net>
 <7vzkf1fwvn.fsf@alter.siamese.dyndns.org>
 <20111209231800.GA14376@sigill.intra.peff.net>
 <7vehwdcob3.fsf@alter.siamese.dyndns.org>
 <20111209233957.GC10560@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 10 00:56:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZAJ9-00016X-0r
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 00:56:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755039Ab1LIX4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 18:56:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44548 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752602Ab1LIX4q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 18:56:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 040A66BD1;
	Fri,  9 Dec 2011 18:56:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G8Tut8FTxf7f2REfMsPcH1HNsEU=; b=Scbs7C
	7CGHbXchJpg1WDbGntrxzAXUjuCBi7cG0GXrUnNA1dN7QA456vAYPSrdRWPPiPwA
	l/9NnmM+E6uyZhQR36Yammep9zx8GsuroTbWr73CODMnXTSfWxWuZSzCGCoOpBwW
	GRPfdWtY7lh7z6RTDscTuyufaVeOvSN+FIFXY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AtSGNl/s3Aj8gqLVcGhSQjcWmmZE0VFd
	yTx/1hP/KD4sdBKMpXEITxTQtNhboa/8Jb3UujCX4J/uZxt0qsZgpjiPrqjpvX3i
	ppxvaJiYP1iSqt9bdR1xpmff9AoAvqYZMblYBUn/HX3BtZ7toCB6yzY3Bwh2/xR4
	rplV5+pejcc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF7FB6BD0;
	Fri,  9 Dec 2011 18:56:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 841A56BCF; Fri,  9 Dec 2011
 18:56:45 -0500 (EST)
In-Reply-To: <20111209233957.GC10560@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 9 Dec 2011 18:39:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 734146FC-22C1-11E1-AF01-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186710>

Jeff King <peff@peff.net> writes:

> Speaking of which, I hackishly ported Jay's osxkeychain helper to the
> new format last night. I'll try to clean that up and post it tonight.

;-).
