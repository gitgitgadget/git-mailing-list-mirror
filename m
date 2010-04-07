From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 resend 2/2] remote-curl: ensure that URLs have a
 trailing slash
Date: Wed, 07 Apr 2010 16:15:19 -0700
Message-ID: <7vsk76am7s.fsf@alter.siamese.dyndns.org>
References: <p2ube6fef0d1004070857j874c2b60z6a4794d472b0ee8a@mail.gmail.com>
 <1270656067-688-1-git-send-email-rctay89@gmail.com>
 <1270656067-688-2-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 01:15:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzeTK-0002vY-7K
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 01:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757603Ab0DGXPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 19:15:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44641 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757327Ab0DGXPb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 19:15:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D8EA6A8829;
	Wed,  7 Apr 2010 19:15:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PqrGcQy7ovbSjGcZfT9qr4DeiYc=; b=oh5f1R
	RqAu93E2+0iy57h04BTPs+PvqCtD8YISGsW0tLqsrqb9EVfEcTRRM8OLrIJJ9Kmf
	YmesUMAPehMOx6PbCnDFdQ376qlrf2o0/SXbr5//CV8dzX6q9mvg7JnZCjV4tDJs
	xU+ycog07T4rNyDx6qSiH/IGYd4QBbBA3uRMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fpjsAM0q3lE16NZOWVdH/x1sqTSqZ0im
	5hpLY0xOPlxlzUOmIxoTdFKRu5eD7lmhT5X/xfgJJmvZm2HdiNW6vntrBmzeqb4j
	1A7542yP3Wm2A43p1nl3uhfDLJeQM+118ka3dxgR3Jkj8DPeSYgBzQngPVy9R998
	Vrvbn+7sNnY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B279FA8824;
	Wed,  7 Apr 2010 19:15:25 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C1D2A8819; Wed,  7 Apr
 2010 19:15:20 -0400 (EDT)
In-Reply-To: <1270656067-688-2-git-send-email-rctay89@gmail.com> (Tay Ray
 Chuan's message of "Thu\,  8 Apr 2010 00\:01\:07 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 72BFCC42-429B-11DF-82C8-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144297>

You didn't explain what it is for, nor sign-off this patch, but is this a
clean-up?  Is this a bugfix?  Is this an RFC?
