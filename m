From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/11] Simplify "How to make a commit"
Date: Tue, 27 Aug 2013 12:08:33 -0700
Message-ID: <xmqqfvtvc5ou.fsf@gitster.dls.corp.google.com>
References: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
	<878772375.34519.1377626477170.JavaMail.ngmail@webmail19.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, martinvonz@gmail.com, jrnieder@gmail.com,
	wking@tremily.us, philipoakley@iee.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Tue Aug 27 21:08:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEOd6-00010g-Qq
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 21:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752994Ab3H0TIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 15:08:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44453 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752602Ab3H0TIg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 15:08:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E87903CB08;
	Tue, 27 Aug 2013 19:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YZ4OR9fVtklwD5SGVNdlzJobp+4=; b=dp7/+4
	2mIFhz5i/ZqKiE2rih8CMcaD/vbSQDsHE+ora5nlApFOVNByWWvmk/HqsrUCE/ny
	D8it7tDW7lfRrk5NUxDrHXTjE55M+EBpYjWR+OSR7yKmvfQp5VEEQ6175NGJpRIZ
	Q4R9T5LDlUMBCwjuxUFc54ugLXkZJ22jzevJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kzZrcAtpUAE8ikV3/sZ9GThk0ZBapgft
	v/yMNHdBo3XMC9jJDipU4CC6os+ARkG4VGYxyOcR3+5rNFfQ4EfgT+UpqH2d2PCq
	8VlqsX1+0iJyMt1yEavcYFKLzTcK9UnmHgfqAGYL6XzC/F4kVsIxTZVZ0xZR5s4l
	1ErZY3ePqwM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D030D3CB07;
	Tue, 27 Aug 2013 19:08:35 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 146AB3CB06;
	Tue, 27 Aug 2013 19:08:35 +0000 (UTC)
In-Reply-To: <878772375.34519.1377626477170.JavaMail.ngmail@webmail19.arcor-online.net>
	(Thomas Ackermann's message of "Tue, 27 Aug 2013 20:01:17 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1264E298-0F4C-11E3-9910-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233138>

Sounds good.
