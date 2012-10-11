From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Patch v2 0/8] Create single PDF for all HTML files
Date: Thu, 11 Oct 2012 12:30:25 -0700
Message-ID: <7v7gqw7qni.fsf@alter.siamese.dyndns.org>
References: <1412437370.46782.1349975589890.JavaMail.ngmail@webmail22.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, philipoakley@iee.org, peff@peff.net
To: Thomas Ackermann <th.acker66@arcor.de>
X-From: git-owner@vger.kernel.org Thu Oct 11 21:31:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMOTx-0006KI-K7
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 21:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759203Ab2JKTa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 15:30:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37327 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758870Ab2JKTa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 15:30:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5116897A;
	Thu, 11 Oct 2012 15:30:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O6LpsM3srZqH4egrad+xK0rWNrE=; b=fXEzdG
	6jxwwiur18pCqncsFXHjO1tc8WoDS+6nO3PHc8Niom7IJ87UX1WLMvEulyIQ0sHv
	Q0YeeTL1z2DcaYCyYyPmCUC8vWIHbOZ7xiZiGuTvqsw14pXpW8iKVC62JhChDvZO
	yVjxZ8v0PxJAlJve88cBNA2uDxigIHQazJN+s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y1b5HW4dk1axAum5GvKgnjO5akWGGt5i
	o9lBMTkVZPWYKtl3NCL6u2R13jzhUFgpo6hfYp3q/pFC/0JHNbrNo+UDUdk5eh4j
	wktzbLGHT9lsbT7XolyMjz15VhpxcZ1q+Cc/hpF/TTPIFfTZEuKFXLkJ4B82tcBm
	17wSCYookuI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 924508979;
	Thu, 11 Oct 2012 15:30:27 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 098F38978; Thu, 11 Oct 2012
 15:30:26 -0400 (EDT)
In-Reply-To: <1412437370.46782.1349975589890.JavaMail.ngmail@webmail22.arcor-online.net>
 (Thomas Ackermann's message of "Thu, 11 Oct 2012 19:13:09 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1C244274-13DA-11E2-A8BE-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207508>

Thomas Ackermann <th.acker66@arcor.de> writes:

> In general, the following problems had to be fixed in doc files in order to create
> HTML by using asciidoc and afterwards create a nice looking PDF using wkhtmltopdf:
>
> - Wrong sectioning syntax (e.g. "===" instead of "---")
> - Left-over shell scripting commands (in some release notes files)
> - Over-long lines which caused very wide right margins in the resulting PDF
> - Wrong formatting for email quotes, quoted script code, tables
>
> Also some of the headlines in the documents where changed or even created
> initially in order to give a more consistent structure in the resulting PDF.

It is kind of surprising to see that these documents already are so
close to be kosher asciidoc.  That were never meant to be used with
asciidoc as we wrote them.
