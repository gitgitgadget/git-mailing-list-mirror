From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2014, #04; Wed, 12)
Date: Fri, 14 Feb 2014 12:10:05 -0800
Message-ID: <xmqq4n41ihgi.fsf@gitster.dls.corp.google.com>
References: <xmqqd2ism1pu.fsf@gitster.dls.corp.google.com>
	<20140214194436.GB743@foghorn.codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Eikum <aeikum@codeweavers.com>
X-From: git-owner@vger.kernel.org Fri Feb 14 21:10:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEP5W-0003WV-VT
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 21:10:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735AbaBNUKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 15:10:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59873 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752260AbaBNUKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 15:10:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 672066C808;
	Fri, 14 Feb 2014 15:10:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JBzH1zgCHL9vnzaqDZtModR8NWw=; b=sDsD23
	KuGaxf+NlvKCN4y+dcehO9PNjIBDZKj96sVb+PaD0O8VJOl6F5BdItb9B3Pt9N02
	vdPvObvDJI/nMjcXfxk3Tvk5UZEcpZKCmHS5sdsCbcmfVxe9MKZUkimmX2Dkq3Vw
	DVYQFzIz1qcB3QLro/Qak+wA3lonLWcrrwQus=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aY4LOUzBdVZ+yg0o+5KlyJywe553cUfv
	HG4S7gf0L9gZXbdNCNHiBhugmpnAQz4XYRLFulHD7wwOtfF0LyxrZDZQnNk7F+LQ
	VkT12/ZtlWJ/wEeXyHnmkJovy1BvUUQ6od2ZiXxBpfHIx6IdgsyRsWaxMaBdvyLk
	UD0Ynf2KVoE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 273866C806;
	Fri, 14 Feb 2014 15:10:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA7DF6C804;
	Fri, 14 Feb 2014 15:10:07 -0500 (EST)
In-Reply-To: <20140214194436.GB743@foghorn.codeweavers.com> (Andrew Eikum's
	message of "Fri, 14 Feb 2014 13:44:36 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 00072BBC-95B4-11E3-B5B3-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242142>

Andrew Eikum <aeikum@codeweavers.com> writes:

> On Wed, Feb 12, 2014 at 01:59:41PM -0800, Junio C Hamano wrote:
>> As a workaround to make life easier for third-party tools, the
>> upcoming major release will be called "Git 1.9.0" (not "Git 1.9").
>> The first maintenance release for it will be "Git 1.9.1", and the
>> major release after "Git 1.9.0" will either be "Git 2.0.0" or "Git
>> 1.10.0".
>> 
>
> Apologies if this ground has been tread before, but has there been a
> version numbering discussion? A quick google didn't seem to turn
> anything up.
>
> This seems to be an opportune time to drop the useless first digit.
> Explicitly, the major release numbers would be: 1.8, 1.9, then 2.0,
> 3.0, 4.0, etc, with the 2nd digit would take the meaning of the
> current 3rd digit and so on.

Considered, and discarded.

cf. http://article.gmane.org/gmane.comp.version-control.git/241498

When you see a version number vX.Y.0 next time, think of it as just
play vX.Y without the third digit, and you will be fine.  People's
script cannot learn the "think of it as ..." part overnight, and
that is why we have the .0 there.
