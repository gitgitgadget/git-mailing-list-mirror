From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Fix "git difftool --tool-help"
Date: Thu, 24 Jan 2013 13:07:57 -0800
Message-ID: <7vehha9tn6.fsf@alter.siamese.dyndns.org>
References: <cover.1359057056.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Jan 24 22:08:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyU22-0003WL-72
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 22:08:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756152Ab3AXVIB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 16:08:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54363 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755880Ab3AXVH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 16:07:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49D88B441;
	Thu, 24 Jan 2013 16:07:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lm39C4pjLNllkmMK5fotmBhJkVo=; b=cEUuNP
	vPpeAYx7zrhwQKyiuG8IlN5o331VN1ddV7mxUwttaXHr5Hc7BicqKS+WOt5lqrUD
	/u1sTMSd6zha5gzuQ62usE3g6dL1g9/rKcGt3KxLEZ6yZXfMdgICg5iaoq4zagqR
	V9PvFl6vimnzPxHDwelRoXHiMMIy2iKdytYRo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RGRL6chS3wBtYKcJA1rt+0QyGD3KGoGu
	/EspM4K1wWMuhEaZI+ZGZZNv/MrBhxZvEDrTOwRsYe4HatQZ5b7/RwbfmpEbMEiK
	zUE6oVkgu3jBLm7vAGjwuN5Eck3cyBTGnDu/gx9zmjaMR8XqmMGol7+XprwLKZhC
	U84dfnZWfB0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F74AB43D;
	Thu, 24 Jan 2013 16:07:59 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B57FAB43C; Thu, 24 Jan 2013
 16:07:58 -0500 (EST)
In-Reply-To: <cover.1359057056.git.john@keeping.me.uk> (John Keeping's
 message of "Thu, 24 Jan 2013 19:55:12 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 21672E44-666A-11E2-9D89-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214457>

Nice code reduction ;-)

Thanks, will queue.
