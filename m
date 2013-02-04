From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Handle path completion and colon for tcsh script
Date: Sun, 03 Feb 2013 19:02:45 -0800
Message-ID: <7vehgw7pd6.fsf@alter.siamese.dyndns.org>
References: <E59706EF8DB1D147B15BECA3322E4BDC09AA38@eusaamb103.ericsson.se>
 <7vboc2bhpj.fsf@alter.siamese.dyndns.org> <510EC1A4.4000207@gmail.com>
 <7vhalt86wj.fsf@alter.siamese.dyndns.org>
 <E59706EF8DB1D147B15BECA3322E4BDC09B5A4@eusaamb103.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Manlio Perillo <manlio.perillo@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Marc Khouzam <marc.khouzam@ericsson.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 04:03:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2CKu-00009r-Qv
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 04:03:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872Ab3BDDCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 22:02:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62322 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753757Ab3BDDCt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 22:02:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 93FD6B0F6;
	Sun,  3 Feb 2013 22:02:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r+O3yxg3tbKr09S2BCGKCFhXRgo=; b=M9Psas
	hgpvZbOiozuGSxmflcYccAiw1ttuO+81ca0MEfrjSrKwV/emc75S8MM5F+vKDDb9
	qcONeY6kMTBk8TBUXqqVdHSNBP8xAOL3vsusUJn1D9Z51J+6od//3mQ8XrJHzzYV
	X4WZhefKDI9mvQCNSY0JpjaVQJWPGGcll5II8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uEAAgJEDTa7X+6M43GsLJAqshxMJV1V2
	MhalRCQksDfz4fawEdE/OTo1TQmXxYikl903pj0V27M7RdpQ44d/DqPf9dqJ2g2F
	HVxWAepDbEl3L4BJHyufqrEuuBdGJrpE67t/eLxq+CT5CV1tqC44oz9cC3vmqRmb
	h2bnMX4+7Tw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89817B0F5;
	Sun,  3 Feb 2013 22:02:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 090C3B0F3; Sun,  3 Feb 2013
 22:02:47 -0500 (EST)
In-Reply-To: <E59706EF8DB1D147B15BECA3322E4BDC09B5A4@eusaamb103.ericsson.se>
 (Marc Khouzam's message of "Mon, 4 Feb 2013 02:50:58 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5AF10D1E-6E77-11E2-BB7B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215350>

Thanks for a detailed explanation.  The two examples illustrating
different interpretation of the same word were really good.

Will replace and requeue.
