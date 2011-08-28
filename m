From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Idea: "git format-patch" should get more information out of git
Date: Sat, 27 Aug 2011 23:34:13 -0700
Message-ID: <7v1uw69h96.fsf@alter.siamese.dyndns.org>
References: <4E587CC0.4090508@alum.mit.edu>
 <7vippiaduw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johan Herland <johan@herland.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Aug 28 08:34:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxYwp-0007ki-C1
	for gcvg-git-2@lo.gmane.org; Sun, 28 Aug 2011 08:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235Ab1H1GeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Aug 2011 02:34:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40562 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750922Ab1H1GeP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2011 02:34:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22715233B;
	Sun, 28 Aug 2011 02:34:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aM4A8uVebMCwC8qYTr8Nup32Xj8=; b=KH10yE
	PiiZuz0OTkVZ4HJPQYvL3oZH3Fsoc563VvA3IzoX8D1f6fR1mDVKDG1Vuk8Ay5XC
	XM4jBCmLJrHwukMc5606T9KHyhZdjJEgQAvKhHO4TfqMKoMt1TdzLVLauEKITVSv
	LwskgPbQM9BCyc+RKXzfvGInij1+s7+FdX1Es=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uE/0mCqAiQdFSXkh7RG6XV86epSbRiek
	Fxe0mtIeBxbxD1hmcyX5SGdRabahSPLoQtFzEG69q6y97lkfNHZ1hRoeoOPplx1G
	M/lt6FglLR1PlY3klPBIG8yuF9NvFU9gAVYXdM1CwFf6bb8BrJHwpSjAFDbUow9e
	lzEx0/1EjVo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13C64233A;
	Sun, 28 Aug 2011 02:34:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99F4F2339; Sun, 28 Aug 2011
 02:34:14 -0400 (EDT)
In-Reply-To: <7vippiaduw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 27 Aug 2011 11:46:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BF75B7A2-D13F-11E0-8940-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180259>

Junio C Hamano <gitster@pobox.com> writes:

> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> 4. There is no place to store the "additional information" (the part
>> that comes in patch emails between the "---" and the diffstat) while
>> working on the patch series;...
>
> I thought there was a RFC floating around to do this using notes and also
> teach it to "commit -e" a few months ago? I vaguelly recall that Peff and
> one of the J's were involved, so I am CC'ing them.

Also, when I prepare a commit to be sent with an additional piece of
information, I often write "---" and the additional message after my
S-o-b: line while preparing the commit log message. Unlike format-patch
that strips that off, commit keeps it, which is handy.
