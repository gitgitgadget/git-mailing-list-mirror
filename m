From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: remove CHERRY_PICK_HEAD when cherry-pick
 failed
Date: Mon, 02 Apr 2012 22:15:21 -0700
Message-ID: <7vk41xcs5y.fsf@alter.siamese.dyndns.org>
References: <CAMP44s1EAwHjQ7S2ArLvhNg5qkR05DRJ70tQmP8sXYdOP=i_zQ@mail.gmail.com>
 <1332106632-31882-1-git-send-email-andrew.kw.w@gmail.com>
 <7vk42gbkl1.fsf@alter.siamese.dyndns.org> <4F679E67.4080708@sohovfx.com>
 <4F6E289B.4020104@sohovfx.com> <4F7A2A79.1040900@sohovfx.com>
 <7vr4w5d955.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Wong <andrew.w-lists@sohovfx.com>,
	Andrew Wong <andrew.w@sohovfx.com>,
	Andrew Wong <andrew.kw.w@gmail.com>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 07:16:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEw62-00041i-Pu
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 07:15:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515Ab2DCFPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 01:15:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47374 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750756Ab2DCFPY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 01:15:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFFA66BA3;
	Tue,  3 Apr 2012 01:15:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=94xSvC6QueldwrNiajv8xXQeQ0k=; b=Wf+wrd
	gLSbBz/Oo8CNcNPVDL6meK6KlihK7jXcrspwsXSoFHwHw/vDZGtdXYKgkvKX4BaH
	p3iZDVgmDU2dAMmEcE4oR2tvVb3Glv3ThU7CgeYwRMQSLUdRfwAWjS8ukquz3prf
	bgcdJYFgRk6ocjNiakBR7Wx0KsRATZ84AxX4g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q4zhMDqagQXejGWmsxMPzTOjC/Rf4dM+
	1muW0NqlJShxhl8+X8ndkgk0gKgDrm14evuUQEx9T5FxhKcppczsK7EBwgs6aSqq
	Dm560bay8Cas56BQ2M1mJdmkS6qRUVMvs3EA3ATnWrGpw7a4ZQUImmJHTUCV+Haa
	da7BrOyFkXQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4F4A6BA2;
	Tue,  3 Apr 2012 01:15:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6734C6BA1; Tue,  3 Apr 2012
 01:15:23 -0400 (EDT)
In-Reply-To: <7vr4w5d955.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 02 Apr 2012 16:08:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 03E7F9AA-7D4C-11E1-A23C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194593>

Junio C Hamano <gitster@pobox.com> writes:

> Andrew Wong <andrew.w-lists@sohovfx.com> writes:
>
>> Can we look into queuing this patch? Or does anyone have any thoughts on
>> this?
>
> I do not recall if I convinced myself that the patch was fixing the right
> problem, or it does not look like it would break other cases; reviews from
> interested parties are very much appreciated.
>
> This fell through the crack. Thanks for sending a reminder.

And I forgot to Cc who is responsible for that CHERRY_PICK_HEAD part...
