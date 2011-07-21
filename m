From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 36/48] merge-recursive: Provide more info in conflict
 markers with file renames
Date: Thu, 21 Jul 2011 11:43:25 -0700
Message-ID: <7vvcuv1nle.fsf@alter.siamese.dyndns.org>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
 <1307518278-23814-37-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 20:43:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjyDd-0004wL-Mb
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 20:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505Ab1GUSn2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 14:43:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45336 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752481Ab1GUSn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 14:43:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5D393044;
	Thu, 21 Jul 2011 14:43:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=NXZT9AIz/L5uBlfGDQVgovw1TP4=; b=axyN834C0RHuxoXEf8q6
	WB9w8hc83M4OZ71dX35tM1Gv/jwU43qWl99A/4+bd/HPSGOlpVV1wc5ZNP10hUYG
	ktRAmk92G/TAk5tK/NcCpYD8jhXRJcpsFhhsdc9atlGepjMvP1l817dZTQYtKxiC
	y2G8sDO1iYjpQnD9jyRQGrA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=fXxZbYV60sF46Jqmo7oBzBf42/RnGO7tZXxwMxxhvpWSny
	sPTsqTVkdhdNx/rpQqu8CWqngtHxl4nGELMbYnxK+mU9USJVXUiH3NmEIlYD3DhO
	0m6eFLQdVYx8HK8JR3Wt0PoBS7RMkx2ZmtO5ygzDV95Dj+56bQOfTHmQJ1yzw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCDCD3043;
	Thu, 21 Jul 2011 14:43:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 626E73041; Thu, 21 Jul 2011
 14:43:26 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 51D9C046-B3C9-11E0-8152-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177611>

Elijah Newren <newren@gmail.com> writes:

> Whenever there are merge conflicts in file contents, we would mark the
> different sides of the conflict with the two branches being merged.
> However, when there is a rename involved as well, the branchname is not
> sufficient to specify where the conflicting content came from.  In such
> cases, mark the two sides of the conflict with branchname:filename rather
> than just branchname.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>

Nice.
