From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Documentation: clarify effects of -- <path> arguments
Date: Tue, 30 Aug 2011 11:03:38 -0700
Message-ID: <7vvcte22v9.fsf@alter.siamese.dyndns.org>
References: <7vbov74w25.fsf@alter.siamese.dyndns.org>
 <73058a4801ea2707f5ffa12150682ee0522385eb.1314695984.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 30 20:03:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QySf4-0001Y0-GS
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 20:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755921Ab1H3SDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 14:03:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63001 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754141Ab1H3SDl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 14:03:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 570594974;
	Tue, 30 Aug 2011 14:03:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=cBaQo8uYVXfLcLn1XNfDR8AIgNA=; b=p5Nxh6ueo8TSr7h9zgkJ
	kpMUqoxab+Df/191O0nP0hRH9j8/j5JsRvoh3yVByeGZnpe966W2JH67LQMxKZVY
	RovvuBGn5YuxBI4L7Z7x3HUQhII0QBR7rEODhHWdb56+oVfcqxBLMy+V2FmrgeM3
	zJEIuNtIPa2TyCZQ/ovLBkI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=hsB8rawOtFGTYWaugDX4pYoruHsNbXGmeA+VL285g8iTyQ
	WtdBUa7na1ZcKd+gCodd+uqZa5QAvuHfl0LujI+omXLj9WV4ms0VTeuSOkdtNfP5
	GY/J7ViXREZRPfq36C0K9Mr/D4IKVA7a3ykBqIwGYBruEHHFIWcqvBoBLqPgs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E0744973;
	Tue, 30 Aug 2011 14:03:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D87074972; Tue, 30 Aug 2011
 14:03:39 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 63E623A0-D332-11E0-A7DE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180426>

Thomas Rast <trast@student.ethz.ch> writes:

> Or both?

Certainly; I didn't mean to reject the "see also". It just didn't look
right not to update the original sentence that seemed to have caused
confusion to new people.

Applied.
