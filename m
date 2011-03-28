From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] warn use of "git diff A..B"
Date: Mon, 28 Mar 2011 09:53:54 -0700
Message-ID: <7vei5r190d.fsf@alter.siamese.dyndns.org>
References: <7voc51cydw.fsf@alter.siamese.dyndns.org>
 <7vei5xcxzm.fsf@alter.siamese.dyndns.org>
 <AANLkTikQB_2bapZXOyANrO1fsKGs4r6HP1TOuisZXfnr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 18:54:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Fhk-0000Ny-EF
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 18:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760Ab1C1QyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 12:54:05 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45748 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119Ab1C1QyD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 12:54:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0C0B342D4;
	Mon, 28 Mar 2011 12:55:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XwDm6rOJgb6XioURXt8LjOlDRhc=; b=ITlo1E
	GuwiWGxh7b29Z/D1qqOcTjO/7kXC9FB+EeiaeMckcsiOzJUJas3PinVxQeomK5AE
	7xckAd5fsUeKXJ50dQrNZCqutqxBlwEO2gZVA0QzKnRqMpZxvmM0nw7qveCOyAF0
	GrLHtxI/llK4UAojiZgH+mHu8lgaG8vVP7nac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g0ZYJIXwHAMQJpPOwV9RAzbPVkM9AXZ4
	ckFFv/e4IwLqT9GVgKTuaOgKzxDdcSm9A5nl7GM4EtNwHvx2/fEhHAbt+kCZh/yn
	ZJGNMxF9c/ptwi31F32vATw+wgfyAa1o9+MavBqKk38wpdIVMCX4ow7BWeC3NKGQ
	nN1ILG/6YIc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DDC3442D2;
	Mon, 28 Mar 2011 12:55:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C693F42CA; Mon, 28 Mar 2011
 12:55:42 -0400 (EDT)
In-Reply-To: <AANLkTikQB_2bapZXOyANrO1fsKGs4r6HP1TOuisZXfnr@mail.gmail.com>
 (Alex Riesen's message of "Sun, 27 Mar 2011 22:03:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3A209D52-595C-11E0-A916-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170157>

Alex Riesen <raa.lkml@gmail.com> writes:

> I like the dot-dot notation a lot.

Thanks to be the third volunteer.  I don't need any more volunteers ;-)
