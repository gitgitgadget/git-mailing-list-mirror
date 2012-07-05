From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t3404: make test 57 work with dash and others
Date: Thu, 05 Jul 2012 15:29:17 -0700
Message-ID: <7v8vexrgea.fsf@alter.siamese.dyndns.org>
References: <40eccb55835575b4a73131d1dced857ba7d4ecc3.1341401445.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Chris Webb <chris@arachsys.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jul 06 00:29:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmuY9-0005ka-Hc
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 00:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271Ab2GEW3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 18:29:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61925 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932197Ab2GEW3T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 18:29:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FB749042;
	Thu,  5 Jul 2012 18:29:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+eWgJyyk3PEXsDGMvgMtgcUUCAk=; b=Tt9Flw
	K7PXA5R95QOzNP6CYdaYRqHtF1tm0nl8x1EnpMUzC0x7kISBpudPfY3AOvs90rMw
	m56ZnB21hi2ZbZXZg2Edoil/OqOnWRhyfdaJ/jdsIdbmQrxFe5v+C+2idQGvq1DV
	DrhhJin9wQj7QQ64du1TDgyweL4KBMHwWjVII=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nP674l1fn1uMY3nvKFTiRDWZV1Wa9HhL
	zxO8PI7B7rUyRgU/6Txv4KNIp+pANSlj1lvLGpa6s5eEwH/sFx1fNQbJQ4v1Ie9W
	Dkr9PZbbIAv4NG7OCl5BijsCECa4TqyvKaiZP5nfs/bGUiguYhbHz0xfGR4n9zEI
	88oKRieKb78=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 874429041;
	Thu,  5 Jul 2012 18:29:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E5AF903F; Thu,  5 Jul 2012
 18:29:19 -0400 (EDT)
In-Reply-To: <40eccb55835575b4a73131d1dced857ba7d4ecc3.1341401445.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Wed, 4 Jul 2012 13:32:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DC7B4694-C6F0-11E1-849B-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201072>

Thanks!
