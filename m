From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] describe: Add --first-parent option
Date: Mon, 20 May 2013 15:47:48 -0700
Message-ID: <7v61ydtgiz.fsf@alter.siamese.dyndns.org>
References: <1368824178-15596-1-git-send-email-mac@mcrowe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Crowe <mac@mcrowe.com>
X-From: git-owner@vger.kernel.org Tue May 21 00:47:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeYrz-0002Nw-KE
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 00:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757370Ab3ETWrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 18:47:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33143 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756914Ab3ETWru (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 18:47:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FAB0202A9;
	Mon, 20 May 2013 22:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=d8SN2ftBLo8S+nEqUgWPPSiFfoY=; b=xkKdGIiS8Skh2r2Nwtq6
	fyqxtowM5HnqCdnsTtM6Kf+Swmlp1avCti7DowSFsgUs+tn3jNK1unVSiCIZYzZP
	3SRKHj+PUvswF4NAdMGb8KGejIkuC4R4MGm4BuaNVnXI24diM9uaUSah6uyGEgk9
	kKYo27ecdCq9XaqBbiwPjUI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=OQVHM0jCpHl+oAS4ivXXfRTpyvPa1RRg7m3AJuBML6IyVB
	xkdZKFYg0isVkCRX1e1D+18aFO7rEnL2beTU8G7z1slmq2VFpT8di+0llB5IiEMg
	S6ysmtTvf+Aon/S2wsXazATydV0svCvkX3Y8wVD/5aky8UIs4VKDizugIAlDQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12F77202A8;
	Mon, 20 May 2013 22:47:50 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8DB29202A5;
	Mon, 20 May 2013 22:47:49 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4C238246-C19F-11E2-8F1F-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224993>

Thanks, will queue.
