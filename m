From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/13] add the basic data structure for line level
 history
Date: Mon, 05 Jul 2010 19:36:21 -0700
Message-ID: <7vbpal72vu.fsf@alter.siamese.dyndns.org>
References: <1277911526-12105-1-git-send-email-struggleyb.nku@gmail.com>
 <1277911526-12105-3-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, trast@student.ethz.ch
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 04:36:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVy1X-0006ob-Sj
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 04:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757119Ab0GFCgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 22:36:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46450 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754685Ab0GFCgc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 22:36:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F32DFC2B3D;
	Mon,  5 Jul 2010 22:36:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=rn2Jx/K6vV3QHz/wf2i7pFNB3DI=; b=u1ypEmIHCIzRhDl/b51SqtM
	0QgK1XZNOGAhVAM2EDmNGNzBNyZOcphc5Vj2qdLTQNoaDIGK5am3z/PbZNlXXYmF
	zlIoykJUEFQ1tlinpLv5D+7xFdtIng5tZsbndS0lCIKQ4eLa+Ju0i7uFIEgKlb7i
	khcLfRD0bVdsR5t4ADA4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=DpeDGZPK80K/olbJ6glxe4XEQ+tQrPkEDognegB3i2qLNIkgm
	0gfLu6uPWFs1t8aEu65ae/DntqKuQIGaJYjD1U7p0V0fy/sDsMw49B0UoW+vtZWu
	CPnbD7K/ZYbyJsB3PC/+ngeFTzq3XCC8xwXnHLQGrRp87Rvc3gJfuno3Gg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A1FBCC2B3A;
	Mon,  5 Jul 2010 22:36:27 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA36FC2B34; Mon,  5 Jul
 2010 22:36:22 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 46FD3962-88A7-11DF-9CB6-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150313>

This patch does not apply.   What did you base this version on top of?
