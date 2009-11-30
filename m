From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/6] Run test suite without dashed commands in PATH
Date: Sun, 29 Nov 2009 23:16:53 -0800
Message-ID: <7vzl64xz16.fsf@alter.siamese.dyndns.org>
References: <1259561971-25730-1-git-send-email-mmogilvi_git@miniinfo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
X-From: git-owner@vger.kernel.org Mon Nov 30 08:17:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF0VS-0006ir-SQ
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 08:17:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753737AbZK3HQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 02:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753713AbZK3HQ6
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 02:16:58 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35337 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753699AbZK3HQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 02:16:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A57311302;
	Mon, 30 Nov 2009 02:17:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ujlTmtPSA8sfv7dKcZAggG2rEY0=; b=d2jSJB
	uWLp6CnUTjpoxhVwME686a7JsAiVT513tO/1Bez+CsLdcnZR3ABqEGIyetckvt45
	wgwNDK7+Q7K6i6o1P/yYx7vgPXfA5eazdlC/Xw7drpIQtZ9fLuXdR5+xetG9ztnp
	Ivw/f8Y28w+WVE6DWNLzqfKRtqv/La8H9xyfI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NBxcM+L5kXfm7Vr80UMl/TnqJkfFPHTO
	57ABcaPlKThP2PhzxxOf/zWfUVahic+XC66nCTWHT+/oYrfmDF64pdsDkwRVyYDG
	1dX5/u7zCjjY5vLE9gvbQ5LilEqHYKXLdHyDsxpYqQqr/UN+/t3aLYSK06nriZip
	qrkkDWp00qg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3867A1301;
	Mon, 30 Nov 2009 02:16:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3101012FE; Mon, 30 Nov
 2009 02:16:55 -0500 (EST)
In-Reply-To: <1259561971-25730-1-git-send-email-mmogilvi_git@miniinfo.net>
 (Matthew Ogilvie's message of "Sun\, 29 Nov 2009 23\:19\:25 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5954D9C6-DD80-11DE-A2D1-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134063>

I added t9150 to your second patch and pushed the result out on 'pu'.
