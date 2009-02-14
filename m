From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: allow send-email to run outside a repo
Date: Fri, 13 Feb 2009 22:42:53 -0800
Message-ID: <7vocx5zfgy.fsf@gitster.siamese.dyndns.org>
References: <1234589913-67684-1-git-send-email-jaysoffian@gmail.com>
 <7vvdrdzfmm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 07:45:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYEGq-0005qS-7x
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 07:45:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600AbZBNGnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 01:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752571AbZBNGnA
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 01:43:00 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58961 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbZBNGnA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 01:43:00 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5A7F12B181;
	Sat, 14 Feb 2009 01:42:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8DC8A2B182; Sat,
 14 Feb 2009 01:42:55 -0500 (EST)
In-Reply-To: <7vvdrdzfmm.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 13 Feb 2009 22:39:29 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B81B4EEC-FA62-11DD-A1FF-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109832>

Junio C Hamano <gitster@pobox.com> writes:

> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> This is on top of my previous send-email commits from tonight. I'm not
>> sure whether it applies cleanly otherwise.
>
> I think unlike the --suppress-cc ones that are about changing semantics
> (and it does not matter "to a much saner one"), this is a fix that is more
> important for the upcoming release.  Splitting Cc list and folding headers
> also fall into the same category, I think.
>
> I'd prefer a rebased series to have fixes first and then enhancements.
>
> Thanks.

Nah, please disregard.  This applies cleanly to the series before 3/3
which I think should not be 1.6.2, so we are in good shape.

Thanks.
