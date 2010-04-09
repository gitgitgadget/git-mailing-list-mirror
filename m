From: Junio C Hamano <gitster@pobox.com>
Subject: Re: am: be more helpful
Date: Fri, 09 Apr 2010 16:27:37 -0700
Message-ID: <7v4ojk1a1i.fsf@alter.siamese.dyndns.org>
References: <t2kfabb9a1e1004091559u92230e17h957f2c5565c133e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 01:27:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0NcD-0004rZ-57
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 01:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754903Ab0DIX1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 19:27:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51879 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900Ab0DIX1v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 19:27:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B919A97CA;
	Fri,  9 Apr 2010 19:27:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=el6hBPUwNh4cr8YT8mNcz+ktuiw=; b=taO9qk
	SB1fQDcegWk6zZSS0RjZSnvH21NLeOVzJX0SFfHHcCNPt7wKpiZcTTPaDb0VGU/N
	2yxgKx+BuK6jfQPEdJVwzVUwq5M1YdYMjINmPP7PpIC7Jmy7MNP2OYsb5IRvW9Dj
	TOTxOpHt9w8oJeMzbdT0Wrz8TpFzqS9zMWCAs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZyN1zOlaTXY+hW15UYITNGUHwhdKAujw
	XIQ88HCVESYDBz79tNLUwRPA2tNqlfCY9JS/hNmp06zXMHiMl6cbpYgkkQCHLW3l
	YDgOCH9oNxFQ6V+NMFrCKMDbnRcxi2q7XF7+XREOaSDsVJT2d7sVxQiymiKJkGWN
	TICEQmmNT40=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FDC2A97C9;
	Fri,  9 Apr 2010 19:27:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 199C5A97C8; Fri,  9 Apr
 2010 19:27:38 -0400 (EDT)
In-Reply-To: <t2kfabb9a1e1004091559u92230e17h957f2c5565c133e3@mail.gmail.com>
 (Sverre Rabbelier's message of "Sat\, 10 Apr 2010 00\:59\:11 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7F78B152-442F-11DF-99C8-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144486>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Heya,
>
> I run into this problem every now and then when I manually apply a
> patch. I apply it, do some stuff, and then having forgotten I already
> applied it, try to apply it again, and am confused as to why it won't
> apply. Would it be difficult to teach 'git am' to see if the patch-id
> of the patch that couldn't be applied has been applied already
> (similar to what 'git cherry' does I guess?) and print a helpful
> message saying "warning: patch already applied" when there is a
> conflict trying to apply such an already-applied patch?

"am -3"?
