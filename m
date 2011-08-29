From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] t4014: check for empty files from git format-patch
 --stdout
Date: Mon, 29 Aug 2011 15:30:17 -0700
Message-ID: <7vsjoj4zra.fsf@alter.siamese.dyndns.org>
References: <bbfb7190ca0125798417f57f4d33b5443257e478.1314648438.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Stephen Boyd <bebarino@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 30 00:30:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyALZ-00040l-Ka
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 00:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754805Ab1H2WaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 18:30:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59661 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753838Ab1H2WaU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 18:30:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8582850C2;
	Mon, 29 Aug 2011 18:30:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=M7D+v6
	1UrcYzzugfwl2YpsdHxfnfI+XwucRMFJHWGTQXzmlFzhWnetfZNKgvv3WBJLJXBV
	kMU4Yz+nCDxOqh4DWOnzDfYyjkXJUjAhLnhugIZFl15n8CykPFbHf/5V/JF6f0Fw
	kFTzEGXxiDay67NPPZA8rF2C/v1L5mR7sYu5w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pc2FKFM51JiVX7nUbIIKUWGAF46WeuUu
	opsRSsn9U84ZhTZ6HPQPrwHvI3YSHe0qM64uFcg/fCr8s54wPjfJrjZG2CIXC+Ns
	BqLT47UZXu+m8uRCi43h+SDHZ8pYqHT59I/RyP3rMkqF2dA53ma0X0gR9/DgHsmY
	PwPX43pY2RM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D77550C1;
	Mon, 29 Aug 2011 18:30:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0EFC950BC; Mon, 29 Aug 2011
 18:30:18 -0400 (EDT)
In-Reply-To: <bbfb7190ca0125798417f57f4d33b5443257e478.1314648438.git.trast@student.ethz.ch> (Thomas Rast's message of "Mon, 29 Aug 2011 22:10:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 79BCE97E-D28E-11E0-B82A-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180370>

Thanks.
