From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] gitweb: Improve search code
Date: Wed, 22 Jun 2011 11:55:23 -0700
Message-ID: <7vwrgd66hw.fsf@alter.siamese.dyndns.org>
References: <1308756535-29701-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John 'Warthog9' Hawley <warthog9@kernel.org>,
	admin@repo.or.cz
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 22 20:55:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZSaL-0003aM-JR
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 20:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758687Ab1FVSz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jun 2011 14:55:27 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52070 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758596Ab1FVSz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2011 14:55:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 04000557E;
	Wed, 22 Jun 2011 14:57:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o1NTCbsgWLrFieUzpt+YofMk8sI=; b=haSRFP
	q/zrrZjtieOJr5rdCMFHAHheIbDyJA8wvIFgKXTi8lLDVfMz9tXqij7QQ6E0PQa1
	vaYHIYF1W4WjcK8D3ReufMI9MLMNeesTLNpy4z+ck3HAQdYcCj1wu7iWjCr5Igjb
	WBdA++oBocg+KaVj7dx7qIT3oDGqylCKuN02M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KNWai5tN755O50R0xWeBo04ukhRfJwdF
	/e93DZAN7SAe8p3r+3/DZGcJDZK9T5RrXrKjdznPpUJyDieGGQBc/V39gt8wQd1i
	FoieSxxWmePcfqHdsOUShXT6Qnb5E3gRaRhX1yjup5XR1lji/YoDi1hWX25mQNL2
	e41Fjg94EEo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F1220557D;
	Wed, 22 Jun 2011 14:57:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3ED4E557C; Wed, 22 Jun 2011
 14:57:37 -0400 (EDT)
In-Reply-To: <1308756535-29701-1-git-send-email-jnareb@gmail.com> (Jakub
 Narebski's message of "Wed, 22 Jun 2011 17:28:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7F04F8A8-9D01-11E0-957D-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176250>

Looks good. Will queue.
