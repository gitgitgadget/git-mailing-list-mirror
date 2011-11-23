From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-branch: Fix crash on invalid use of --force
Date: Wed, 23 Nov 2011 13:30:11 -0800
Message-ID: <7vsjlea5ng.fsf@alter.siamese.dyndns.org>
References: <1322029915-18486-1-git-send-email-vfr@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: vfr@lyx.org
X-From: git-owner@vger.kernel.org Wed Nov 23 22:30:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTKOd-00089H-6I
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 22:30:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755099Ab1KWVaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 16:30:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39980 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753079Ab1KWVaP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 16:30:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AE7459AB;
	Wed, 23 Nov 2011 16:30:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LCqHmLiT/mpBIxFIMDUbhNpDM6w=; b=hIrFGr
	YtF1nMQOjHUBJDWjAg9aJGtZR3j0VjCgS6ya1xrORjelRljJxQtTi/oQRJTC80Qm
	Ltng8kjuXp+6Tt4Xbfq+Z4NpRDmcJW81z+ir9Nzfhp0K10DFKdIKwFJUgRQb60Lw
	6pt5Y+pKk/vFjX98skkwoDKK4iTlw+0riaIhg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N1rFtw0L5KNpS6gBg3e8xa8mS2b523ZX
	aDkZQrpjMNNvgji2ujm4pN/sarFvf5StfLssq17KXhH6g5zGeAY4DAxO9vevMh6I
	B5tQmkIm10Wg7RfPRddLCusCtwXeLkgTxPWJwkdZTSLPpZW5oqqOJyM7xhwtvUA8
	9KxAsf58uCM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4025959AA;
	Wed, 23 Nov 2011 16:30:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D03E759A9; Wed, 23 Nov 2011
 16:30:12 -0500 (EST)
In-Reply-To: <1322029915-18486-1-git-send-email-vfr@lyx.org> (vfr@lyx.org's
 message of "Wed, 23 Nov 2011 07:31:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 53CB972C-161A-11E1-A73B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185876>

Makes sense and is a nice fix for a regression on 'master'. Thanks.
