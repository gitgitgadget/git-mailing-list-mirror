From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] Add threaded versions of functions in symlinks.c.
Date: Wed, 07 Mar 2012 15:39:12 -0800
Message-ID: <7v62egkmlb.fsf@alter.siamese.dyndns.org>
References: <cover.1331158240.git.jaredhance@gmail.com>
 <5acf65ff331b28196c9781c39d1d00c3f8a733a4.1331158240.git.jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 00:39:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5QRz-0007jZ-Ie
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 00:39:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758794Ab2CGXjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 18:39:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64842 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757034Ab2CGXjO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 18:39:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 763056739;
	Wed,  7 Mar 2012 18:39:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=S4fd8pC4IDIYGEuAx+iY1XUZmB0=; b=qF+IpPXEP6QP9WTvJCBa
	R61ONJGJzMlfopciPFzkJAi32p7M+FIkS/ycMHLgQP1pMuiuHI6CqxiVEMq3weno
	4wvNtyiJyhplOg95dAZDvTH5ipXdxhqeZ9+MlRSlpr6FEbSzaVqm9aouObQrpGqj
	AOwHYPjaw9gtLF6iGX4v2Hw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=U9YiVmCo4jFXuLUqblATdaR7g+yFq66NaLesr47pldvVZP
	wC5Ukd3m53WzTL1+30XZ6wlia7o52VRRzlgkcVKhCbEpgZMxQ1X+gKww/KvkkeHs
	LcPJympWrNTOiXMCENS6EyqkfF76vAYFW+MfLkaTwXClcHg6D9axPr65HA4M8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E61D6731;
	Wed,  7 Mar 2012 18:39:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3EF8672D; Wed,  7 Mar 2012
 18:39:13 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BF3672FC-68AE-11E1-8056-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192504>

This is identical to what is listed as "Cooking already in 'next'"
in the latest issue of "What's cooking", and I've already merged it
to 'master' in preparation for 1.7.10-rc0.

Thanks.
