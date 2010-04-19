From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix checkout of large files to network shares under
 Windows XP
Date: Mon, 19 Apr 2010 13:41:54 -0700
Message-ID: <7vaaszqinh.fsf@alter.siamese.dyndns.org>
References: <4BCC5083.30801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 19 22:42:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3xnI-0005oy-GU
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 22:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129Ab0DSUmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 16:42:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60399 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030Ab0DSUmD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 16:42:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 229B2ACE13;
	Mon, 19 Apr 2010 16:42:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/ULZ9E7KYvICmSCLelfV1Ra2hd8=; b=Eewvhh
	P8IhSo7NceuiIDQlrmSMvDHLg/PP0amY6F7I6lpsbcwfOhZro01crQ9dYjUjD2pj
	dIbXDroru2oxRs20bDbWVWkCXpEQJq/tOl8Fxe4juJwzo8Lo/8bNoftavrRyE4Mk
	1NOZRPaszh7GxwyvUNQXGa52jx4IMAhHMXYIs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gDL/uxB9xnckFXfrUVniOykdecelW61V
	At7Tf9CSw1pqDQtLYAt/b81PI15OMw9aib97daFu8vSPSKo098tc4rzL0ijYD5Cx
	tnReHgugCQNFv5ks/HwXZ7Vk0UMoPqDHJuVVdRE2+ZScLXj2rCGqp2QWIw43c+db
	kXwYTtyQzMY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E37BAACE11;
	Mon, 19 Apr 2010 16:41:59 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D434ACE10; Mon, 19 Apr
 2010 16:41:56 -0400 (EDT)
In-Reply-To: <4BCC5083.30801@gmail.com> (Sebastian Schuberth's message of
 "Mon\, 19 Apr 2010 14\:45\:55 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 00A074EC-4BF4-11DF-88F8-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145326>

Dscho, I saw that you are planning to queue this to your tree; would it
make your job easier if I queue this myself now, or if I refrain from
queueing this myself and instead wait for you to tell me to pull or apply?

I can go either way.
