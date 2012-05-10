From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Change error messages in ident.c...
Date: Thu, 10 May 2012 13:28:21 -0700
Message-ID: <7vehqrn5lm.fsf@alter.siamese.dyndns.org>
References: <1336676770-17965-1-git-send-email-angusgh@gmail.com>
 <20120510192339.GA32357@sigill.intra.peff.net>
 <7vipg3n6pu.fsf@alter.siamese.dyndns.org>
 <20120510202227.GA30965@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 10 22:28:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSZyQ-0002uG-0v
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 22:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755435Ab2EJU2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 16:28:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47134 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755159Ab2EJU2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 16:28:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A71E1616C;
	Thu, 10 May 2012 16:28:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=flg7o0bduY0blyoH+2Zo8jXUfXs=; b=fy0DJE
	4OI0eXLahDtB4QfbKSibmeZlg+yznjLr6qNJOL/niFcGIGfhx2Zf/HFV6FkVBybx
	omdi8pN9wfY59S/aX8L6JpdenH0/lZPUyb1YiCx/frXo+pjqUAqyPNCBiRqN9sn8
	RgVuOwb29edkwHPOnCLLomwYXQfYB9lizyUw8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hw39kuQrNOkeIxYmoK53GGi6Dn/qtbjH
	lkecmaHPWPgg2m06scvDAgpzhyjkmIZhYrF9G91OPgMYMH9XgnlN7RRQDnSCMvQu
	Ie9ecQDRGnbRrk4Wx5EkTOTJLErex5obFHmVTHXEcOaLxwqQNeERr81Mh4DQr7tW
	Efble61I7TU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E14E616B;
	Thu, 10 May 2012 16:28:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E51196167; Thu, 10 May 2012
 16:28:22 -0400 (EDT)
In-Reply-To: <20120510202227.GA30965@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 10 May 2012 16:22:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B05355E0-9ADE-11E1-82FB-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197628>

Jeff King <peff@peff.net> writes:

> It doesn't get rid of the "you don't exist" message, and I think just
> dying there makes sense.  But that is actually the one that I consider
> the most likely to happen in practice, and should probably have a more
> useful error message.

Yeah, I do not think anybody minds losing that phrasing from that message
(the "parents" and "sysadmin" were the humorous ones), and we certainly
can phrase it differently, e.g.

    Your system didn't tell me your real name; hint: git help config
    and look for user.name

or something.
