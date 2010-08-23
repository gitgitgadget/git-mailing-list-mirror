From: Junio C Hamano <gitster@pobox.com>
Subject: Re: HTML help files are broken
Date: Mon, 23 Aug 2010 10:41:17 -0700
Message-ID: <7vmxsd1b2a.fsf@alter.siamese.dyndns.org>
References: <AANLkTimMZGswhWXyDMaFa9N1ipzoBXT7RptHMq2TYhmv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Nathan W. Panike" <nathan.panike@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 23 19:41:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Onb1c-0003oj-32
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 19:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951Ab0HWRl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 13:41:26 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50670 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312Ab0HWRlY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 13:41:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A5308D0B03;
	Mon, 23 Aug 2010 13:41:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s22JngPoCSuBmLTwmanrUGgQfTU=; b=n5fI7h
	feVwh6g4N6xS0xZs+ruqhpWfZ4tvgvDCxhqlLsRtZa5Z1Dv/aYwbOxmX/4RDPw3R
	rNtcd9M3gMP9tZ1h7AffKYxKV8jm6CwGsqDwcwOYRH3V3Z+czL7ArOpN4yOWkHlK
	6ZXbbkx3BrvITi4Et4bD3F4oWhuNCoxBLUcgE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h3PJp7rtv747QQx9FSV+OwJYFMVPy4Ev
	VB3POoy7d0xVMDTJqCvBebcqLV8IvLIQfdBwpthgozFRnMd74J0Y52VDd/UP3pwn
	sXgFCx8/YawJ29sXoOEy2d0bF8gSdkQpNbCDL/rNQrfwxfB5/UuYkZWShGFB4kK4
	kytC84kXI7M=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E67ED0B01;
	Mon, 23 Aug 2010 13:41:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D3AA7D0B00; Mon, 23 Aug
 2010 13:41:18 -0400 (EDT)
In-Reply-To: <AANLkTimMZGswhWXyDMaFa9N1ipzoBXT7RptHMq2TYhmv@mail.gmail.com>
 (Nathan W. Panike's message of "Mon\, 23 Aug 2010 10\:59\:04 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A47A8958-AEDD-11DF-9921-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154239>

"Nathan W. Panike" <nathan.panike@gmail.com> writes:

> Some of the HTML manual files produced on my machine (Ubuntu 10.04)
> from the git source are broken: in git-help.html, I get the following
> for the link to the git-web--browse manual page:
>
> <a href="git-web&#8212;browse.html">git-web&#8212;browse(1)</a>
>
> where the &#8212; (en-dash) replaces the "--" (dash-dash) that is on
> the filesystem.  How does one fix it, so that the line above would be
>
> <a href="git-web--browse.html">git-web--browse(1)</a>?
>
> The command line I am using is a simple
>
> make doc.
>
> I checked the git repository origin/html, and the correct link is
> produced there, so something in my configuration is messed up.

Yup, I can see that on an Ubuntu 10.4 box with AsciiDoc 8.5.2 but not on
boxes with 8.2.5 nor 8.2.7.
