From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-config.txt: fix example
Date: Sat, 18 Aug 2012 13:45:15 -0700
Message-ID: <7v393krktg.fsf@alter.siamese.dyndns.org>
References: <1345311130-20426-1-git-send-email-mhagger@alum.mit.edu>
 <1345311130-20426-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Sat Aug 18 22:45:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2ptd-0006Ix-LF
	for gcvg-git-2@plane.gmane.org; Sat, 18 Aug 2012 22:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240Ab2HRUpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 16:45:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47599 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751108Ab2HRUpS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2012 16:45:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D73479E03;
	Sat, 18 Aug 2012 16:45:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6ZW289XIbb+CL+oGyMWsCHuqMNQ=; b=sKtsE4
	K+whGPAPuRISkZLajoiyQ5Iig1+5skzU37DtsD3oJvnM5RHc0EhjMKFPkW99fg0l
	5+TnwwgL9qzb6SbUjJYyQJM8f3XFA8UgyoY9aaCGZB3LUDud6/SxY7O26Whq+qZw
	YVFvU1wbFlrrXiYm2xlgqrK8mflbD//+qreYI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hUGhI9Vr+TqmzuGHnSjk/q5gxW00605V
	UovL4UVc7I5RNzIVMS0gQBw65h5lTPIJw24U4NwwFxufMv+zer09qDgEjWdRd6PN
	9rsPJegs51EaDdnTVXodBkpRoI2sD4XPDcsknIAzLCenPsg89Cph22XccmhE0iJD
	reBLW0zibdA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C495F9E02;
	Sat, 18 Aug 2012 16:45:17 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 436869E01; Sat, 18 Aug 2012
 16:45:17 -0400 (EDT)
In-Reply-To: <1345311130-20426-3-git-send-email-mhagger@alum.mit.edu>
 (mhagger@alum.mit.edu's message of "Sat, 18 Aug 2012 19:32:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9E39994C-E975-11E1-A7E8-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203700>

mhagger@alum.mit.edu writes:

>  To add a new proxy, without altering any of the existing ones, use
>  
>  ------------
> -% git config core.gitproxy '"proxy-command" for example.com'
> +% git config --add core.gitproxy '"proxy-command" for example.com'
>  ------------

Sensible; thanks.
