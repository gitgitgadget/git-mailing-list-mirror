From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] Correct word usage of "timezone" in "Documentation" directory
Date: Tue, 12 Nov 2013 10:40:31 -0800
Message-ID: <xmqqob5ph3a8.fsf@gitster.dls.corp.google.com>
References: <1383958133-4207-1-git-send-email-jstjohn@purdue.edu>
	<1383958133-4207-2-git-send-email-jstjohn@purdue.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Jason St. John" <jstjohn@purdue.edu>
X-From: git-owner@vger.kernel.org Tue Nov 12 19:40:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgItJ-00053Y-0o
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 19:40:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753204Ab3KLSkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 13:40:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42366 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751972Ab3KLSkf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 13:40:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8115C52004;
	Tue, 12 Nov 2013 13:40:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KVWwDVv+J3TGlREnUecAoNKCGH0=; b=n4qtO1
	CN94+I1cMOIU0QOetx6LjznW9ypokq9sqgvy57+/C3gsZ5SYICQZXAF0npL580rJ
	RkG8ViQp26tL/XYZjUOcmiLqyBe7EHqoOTXQIvo9atbNipfhruqV6+G5etDnPEDH
	mFEkhIR0dAmiwNydZ/Fq0+uX/7ijR4OOaUo/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XIBKB0q4cmCjcHUphwrRCwEu34CNI2i7
	yVu3RpMelwJUNpCf0GKyb0/fMmF+9LbS6CA6NtlbUhU9UeMg0K8aeVTsv1j6M4uo
	Ttzwm4ZLJMEL7spnei/7IvsaByp/nXwsbIG9vNHPaeAvsiryJiNE+B1r3M0QBWll
	ZK4zELOP+tg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7463352003;
	Tue, 12 Nov 2013 13:40:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B9B1952002;
	Tue, 12 Nov 2013 13:40:33 -0500 (EST)
In-Reply-To: <1383958133-4207-2-git-send-email-jstjohn@purdue.edu> (Jason
	St. John's message of "Fri, 8 Nov 2013 19:48:52 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EA018B5C-4BC9-11E3-BE41-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237728>

I'll take this patch among the 4 in this series for now.

I do not have immediate opinion on 1/4, other than "The original may
have room for improvement, but the patch posted is probably not it".

As to 2/4, I agree with j6t and peff that `--date=local` is more
preferrable than '\--date=local'.

As to 4/4, I agree with Jonathan that we should keep the release
notes as they are (thanks for separating the patch into two between
3 and 4, by the way).

So I do not mind seeing discussions, improvements and rerolls on the
first two in the series.

Thanks.
