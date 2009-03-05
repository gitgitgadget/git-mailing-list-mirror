From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] better introduction of GIT with USE_NSEC defined
Date: Wed, 04 Mar 2009 23:38:09 -0800
Message-ID: <7v8wnk4dy6.fsf@gitster.siamese.dyndns.org>
References: <cover.1236187259.git.barvik@broadpark.no>
 <6d937a859ca499f534eea08720fca84f3d4ded2f.1236187259.git.barvik@broadpark.no>
 <7vk5744x87.fsf@gitster.siamese.dyndns.org> <86prgwqvzr.fsf@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Thu Mar 05 08:39:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lf8BM-0003Gh-G4
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 08:39:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753566AbZCEHiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 02:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753481AbZCEHiT
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 02:38:19 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48812 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956AbZCEHiS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 02:38:18 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AE1399FC99;
	Thu,  5 Mar 2009 02:38:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5591A9FC96; Thu,
  5 Mar 2009 02:38:13 -0500 (EST)
In-Reply-To: <86prgwqvzr.fsf@broadpark.no> (Kjetil Barvik's message of "Thu,
 05 Mar 2009 08:17:28 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 973E01D8-0958-11DE-9540-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112262>

Kjetil Barvik <barvik@broadpark.no> writes:

> Junio C Hamano <gitster@pobox.com> writes:
> ...
>>     How does this affect a use case where the same index file used with two 
>>     instances of git (one compiled with and another without USE_NSEC)?
>
>   If both persons in this use case use this patch, the one with USE_NSEC
>   defined will now be able to take full advantage of the nanosecond
>   timestamps at all times.
>
>   The one without USE_NSEC defined should not be able to tell the
>   difference (without looking into to details of the index file).

As long as the implementation does not give false cleanliness it is
perfectly fine; false dirtinesss is just a bit of wasted cycle.

Thanks.
