From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix httpd tests that broke when non-ff push advice
 changed
Date: Thu, 12 Apr 2012 14:51:47 -0700
Message-ID: <7vhawo4o0c.fsf@alter.siamese.dyndns.org>
References: <9F768A58-DEB0-43E1-8AE4-B2A5C4E6CDE9@silverinsanity.com>
 <20120412133701.GA367@gmail.com> <20120412140049.GB367@gmail.com>
 <7v8vi1gdzk.fsf@alter.siamese.dyndns.org> <20120412175628.GH367@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <brian@silverinsanity.com>,
	Git List <git@vger.kernel.org>
To: Christopher Tiwald <christiwald@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 23:52:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIRvr-00016X-Uc
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 23:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966052Ab2DLVvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 17:51:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49539 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966031Ab2DLVvu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 17:51:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68C8267BF;
	Thu, 12 Apr 2012 17:51:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KNdD+/HH/30fkiZp8BtadRnMeLE=; b=FI7a3e
	qrWLz4E6K5dzkuRrIPYFe0gHrVj+q/WKnm2ppKYZYbUF98dWobNUS+qOEgORGcEl
	Zaky/yET2nIIBUXyY+5KzZn94nb2rrtvrpYNli8v1jJhv1L4aEr0lfAQpXvq5PLT
	nOK6YUazm12+UaNN/niLN3gf1+PiVj/R7AU8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wWAugwIboOSeByGPNdgTz9skUuqRqRSg
	4j//TfolmfS1WnnX2CRmFR6idZIaiMzkayk87SVaSvNd+tGzZhYN0HMKyyOZJzCM
	5uKNc1oKGIDE99SkOsRh/bMvDw+EBbGDWM9XSuQeaoZIx+2RjK1YivkWIJwn8ebP
	8ZVwu7NMrks=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E2D267BE;
	Thu, 12 Apr 2012 17:51:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D5ED467BA; Thu, 12 Apr 2012
 17:51:48 -0400 (EDT)
In-Reply-To: <20120412175628.GH367@gmail.com> (Christopher Tiwald's message
 of "Thu, 12 Apr 2012 13:56:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B4884D38-84E9-11E1-984A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195376>

Christopher Tiwald <christiwald@gmail.com> writes:

> On Thu, Apr 12, 2012 at 08:35:11AM -0700, Junio C Hamano wrote:
>> Please do so.  I assume that the test vectors were expecting specific
>> error/advice messages that need to be updated?
>
> Looks to be the case. The below fixes the tests on my machine. It might
> be worth adding tests to check the specific advice messages, but that's a
> different topic and regardless wouldn't belong in the http-push series.

Thanks.
