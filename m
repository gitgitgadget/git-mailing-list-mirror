From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git.txt: fix list continuation
Date: Thu, 14 Apr 2011 10:45:37 -0700
Message-ID: <7vtye0hgla.fsf@alter.siamese.dyndns.org>
References: <534233ecaf1b1e364954926ddbf11d47cf9b444e.1302765412.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Apr 14 20:33:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QARLj-0005VQ-Ln
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 20:33:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932860Ab1DNScx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 14:32:53 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47211 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932844Ab1DNRps (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 13:45:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 104575AEB;
	Thu, 14 Apr 2011 13:47:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hpnUsUjHp8fSxQuiTd49/55lS8s=; b=nXEe49
	cKyUcwlLNyZuMRb36WKMVC2df+9gjZe5Mu971vn6fJ9JMJKqX+w00mCAgXfHTqMp
	/sssKltcGCuQhQa/ZXeYEGvC8sVKN3Holmn6RFvrigrIVkAUxZqOoh8HUuNP9rqF
	POJFJYTfgcEwevh7CJ2mpPc8NZLh23qIPo6Jk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S5yr5l7ZnZfIHB9jGJ9wiU0ncAhKMn05
	pY1L8bFH6PRZNfSdzvsFtHRm7vmleTe+2dC5qgzOTflQ++F+UwQLcid1nTUa6JTr
	43awc/LsjDTmk1eMBFy1MG2/X1ZfbmNkOSaJlmaWhYtskmld4bqfX64iiWZUBpPH
	wma5ZONiF04=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E16595AEA;
	Thu, 14 Apr 2011 13:47:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DE4FF5AE8; Thu, 14 Apr 2011
 13:47:38 -0400 (EDT)
In-Reply-To: <534233ecaf1b1e364954926ddbf11d47cf9b444e.1302765412.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Thu, 14 Apr 2011 09:17:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4BCDF304-66BF-11E0-B83C-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171532>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Remove a spurious empty line which prevented asciidoc from recognizing a
> list continuation mark ('+'), so that it does not get output literally any
> more.

Thanks.

The preformatted copies at k.org shows that there was a breakage somewhere
between v1.6.3.4 (formatted with AsciiDoc 8.2.5) and v1.6.4.5 (formatted
with AsciiDoc 8.4.5), but I don't see any change to the source between two
versions that would matter.  Perhaps the older AsciiDoc was more lenient.
