From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] parse-options: report uncorrupted multi-byte options
Date: Mon, 11 Feb 2013 15:51:42 -0800
Message-ID: <7vliaujto1.fsf@alter.siamese.dyndns.org>
References: <1360624428-4728-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, matthieu.moy@grenoble-inp.fr,
	tboegi@web.de
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 00:52:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U53AP-0006Bz-Qh
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 00:52:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760086Ab3BKXvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 18:51:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59253 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758467Ab3BKXvq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 18:51:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EC73C966;
	Mon, 11 Feb 2013 18:51:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=Vr9Yq/
	CLX65bobRsHmJx/z2KyXxZNqtRaCOuXwptdd4ITH2IWxFMQiYGxYf/8MiNDVZ6W6
	iIrrE5QSNiEj+b60UHjNCyR22AGh9s5WqAPrIUB2hV9+I9twnMguU8r4THP3Jgq3
	2klxHGB21/fb9mIVM9TDqpUb+11l9Suyqjmdg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JCvvLhbQkTf/RkaejkM2raWUiXoY7DK9
	rzzSYRRJYQQQHQdFZfGNl0OqKMlTdXLnx5zvDD9/W7cxZBjzPCHlKuKDBX74JquQ
	45AleKP4akaC9D9HQjzL4pxCUhxJTw+LSrIZIsly9oyvWsc8nQdm0mhjir6pNyoB
	rcZ0ScsCIH8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52F6EC965;
	Mon, 11 Feb 2013 18:51:45 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA7ACC961; Mon, 11 Feb 2013
 18:51:44 -0500 (EST)
In-Reply-To: <1360624428-4728-1-git-send-email-kusmabite@gmail.com> (Erik
 Faye-Lund's message of "Tue, 12 Feb 2013 00:13:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FDA48534-74A5-11E2-95EA-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216105>

Thanks.
