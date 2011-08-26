From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] fast-import: initialize variable
 require_explicit_termination
Date: Fri, 26 Aug 2011 11:55:31 -0700
Message-ID: <7vvctkc89o.fsf@alter.siamese.dyndns.org>
References: <1314378689-8997-1-git-send-email-Matthieu.Moy@imag.fr>
 <7v8vqgdpsv.fsf@alter.siamese.dyndns.org> <vpqr548hx40.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Aug 26 20:55:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qx1Z5-0007RV-FR
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 20:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171Ab1HZSze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 14:55:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36796 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750973Ab1HZSzd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 14:55:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B2DF416B;
	Fri, 26 Aug 2011 14:55:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cpFEKu3y1hSkQYUSCtm9gifGWzE=; b=xfMk43
	xQMXxeA5U+wPAUkShcPp8VIexQ3p8G6EfSD06zIgotJb29h6t15fNp7ji+HA8RZb
	mKqvcyLyizBS8r8Q/Tcz+C1Fy9x/1ADC0scy9dV70rLCnRYoJf1J+FEeWPt3Z92q
	kCaF0+28qptBQ575E9eT4DAYwBnJRtSIG2kFI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I5+oUsfCFNzC5KQtRiDyX8BNcsTcM39L
	JiWyM+wCk4AZL7Wu4WXmf57UexpVU6MpklGYrmnZZPDeI0VcLj5uUxsLX4zKixSc
	/Pnn0gwzW0sGSVCqsvSYQH452T0IBlpdzrCGbrD3mUQLC/NQakk0fFrgHg5mSOFI
	f+CfFu/r80s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3253A416A;
	Fri, 26 Aug 2011 14:55:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BBA364169; Fri, 26 Aug 2011
 14:55:32 -0400 (EDT)
In-Reply-To: <vpqr548hx40.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Fri, 26 Aug 2011 19:59:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F9AB516A-D014-11E0-9E6E-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180189>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>> Please do not write unnecessary " = 0" there.
>
> I prefer being explicit, but that's a matter of taste, and I don't
> really care, so let's drop this patch.

I prefer being explicit, too, but "static int foo;" is explicit enough if
you know C.
