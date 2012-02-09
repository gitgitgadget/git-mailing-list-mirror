From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Explicitly set X to avoid potential build breakage
Date: Thu, 09 Feb 2012 14:32:06 -0800
Message-ID: <7vd39nvdsp.fsf@alter.siamese.dyndns.org>
References: <1974397.vopy2n9Vpb@telegraph>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Palimaka <kensington@astralcloak.net>
X-From: git-owner@vger.kernel.org Thu Feb 09 23:32:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvcXH-0006uM-Nc
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 23:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758304Ab2BIWcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 17:32:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54495 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758269Ab2BIWcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 17:32:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BDEAB7AD6;
	Thu,  9 Feb 2012 17:32:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=nKjEQs
	fgztfRPZ0q13/OY49oBfXLkuOM/3u0L7x1MOh6iw/pcxbx8jOUKdG7e4oyS6gmQR
	QRK2pybnYKQmOxjTe4vx12Nr/h6tUzLDT+b9neQU5sWdA45jxAZ5bT5P8IkzSfAo
	MVoz4afwrvad9Q7ipLW5Sv0vn+G/iQLcTgcbE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AQa5XARPbS9b99ZJ+LU1trdFMtfpJNgN
	vOFOISsZAxjSFps/s4vpXLrCysnsioKeTTNXWznV+tfCG6qAmW4ercWW2K/c8hgR
	DQIHlTqfFgYKNP90SfiiBP07NudCemhrK7E/iWBznXbQGOPuoU9nWV90DTTZwts4
	gLv0+s9nn2M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3A947AD5;
	Thu,  9 Feb 2012 17:32:08 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 217F77AD4; Thu,  9 Feb 2012
 17:32:08 -0500 (EST)
In-Reply-To: <1974397.vopy2n9Vpb@telegraph> (Michael's message of "Wed, 08
 Feb 2012 21:59:04 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E67F7A9E-536D-11E1-B62F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190334>

Thanks.
