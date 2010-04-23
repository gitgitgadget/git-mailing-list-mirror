From: Junio C Hamano <gitster@pobox.com>
Subject: Re: diff without num-stat
Date: Fri, 23 Apr 2010 10:47:08 -0700
Message-ID: <7vaasuvz6r.fsf@alter.siamese.dyndns.org>
References: <19408.40250.102191.314496@winooski.ccs.neu.edu>
 <4BD156F8.5090307@drmicha.warpmail.net>
 <7vwrvyzfr3.fsf@alter.siamese.dyndns.org>
 <19409.54647.62163.893635@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Fri Apr 23 19:47:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5MyJ-0002yM-So
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 19:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758276Ab0DWRrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 13:47:18 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35065 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757895Ab0DWRrR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 13:47:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 86F44AD92B;
	Fri, 23 Apr 2010 13:47:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X8gKgqZGLjPTjU5b1VR/B0dDf0k=; b=fErUCp
	1qoWPEHE+pUOdK80ixxt1uJI1i4h3OCyWwbOSI2h5Hxa2Nhusrk2eVpIIX4Hloau
	3WDa4ridlcMJgUfKTY0d9W85F7yJqIi/+VfBSYorRS/6HR9tw8tGLa70cb5mwfbz
	8CS7T24QMCZct3eqn6UBUiNN71wizP0lVYZCg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TJssa5p4q1mYM9lckVbFUSUr3ZGvfPQo
	B7Je6anpbON6EavZO64129aC1xCF1ztfoTWzKFCS+0J5XdoHXolEP+lWcr8k3lHo
	5lIZzUHwlSsLgqSH56vmwoa5aW0uqhwUrrzQVSZfO0lNnHoiax3e7uV5fiIpa4nI
	782XGH7YacI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 52DA4AD929;
	Fri, 23 Apr 2010 13:47:13 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8490EAD924; Fri, 23 Apr
 2010 13:47:09 -0400 (EDT)
In-Reply-To: <19409.54647.62163.893635@winooski.ccs.neu.edu> (Eli Barzilay's
 message of "Fri\, 23 Apr 2010 13\:14\:31 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3FC7B54A-4F00-11DF-A7F7-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145631>

Eli Barzilay <eli@barzilay.org> writes:

> Well, the reason is to have an easy-to-glance-over summary of changes
> for push notification emails.  I didn't realize that the intention of
> --stat was to be completely compatible with `diffstat'.

I think you have it somewhat backwards.

Being the same as normal diffstat output that people are familiar with,
the output makes it "an easy-to-glance-over summary of changes" whereever
it is used, be it in a notification e-mail or from interactive command
output.
