From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git EOL Normalization
Date: Thu, 26 May 2011 09:07:21 -0700
Message-ID: <7v1uzlzbra.fsf@alter.siamese.dyndns.org>
References: <20833035.39857.1306334468204.JavaMail.root@mail.hq.genarts.com>
 <29536877.39971.1306336806278.JavaMail.root@mail.hq.genarts.com>
 <BANLkTik3iRKx4P_3nbzygadmLPEOr2vGhA@mail.gmail.com>
 <m3y61uxan2.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Stephen Bash <bash@genarts.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 26 18:07:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPd63-0002ow-9d
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 18:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757889Ab1EZQHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 12:07:34 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53379 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756289Ab1EZQHd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 12:07:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3ADA74BE1;
	Thu, 26 May 2011 12:09:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UKTe80S4gYONhNtzGrkTSsql5K4=; b=vnB9K8
	qYhhIWMVCr+QdaQAoaI1kBF3gWEjX1X+aCSG9Atu0D33pfG+K3ejspWA9l/OiBOg
	Hcc3ovAYPBIH1/PzL3xTqkBbgc1REgvRgqTY8ORLSYUqZ84YriCSYfWGxVx01/bf
	xDmSSerBeqTeoQ3+MSUYAyOrLSO+n4NHpCON4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VdkxJjO/DIcPnPviWO9iVWG3ZwByntOk
	AJJCBoKavilMzZsUVq2zhcW7GaipEI6Uw6+flxVM6L3SV55gq4zYfijMF1DQLrEK
	UoXph89cyQg6ShPsW15eGSZPm/6Qp/IXoqfo6Xjx7Q9H9e/DFJtuHUmtGguayRhK
	hKJq4eecelM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ED9324BDF;
	Thu, 26 May 2011 12:09:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A49644BDD; Thu, 26 May 2011
 12:09:30 -0400 (EDT)
In-Reply-To: <m3y61uxan2.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Wed, 25 May 2011 23:02:35 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8CE66470-87B2-11E0-B4E1-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174539>

Jakub Narebski <jnareb@gmail.com> writes:

> I think git examines only first block of a file or so.  The heuristic
> to detect binary-ness of a file is, as I have heard, the same or
> similar to the one that GNU diff uses.

Yes, the binary detection was designed to be compatible with GNU diff. But
I do not think it has much to do with the topic of this thread. Aren't
other people discussing the line ending?
