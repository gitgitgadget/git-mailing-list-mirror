From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.7.6.2
Date: Wed, 07 Sep 2011 11:25:27 -0700
Message-ID: <7vpqjc2ors.fsf@alter.siamese.dyndns.org>
References: <7vvct55j4h.fsf@alter.siamese.dyndns.org>
 <CAGdFq_gF8Uz_JTEUfb46kVii=Y0CwzCpOp5H81+HT8y=1PPUTQ@mail.gmail.com>
 <7vsjo84mx3.fsf@alter.siamese.dyndns.org>
 <CAGdFq_hAm4Avoi1VoFMHcnSE4oDmhEPvqJiodrLUJ5042pKzGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 07 20:25:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1MoZ-0007nU-O5
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 20:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756332Ab1IGSZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 14:25:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57350 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756277Ab1IGSZa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 14:25:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C67C64723;
	Wed,  7 Sep 2011 14:25:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7cOhfP68kI829UayQZdFI3JntLE=; b=tVg/x3
	key3M3jpseFF+y+ZhMKPRmwYoWgt4yUlq7V4IcLJ+jTfzcU1EB1Bxl55ZJnC1yUU
	tB//8YnJq4/tDv3kaHpdtPHDr13xomiEDCxa3Ahvr2Ft58a5WMYvKTQcnFmcBGNt
	90dYP7vCc7yt3pgY+5iM7dAgM34BdlXHlKq4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yGDye7V+YRux8emVsqorhELnnjl0ifJu
	SGsjf0wX9AueN8l/2pTLu9CG4R3vF31Oy/sxW92vXcHnX39aTkSw8VZt97HzB84F
	8x+ZdUHc5Gyq1ulhsduJJiEmprgrGl5dHNFc/+/v/YaoQQUWXt0ECXTZERAKObmr
	nJuNUsLnPOo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BCA5B4722;
	Wed,  7 Sep 2011 14:25:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3AEC34720; Wed,  7 Sep 2011
 14:25:29 -0400 (EDT)
In-Reply-To: <CAGdFq_hAm4Avoi1VoFMHcnSE4oDmhEPvqJiodrLUJ5042pKzGA@mail.gmail.com> (Sverre
 Rabbelier's message of "Wed, 7 Sep 2011 13:24:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C3A3F1BC-D97E-11E0-9087-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180893>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> How would you later re-merge the series when the
> problems it has are fixed though?

Simple. I won't re-merge nor allow a fix-up series to be queued on top of
the failed topic.
