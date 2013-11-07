From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] gitignore.txt: clarify recursive nature of excluded directories
Date: Thu, 07 Nov 2013 14:43:22 -0800
Message-ID: <xmqqbo1vq1dh.fsf@gitster.dls.corp.google.com>
References: <527BC00D.8000501@gmail.com> <527BC068.3040303@gmail.com>
	<xmqqa9hg59av.fsf@gitster.dls.corp.google.com>
	<xmqq61s457gd.fsf@gitster.dls.corp.google.com>
	<20131107195546.GA13456@sigill.intra.peff.net>
	<527BF7A4.6070203@gmail.com>
	<20131107205732.GA16564@sigill.intra.peff.net>
	<527C07DD.9090809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 23:43:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeYIl-0003cX-2p
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 23:43:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753584Ab3KGWnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 17:43:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35756 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752690Ab3KGWna (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 17:43:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77E735150B;
	Thu,  7 Nov 2013 17:43:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z39PFn5dW5Nhrrj2YjeNAi8IYAE=; b=ibWusy
	TZGLraJEZOvle+UxjDuzyqsbIwdvatYnm6ltzSXM+ibZ6S0zlbS3KSGr58IZCKFk
	XoKWy7A8VH39dXXDpZuoIStBkf5wYm8kBgW1/Lc+0F/2ECnU0amV/EipwJ1khP5D
	F1+L0CN+FsTQ46VOshOm0dKF3JQMhTpE6hYzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wh6wKQTPREYlFUvzJfPTE+53zMldh0Jo
	RjvRzBTovxoDktpQD8h4ZJE9VVRqiEq9ff0FrHP9IJxmdk8dbhCbGvCcOdKgpa/D
	QU7ylk8KuzrM7a0mDbF/fRJTNXKDv9ZmyFhQxw+j4BMDVrbEvmOafyF1BnXcdmhO
	9rri28Qor5c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6468F5150A;
	Thu,  7 Nov 2013 17:43:29 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50D5151509;
	Thu,  7 Nov 2013 17:43:24 -0500 (EST)
In-Reply-To: <527C07DD.9090809@gmail.com> (Karsten Blees's message of "Thu, 07
	Nov 2013 22:36:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 02ACEF68-47FE-11E3-9B67-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237443>

Thanks; will queue.
