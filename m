From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/2] Introduce CHERRY_HEAD
Date: Tue, 15 Feb 2011 14:13:43 -0800
Message-ID: <7vfwrplze0.fsf@alter.siamese.dyndns.org>
References: <1297805034-3512-1-git-send-email-jaysoffian@gmail.com>
 <1297805034-3512-2-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 23:13:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpT9f-0006TU-U0
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 23:13:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756173Ab1BOWNv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 17:13:51 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46281 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755865Ab1BOWNu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 17:13:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B51534929;
	Tue, 15 Feb 2011 17:14:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VGoDOAEkjEfZHHdRrg8i1H2BNY4=; b=FXgaiI
	4ZJijE9xhrNvKEEY/gdb+e46dr17I5k4sjh4dK6FAzqEzZijO1RcOvFY5Im3U6Or
	BZN3s+x80YanXh0OekEzCB01ccwQqpyR35MGsrTweVtcP+4Do/6rx/4fMo0pDm/o
	RAYzmxpRXsAu2qwXWxbE5b2Lj72tqqVQpe9Bo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HDOGK4xlfqIYKfR66MUh1EZTNwzfa91a
	2U8iqKM1hlZbsnzub5JI/7c2se/ZIvpGpYXqJg3Ygos7ApNb8k491uir3uF87qnV
	xBPcE+eXX5vH+yjfiPKPK39mYx9jZYjGxForN1viPWgX0Ajz+ZnYVfv/lUq8j/nG
	9f7XKeFiMoo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 89AF64926;
	Tue, 15 Feb 2011 17:14:53 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id ABF1F4924; Tue, 15 Feb 2011
 17:14:50 -0500 (EST)
In-Reply-To: <1297805034-3512-2-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Tue\, 15 Feb 2011 16\:23\:53 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 038435D6-3951-11E0-8652-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166885>

Introducing a new file that ends with _HEAD is fine, but shouldn't this be
CHERRY_PICK_HEAD instead?
