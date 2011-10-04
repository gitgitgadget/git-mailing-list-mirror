From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] request-pull: List the hash that results from merging
 onto baserev
Date: Mon, 03 Oct 2011 20:22:19 -0700
Message-ID: <7vzkhhcufo.fsf@alter.siamese.dyndns.org>
References: <m28vp1msth.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
X-From: git-owner@vger.kernel.org Tue Oct 04 05:22:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAvaN-0000Jr-SC
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 05:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753675Ab1JDDWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 23:22:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46872 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753480Ab1JDDWW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 23:22:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D65505A6B;
	Mon,  3 Oct 2011 23:22:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GeRpMIK3yIA52qeVPvvh4rkSzuA=; b=wKtgME
	U6Qguf1UwMA9D5eZmC+g0Fh4SH935TBnG/6GS4smYdQQSFt0UOz9y7+qJcy6K1Kb
	VIkde4Poa5Wqb4L//VkmLiJmpiACtnSdoKwnFD0nYkYVeu4QBRg2LCGrmiuHV1KX
	vfXpuLKZ0D6pCydxOnRJlqCdxZAerhGZtbhns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hp6gLNl5buk0veZTEF835ZrSz/T15Jnh
	wnkO0i47UHdUcoQPSFTgbpvjfrHX4vlwdD218d2T6PbXVDq34KVqIwbS1OZDnJLJ
	aLtiKCmhONVui59UCii4hJq1zC+AaPLCV0VI73xpUXgreHdmyxOpi1sa0AB+LrqP
	VfIykOeqMLQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE4D95A6A;
	Mon,  3 Oct 2011 23:22:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4BA6A5A69; Mon,  3 Oct 2011
 23:22:21 -0400 (EDT)
In-Reply-To: <m28vp1msth.fsf@bob.laptop.org> (Chris Ball's message of "Mon,
 03 Oct 2011 21:47:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1244FFBE-EE38-11E0-875D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182724>

Isn't the series leading to 7eb32b8 (request-pull: use the branch
description, 2011-09-20) insufficient?
