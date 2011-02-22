From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] diff: don't retrieve binary blobs for diffstat
Date: Tue, 22 Feb 2011 11:00:20 -0800
Message-ID: <7voc63dhdn.fsf@alter.siamese.dyndns.org>
References: <20110219080307.GA18039@sigill.intra.peff.net>
 <20110219081631.GB18056@sigill.intra.peff.net>
 <7v62sdhsjy.fsf@alter.siamese.dyndns.org>
 <20110222153729.GA27178@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 22 20:00:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrxTU-0007pN-KF
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 20:00:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212Ab1BVTAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 14:00:36 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50629 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085Ab1BVTAf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 14:00:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 748314F60;
	Tue, 22 Feb 2011 14:01:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zrsMr+GJHk2L8dKiOVUO3Vu28LY=; b=lcyCo0
	m500OoTSdc7EQKX2l9igpbfg4Sbm83hIzWahtYAQKIkW+vJbl1s66p9GQ/Sf/Hr2
	Et+boDegWr54r7Nn2KJCLiindTB6BJuXobQpdY0WaqYf3scIH48ZNxQNkjlTEqna
	A84ZYEDSt1bIJfG0rZMq1D4ULP73hIHgEs4Ig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RN1CU1qlY/8gCQy1YO7m/7H2up53C/pK
	MwLgmbIkF5/ojSwbLe2BKQpbwMl0Wd7TPvYMnJ0lV3W9ji7g+MGlQwKqIBfA1FRH
	bECEPWHrpkyJ6yNlqNXPN7Y6eXnbpb5prjMD1vfRMHx/1v70DiZoaW/QadZRgdo0
	j6oRmQrZ64w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3411B4F5F;
	Tue, 22 Feb 2011 14:01:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5DFDC4F55; Tue, 22 Feb 2011
 14:01:33 -0500 (EST)
In-Reply-To: <20110222153729.GA27178@sigill.intra.peff.net> (Jeff King's
 message of "Tue\, 22 Feb 2011 10\:37\:29 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2ED288E0-3EB6-11E0-A2A7-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167573>

Jeff King <peff@peff.net> writes:

>> Nice ;-)  Do we want a test or two for 1/2 by the way?
>
> Yeah, it's probably a good idea. Can you squash this in,...

Done; thanks.
