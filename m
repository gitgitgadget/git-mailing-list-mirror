From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v3 7/9] write_entry(): use fstat() instead of lstat()
 when file is open
Date: Wed, 04 Feb 2009 12:30:36 -0800
Message-ID: <7vbptiosgj.fsf@gitster.siamese.dyndns.org>
References: <cover.1233751281.git.barvik@broadpark.no>
 <21073c1f3f6c2c81b26a632f495325f5e7a7de5a.1233751281.git.barvik@broadpark.no>
 <49899FA4.2020003@viscovery.net> <7vfxiut57t.fsf@gitster.siamese.dyndns.org>
 <86tz7ayo51.fsf_-_@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Wed Feb 04 21:32:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUoQ1-0007iU-C7
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 21:32:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271AbZBDUap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 15:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752150AbZBDUap
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 15:30:45 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42294 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbZBDUao (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 15:30:44 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 20C1D2A713;
	Wed,  4 Feb 2009 15:30:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 149F22A70F; Wed, 
 4 Feb 2009 15:30:37 -0500 (EST)
In-Reply-To: <86tz7ayo51.fsf_-_@broadpark.no> (Kjetil Barvik's message of
 "Wed, 04 Feb 2009 20:53:46 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B14827C6-F2FA-11DD-978C-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108425>

Kjetil Barvik <barvik@broadpark.no> writes:

>   Junio, is it OK to ask that you drop this patch if/when you update the
>   pu branch, such that I do not have to resend the patch series almost
>   unchanged to the mailinglist (except for one missing patch)?

Surely.  Although I've replaced the topic with the updated series, I am
not in the reintegration phase yet, so not much work is lost.  I was
planning to merge this to 'next' today after one last round of eyeballing.

Thanks.
