From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP PATCH] Manual rename correction
Date: Tue, 31 Jul 2012 13:20:42 -0700
Message-ID: <7vfw87isx1.fsf@alter.siamese.dyndns.org>
References: <20120731141536.GA26283@do>
 <7vtxwnki1a.fsf@alter.siamese.dyndns.org>
 <20120731192342.GB30808@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 31 22:20:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwIvy-0007Vj-Tj
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 22:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411Ab2GaUUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 16:20:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50044 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751139Ab2GaUUp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 16:20:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87D18996B;
	Tue, 31 Jul 2012 16:20:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vAWA5TLP06cHNUZWhjginjTCheM=; b=nnwOR3
	/iTbJIzs7la5/iE7EHkb8nRZwigCbzlBfTPQ9xvOoFLeVB4vzkOnxKp9m1jVSpmq
	56e7wIkfdfCKaNieZ9i2vXCGhS5FO+upGSfzIIqdjijcBMg48d1q49vIVBSn9XTr
	3SwRCa9FmqzpbwdH7x+SZunE2tub5/PEziWpU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oHvX+zUxzAQBx+1pnRCXAudCROG2llKp
	YvA/r/AmJYuPJEnz4HEJxvpVH3pQxqTv9CTJ/+sdcyLqwKr+t54H3O9JDcBkFSE1
	f5xGq1hCxQudqnLbX2tYRHnKPr1lbGauVsWNHsTVBrHhtBh8TDSt1yVrptM1iR/H
	04dKWhJoOa4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 744EC996A;
	Tue, 31 Jul 2012 16:20:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E557A9969; Tue, 31 Jul 2012
 16:20:43 -0400 (EDT)
In-Reply-To: <20120731192342.GB30808@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 31 Jul 2012 15:23:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 349C97EA-DB4D-11E1-92DC-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202682>

Jeff King <peff@peff.net> writes:

> A much better hint is to annotate pairs of sha1s, to say "do not bother
> doing inexact rename correlation on this pair; I promise that they have
> value N".

Surely.  And I suspect that the patch to the current codebase to do
so would be much less impact if you go that way.
