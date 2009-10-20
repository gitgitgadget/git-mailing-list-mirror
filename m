From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] pull/fetch rename
Date: Tue, 20 Oct 2009 16:11:32 -0700
Message-ID: <7v7huplkyj.fsf@alter.siamese.dyndns.org>
References: <200910201947.50423.trast@student.ethz.ch>
 <200910201359.30880.wjl@icecavern.net>
 <7vpr8hlow9.fsf@alter.siamese.dyndns.org>
 <200910210053.29794.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Wesley J. Landaker" <wjl@icecavern.net>, <git@vger.kernel.org>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Oct 21 01:17:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0Nru-0006fx-8X
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 01:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709AbZJTXLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 19:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752561AbZJTXLl
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 19:11:41 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61636 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbZJTXLl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 19:11:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 236BC7F7BC;
	Tue, 20 Oct 2009 19:11:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZILQZEEEO8UzH3zM5UGSwZgR5BU=; b=mqL604
	kJmDRxHFJf5xB4tRPHzHmYbaDvyMWb0yb5DQm8N4CKtpzJNFclqkPBWljrnuuiU2
	7ODQnU61i4gqdp/DhUap/kMEKLMPshdIoiNZS+GRjT5Fg/IbOlWW+VzbqnmnKmF9
	qBQ7/xHw0vB0zoKX6QxqRrW+elSV6Gg5+8C9o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GMQxf8w76Xu80IQC0sVWrp/2ycz19Yfg
	05ZB2tIgceawLzcg704V+Lu3X5Bb+U6c6VegzPMUgTv1B1wWgf/MYR98vMuH2Oit
	8y3TFFK8SrKJDdjYR0nsh1A3oXRCjvATnzSw59n1Ri9h+lE3ihBR6Weja5tslTIE
	vM87yeCukM0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E0D3E7F7B8;
	Tue, 20 Oct 2009 19:11:40 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6AA947F7B7; Tue, 20 Oct 2009
 19:11:34 -0400 (EDT)
In-Reply-To: <200910210053.29794.trast@student.ethz.ch> (Thomas Rast's
 message of "Wed\, 21 Oct 2009 00\:53\:28 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ECF013D0-BDCD-11DE-8B16-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130867>

Thomas Rast <trast@student.ethz.ch> writes:

> Junio C Hamano wrote:
>> "Wesley J. Landaker" <wjl@icecavern.net> writes:
> ...
> There would not be a configuration option.
> ...
>> It's not even funny.

Re-read what you were responding to and notice that I was commenting on
Wesley's proposal that _is_ about a configuration variable.
