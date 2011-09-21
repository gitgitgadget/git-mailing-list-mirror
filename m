From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] sparse checkout: show error messages when worktree
 shaping fails
Date: Wed, 21 Sep 2011 13:50:59 -0700
Message-ID: <7vk4911ux8.fsf@alter.siamese.dyndns.org>
References: <1316602259-22576-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael@gold.pobox.com, J@gold.pobox.com,
	Gruber@gold.pobox.com, git@drmicha.warpmail.net,
	Joshua Jensen <jjensen@workspacewhiz.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 21 22:51:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6Tl6-0004wq-DR
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 22:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811Ab1IUUvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 16:51:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63657 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750713Ab1IUUvB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2011 16:51:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE9D56C15;
	Wed, 21 Sep 2011 16:51:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=grfCqty52Uml+PYNFcdO8hSCLHw=; b=QXAjMx
	8bCojfCDqwGrxFtJ2LIUPTw60ve8t/5KrkUDw9nT/cBRo8ku0ag6rYh3P+4gcdJI
	CtidAhsxWM97ilJUwN0HA6IXMLu66O6T1f4abv8nV+F9sC9CbgdoH8RUYcJqFmgO
	3t0inUbM+vQYrm7M3M6vAUbtjN6v/6AE7KXYc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=izFXFzoot9Cftjus3M2/ucOXiSR0Wmoq
	RIQnnggcdme5cPO9THDTai6wdzjnLWYdHS2vWLMmaSsl0o2apwmRnDcW7AFn+bZN
	pCYf52lfij8xWkRJZLWHtfN8Ah1pcTCc7JoiuR6nOGa1H85AI6H1PHQR5OqZLBft
	z+2LzF1g4l0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4F5C6C14;
	Wed, 21 Sep 2011 16:51:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 76DBA6C13; Wed, 21 Sep 2011
 16:51:00 -0400 (EDT)
In-Reply-To: <1316602259-22576-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 21 Sep
 2011 20:50:58 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 69AA051E-E493-11E0-94DE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181863>

Please add a test when you reroll this, hopefully with help from Joshua.

Thanks.
