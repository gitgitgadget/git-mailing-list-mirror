From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] diffcore-pickaxe doc: document -S and -G properly
Date: Mon, 03 Jun 2013 10:54:43 -0700
Message-ID: <7vsj0zf5b0.fsf@alter.siamese.dyndns.org>
References: <1370002335-6596-1-git-send-email-artagnon@gmail.com>
	<1370002335-6596-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 19:54:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjYy4-0002pz-I3
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 19:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757050Ab3FCRyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 13:54:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61322 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753368Ab3FCRyr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 13:54:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD36424444;
	Mon,  3 Jun 2013 17:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cwPTSU+nUT+aXBdcPIo9ml5c/Rs=; b=Sln7zb
	XzlmzidsvPdFHom/UzJ9BJvBDgbLvYE+rafvhzDF2XHP9rOv0srED/bwShTyfn7E
	yO582vZiyNX8E5nX3IOjFzAKwsimsVByKceV3P2xyDpVQMw5i3wD78ZoosCvxDk0
	Fe/BFieVT76bnodki21T3eyvYWZfQ+tFQUabk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RReT91eRN2t2ML4DPPLXJBfRZyBpO9A2
	1PkuGjwhBCMNWyOnuEjMhlT2xgLLW5M7ZMOqZF/onNpRZr3e2cOSJ3GpTesrktPh
	hyv6n5BpEW3PoxrZHsZ4s5ftgQw/mWsvguQB5YnADcjpu1KzN2cj+6uuNv3oSOdM
	oNq2V/RQ4c0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E88D24441;
	Mon,  3 Jun 2013 17:54:46 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 12A1C2443E;
	Mon,  3 Jun 2013 17:54:45 +0000 (UTC)
In-Reply-To: <1370002335-6596-3-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Fri, 31 May 2013 17:42:15 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AD565084-CC76-11E2-9CCE-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226251>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> The documentation of -S and -G is very sketchy.  Completely rewrite the
> sections in Documentation/diff-options.txt and
> Documentation/gitdiffcore.txt.

Will queue; thanks.
