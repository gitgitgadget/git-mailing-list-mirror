From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config --global --edit: generate correct .gitconfig template
Date: Thu, 07 May 2015 11:41:02 -0700
Message-ID: <xmqqbnhwp6wx.fsf@gitster.dls.corp.google.com>
References: <1430934077-20724-1-git-send-email-pchpublic88@gmail.com>
	<xmqqzj5htws0.fsf@gitster.dls.corp.google.com>
	<CAM=ud8xTwmR-4TRCXkDJGGB0R6y8kdqN_=Px0H6PAC7BLN_wFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Matthieu.Moy@imag.fr
To: Pete Harlan <pchpublic88@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 20:41:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqQjS-0003z6-AY
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 20:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbbEGSlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 14:41:07 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65474 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751415AbbEGSlE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 14:41:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EC8FC4D598;
	Thu,  7 May 2015 14:41:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TA4VoqFBQ7MF6bP0h+v9zdhgdlM=; b=hJIVEl
	+cN2OdicRbAQ6skhxl9WlDceHd259xpFSCm4j6uGNMpI5XvUeKnWQPxXj1ExXL6G
	9MEoMN3PWPQ3QGUbCFwl4aC/Pb5kkZK5LnfZqUZ6NFpwL2AMgpsigIWdXj7nScz6
	QwE4BBQUqo6/6ZlRz9DMJWBUaBWCpz7/r8g3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IJoRtvm7stmeI6U8CNxCiEYgVC6nQ0J9
	9+qGH/lw1KCgy/dYj44HOlbTiqEJMQ+7bitpQCTIHpYB4O7OMXSiKry3+ZOyZ1sA
	pNABLYcOCFGFRBg1NiJE7+MKKUxDvR3HmYoYPMgOFo8x1va0f+cRMaUjWPMEnrDE
	hfKgKIEmdXY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E5A9E4D597;
	Thu,  7 May 2015 14:41:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6952D4D594;
	Thu,  7 May 2015 14:41:03 -0400 (EDT)
In-Reply-To: <CAM=ud8xTwmR-4TRCXkDJGGB0R6y8kdqN_=Px0H6PAC7BLN_wFA@mail.gmail.com>
	(Pete Harlan's message of "Wed, 6 May 2015 11:10:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9D2BDAE8-F4E8-11E4-8E7B-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268574>

Pete Harlan <pchpublic88@gmail.com> writes:

> On Wed, May 6, 2015 at 10:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Thanks, I think this was already done in 7e110524 (config: fix
>> settings in default_user_config template, 2015-04-17).
>
> Whoops......indeed, I'll check more than just master next time, thanks.

Building 'next' and using it for your everyday Git need is a good
thing to do.  You'll get well-eyeballed fixes earlier that way.
