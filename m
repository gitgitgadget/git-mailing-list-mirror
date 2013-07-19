From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] http-push.c, add_send_request: Do not initialize transfer_request.
Date: Fri, 19 Jul 2013 11:30:25 -0700
Message-ID: <7va9liwgfy.fsf@alter.siamese.dyndns.org>
References: <1374183327-14939-1-git-send-email-stefanbeller@googlemail.com>
	<1374183327-14939-2-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 20:30:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0FRs-0001mM-8u
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 20:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761068Ab3GSSac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 14:30:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44384 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761007Ab3GSSab (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 14:30:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EBAC32961;
	Fri, 19 Jul 2013 18:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GynaLVvVQbdz3PY/g1+/OQhQKZQ=; b=T6rO91
	6tEyp04I6nFDoUmMFDKLKgPKwm1dH59S3ioBEb8CDzI0WI3Z4QwXB80+80g58582
	Lx126HJaVoCf8xbasa+j5MiSslkxAJ+Z+OtL5Hn+IXa68DYslIyFociDa+zdkYaJ
	3ek87WImkC/IAGPM0jW/tCawzGzhaR3R6oBv4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HZsxfltI74+/G6/lN0IVSF2T8EwBr+wE
	xluUvkU5IiTpd4WG1qefwljpOQgjXC9pnAD9tohMQYH6X/I62SRUaDAPD3zFOh1n
	evpFYgM6RVim/fro0200A0t2v17jpcNRoWK4ZJ6yUGlM8k3GyYwRnia+hFGPhDG+
	7+SbvchSSlE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C3CD32960;
	Fri, 19 Jul 2013 18:30:31 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B94813295E;
	Fri, 19 Jul 2013 18:30:27 +0000 (UTC)
In-Reply-To: <1374183327-14939-2-git-send-email-stefanbeller@googlemail.com>
	(Stefan Beller's message of "Thu, 18 Jul 2013 23:35:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 48E1C17A-F0A1-11E2-A48B-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230838>

Patch 2 and 3 look fairly straight-forward.  Will queue them
directly on 'maint'.

Thanks.
