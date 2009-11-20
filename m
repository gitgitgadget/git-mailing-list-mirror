From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] let core.excludesfile default to ~/.gitignore.
Date: Fri, 20 Nov 2009 14:49:00 -0800
Message-ID: <7v6394vmlf.fsf@alter.siamese.dyndns.org>
References: <1258723430-31684-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Nov 20 23:49:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBcI3-0008La-0N
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 23:49:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754365AbZKTWtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 17:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754184AbZKTWtF
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 17:49:05 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41805 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754151AbZKTWtD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 17:49:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 71E379EDB3;
	Fri, 20 Nov 2009 17:49:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F8+9NO8WWglwloHkAvc6d0bQ/oU=; b=kdtxnD
	l3zksqIF4FxwA8mWDHKWJzbDnPitzTTwSmY3wWhRI9g8bx8q27FHchJK9y65VLnG
	zbVKnVqDxBGf9NkvUIsOT35mjeoRpH/MnQF7YyxY2bMtgznCIlJJgqdNYJeZoXbB
	clyeOh16FgjE0FjdHnz3B6vJkbKz4ZPQP0aWc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OkXUMVY09Yz2g+YMChxoj56CcLldIjYS
	S9aru6CrXNEbkMG9mKiNy1rcyT9JCb6rDruD+O+c4gZQ8lPc1ZuIP10TijwuonQm
	C4LSbJdKVZo+07TKSfeuFnUlLaISalS5NjYBMzOq5nO/STEGHG/ebZRX/bH2g5Ai
	2XNCQx0ITNY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 502949EDAF;
	Fri, 20 Nov 2009 17:49:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 380A89EDAD; Fri, 20 Nov 2009
 17:49:01 -0500 (EST)
In-Reply-To: <1258723430-31684-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Fri\, 20 Nov 2009 14\:23\:50 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E7BE285E-D626-11DE-B5E2-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133384>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> It seems this is the value most users set, so let's make it the default.

Maybe in 1.7.0, but I think using .gitignore will conflict with people who
put the entire $HOME under git (I think they are misguided, but that is
besides the point), so it should use some different name.
