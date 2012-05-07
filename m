From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] correct git-status Porcelain Format documentation
Date: Mon, 07 May 2012 11:03:29 -0700
Message-ID: <7vsjfb6f7y.fsf@alter.siamese.dyndns.org>
References: <20120506132959.GA28214@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 07 20:03:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRSHY-0002F7-L3
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 20:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364Ab2EGSDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 14:03:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48638 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753185Ab2EGSDb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 14:03:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 049D06AA4;
	Mon,  7 May 2012 14:03:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k5OjZDGAhymwt2/T9M/rCgyOtIM=; b=JNmRuD
	Xy5I5uxmVEFFEWCEr00wiwdu8Pwp3/em1O2P+4GUOL22tNd+wsWRfyA1Qu8uU/sk
	VanmgnbNq1TMMAIquywsBYYBj+kuxIxIrPgldZ2RLj31ecxLi0AuajhjuICzMmU9
	8oVPFfymAHeUDrh7DsgzDxMWXR2b0aET2jzJE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=elG9A6wB0elcT8bi/s/4CQOhBc+Q9UpT
	qJfq2n9DnIA2RBoUdYr59gA5JCiuCppeYE414hLW6p4lHuaoKmqYfiCRbzKM0rXT
	2nSBByK5U3OGrALIPtt540wDvFdHP9X9hqa1PlsSB6UNXwnaXdHV/qfSSk3ZxufV
	MhjcohGINdw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F00F96AA2;
	Mon,  7 May 2012 14:03:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C9206AA1; Mon,  7 May 2012
 14:03:30 -0400 (EDT)
In-Reply-To: <20120506132959.GA28214@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 6 May 2012 09:29:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F3F487F0-986E-11E1-9677-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197289>

Jeff King <peff@peff.net> writes:

> The patch itself looks obviously correct and describes the current
> behavior. But I have to wonder: the --short format will also not produce
> the branch line unless you provide "-b". So why is it that the porcelain
> format does not respect "-b", since anybody who asked for it would
> obviously be expecting to find and parse it?
>
> Should this bit of documentation be dropped in favor of just making "-b"
> work properly?

I would say so.  Also "branch line" was an undefined term and I had to
read the whole thing to find out what the updated documentation was
talking about; we may want to consistently say "branch and tracking info"
as the earlier part of the document says.
