From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: remove CHERRY_PICK_HEAD when cherry-pick
 failed
Date: Mon, 02 Apr 2012 16:08:38 -0700
Message-ID: <7vr4w5d955.fsf@alter.siamese.dyndns.org>
References: <CAMP44s1EAwHjQ7S2ArLvhNg5qkR05DRJ70tQmP8sXYdOP=i_zQ@mail.gmail.com>
 <1332106632-31882-1-git-send-email-andrew.kw.w@gmail.com>
 <7vk42gbkl1.fsf@alter.siamese.dyndns.org> <4F679E67.4080708@sohovfx.com>
 <4F6E289B.4020104@sohovfx.com> <4F7A2A79.1040900@sohovfx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Wong <andrew.w@sohovfx.com>,
	Junio C Hamano <gitster@pobox.com>,
	Andrew Wong <andrew.kw.w@gmail.com>, git@vger.kernel.org
To: Andrew Wong <andrew.w-lists@sohovfx.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 01:08:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEqMh-0002Ce-38
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 01:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814Ab2DBXIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 19:08:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57032 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751331Ab2DBXIl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 19:08:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 136C16F2B;
	Mon,  2 Apr 2012 19:08:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+5mwgkoCNdS/C80bCORTOxPiO5I=; b=TcWL7z
	YMw6O6z0jxqLIND29Y3thBYxe4cz35dUqk8ch0D5iffmHdJusHbCCiVReBAs/dm5
	J+GW/NnyXQNJgxS5eZqddDzoUhy6kOMSkqAIi/P8Vw1UHOdfc875Q/29jPpdWovx
	Ih39a6hj9ItYcr7AY799W0mr3MsghCKgza6JU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DpHrwoH4BzkWMbECnhuQwqe+Dh88+XZn
	prKuCz8IDw1kiT6tDK8XSrVYhftrJVmDgbzbfUJdjN9KXy2xfdy7JnX5Q0iK+Bii
	/KsDYFWLJGr9c0AZJy8WPs8aTreNv6RlvU7IYF3U3DXngQwAdREIhULC8EGiIlky
	bq2Vh3Dovoo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BC076F2A;
	Mon,  2 Apr 2012 19:08:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 989966F29; Mon,  2 Apr 2012
 19:08:39 -0400 (EDT)
In-Reply-To: <4F7A2A79.1040900@sohovfx.com> (Andrew Wong's message of "Mon,
 02 Apr 2012 18:38:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C89EE8FA-7D18-11E1-8CC8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194577>

Andrew Wong <andrew.w-lists@sohovfx.com> writes:

> Can we look into queuing this patch? Or does anyone have any thoughts on
> this?

I do not recall if I convinced myself that the patch was fixing the right
problem, or it does not look like it would break other cases; reviews from
interested parties are very much appreciated.

This fell through the crack. Thanks for sending a reminder.
