From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] status: only touch path we may need to check
Date: Fri, 15 Jan 2010 20:41:14 -0800
Message-ID: <7v4ommirv9.fsf@alter.siamese.dyndns.org>
References: <1263481341-28401-1-git-send-email-pclouds@gmail.com>
 <1263481341-28401-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 05:41:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NW0TX-0003xx-8v
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 05:41:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757349Ab0APElW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 23:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756036Ab0APElW
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 23:41:22 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64954 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973Ab0APElV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 23:41:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 61F2C91809;
	Fri, 15 Jan 2010 23:41:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/xPhZqSKDzqEpA3pYarJSw9KxtY=; b=ZCcnr1
	1HdPDYaD37BVDQdzw99fYgf76eRwXgBi42BALUJ1mHWLiolF54ifmSLjfZPhZmy7
	qOl/hE6y4dDzTjmnt3dDglRDmIaULKYicI1IiJjtvYtdAyAaoYMMNkjI6B17o7Hw
	kdCG03KPSdW7ZyNVogfUhvI3WFPq8kTV6tVd4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IbyTztk0us8yhpYDDvAJ9ew9l7pYfmFA
	zRxRWQ5kdD2iNDti/nWFBTNUxNYzKWOjIqIknK6LDkRl5buYBbfdenTOJ4Ef18b3
	tf3skg4kHEKljweY4aqfndm5qzJTtajOBW3v5G5tSv0saNFM6i4/EO7D1giBtp+E
	nhUhbGNVCUE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CB4491808;
	Fri, 15 Jan 2010 23:41:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9688B91807; Fri, 15 Jan
 2010 23:41:15 -0500 (EST)
In-Reply-To: <1263481341-28401-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Thu\, 14 Jan
 2010 22\:02\:21 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 63AD6D36-0259-11DF-9AEA-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137200>

Will queue this one (but not the "rm" one, yet).  Thanks.
