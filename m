From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add tests for the diff.ignoreSubmodules config option
Date: Mon, 09 Aug 2010 09:57:08 -0700
Message-ID: <7v1va77mhn.fsf@alter.siamese.dyndns.org>
References: <4C4DD33F.4020104@web.de>
 <alpine.DEB.1.00.1008051025451.2983@bonsai2>
 <7vlj8ldmyj.fsf@alter.siamese.dyndns.org> <4C5B0C13.6020809@web.de>
 <4C5B48D3.6020402@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 09 18:57:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiVfY-0000Y3-ON
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 18:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076Ab0HIQ5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 12:57:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58749 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932070Ab0HIQ5m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 12:57:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C0EA1BC1;
	Mon,  9 Aug 2010 12:57:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=PJoXbwtcPGSDiZ/Yj3fLHyqpcQM=; b=YH+9P9QuPY/F3hSdEX9wncY
	GTCYrNTCWnIApfQvDSPQzRgfz3ruXWLdFVyGVOYc3AOD6riopR+1jSdbCMgMzeHA
	eyB9pzS0eE3QZY7rhbscNRppmf1hOCqgSjkCN5Gd4SlHxvayuuQZZenGCCYQydm+
	BpYSdJ/LI43FKUdof/2c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=YEmQOneORBxB+KfEuBXIZQWLHeCHEVJWTknqSkZJl87XixDnh
	Y4yUFAEt6alL1pGf0lZIxQpH7/eArulfApjc42vvD9+w+PEebhglwTDltvrBLo3V
	NY6s+T1uI2rB3cYOvaSm4/IeHTrzCFoYvan4ri5Arx06c/vdLAzPzBqqx4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2199F1BBF;
	Mon,  9 Aug 2010 12:57:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.126]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 556011BB8; Mon,  9 Aug
 2010 12:57:13 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 31108A00-A3D7-11DF-87FE-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152987>

Thanks, both.  Will queue.
