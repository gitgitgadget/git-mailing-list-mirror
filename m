From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/10] fmt-merge-msg: Add contents of merged tag in the
 merge message
Date: Sat, 05 Nov 2011 23:03:45 -0700
Message-ID: <7vty6h7poe.fsf@alter.siamese.dyndns.org>
References: <1320472900-6601-1-git-send-email-gitster@pobox.com>
 <1320472900-6601-10-git-send-email-gitster@pobox.com>
 <4EB4F74D.7090004@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Nov 06 07:04:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMvpn-0002jI-FG
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 07:03:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791Ab1KFGDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Nov 2011 01:03:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57604 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750743Ab1KFGDs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2011 01:03:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A263F414A;
	Sun,  6 Nov 2011 01:03:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n5AAl74b7Ww4BZXziX422F6wnQk=; b=K9cU4B
	cQw1WiP1ma9p5lrL4e06K4TLBN1f/uy6tikEvYu+RewbwE8loVYcqIuAqrgFDgg6
	uiMcajLQbvJyAI74gCRsRWwiei8s/py7X9BEL52zGJoDJ5BO/seokTZVgXgIqJsS
	XRGoqTYzcbrcHYeRFFpN3nmlAYXDlRN+jztys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c6JbL4Q2DPLjrowosjetcHWdFYESWday
	O6ljEjeDPfLr+1fJYnkqMjYD1I6T3fWyDrnHHSXeP90AwlwKdbE/M7hHmqZOww/J
	KxDc+Y2ihcQpB2Gt6GJHqjyTVDaoC835whpzn/rhgquukGss+rSjQy4hBSa9X5Fq
	hLGgySRfnuM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A680413F;
	Sun,  6 Nov 2011 01:03:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 33E5B413E; Sun,  6 Nov 2011
 01:03:47 -0500 (EST)
In-Reply-To: <4EB4F74D.7090004@kdbg.org> (Johannes Sixt's message of "Sat, 05
 Nov 2011 09:43:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 17263C0E-083D-11E1-8E67-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184901>

Johannes Sixt <j6t@kdbg.org> writes:

> Since the tag signature depends on the tag message, including all spelin
> errors, the integrator must not change the text so that third parties
> can repeat the verification. (Correct?) I assume this is the reason that
> you put 'tag:' in front of the tag message, to discourage any changes.

Yes, but after reading response from Linus in the other thread, I think we
came up with even a better plan.

> What if the tag is not signed?

Thanks for raising a good point. See 

    http://thread.gmane.org/gmane.linux.ide/50518/focus=1211568

for the revised plan.
