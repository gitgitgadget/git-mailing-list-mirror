From: Junio C Hamano <gitster@pobox.com>
Subject: What will be in 1.8.2-rc1
Date: Fri, 22 Feb 2013 15:35:17 -0800
Message-ID: <7vhal3c47e.fsf@alter.siamese.dyndns.org>
References: <7vd2vttfs9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 23 00:35:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U929d-0000Us-An
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 00:35:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758132Ab3BVXfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 18:35:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60621 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756443Ab3BVXfU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 18:35:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8BE3BBB5;
	Fri, 22 Feb 2013 18:35:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xuG3Aq1BVtDULOitmNgqpzFcbFI=; b=CY0Dx6
	FFMErlKfOxYPT3grQLyXHoGREYL3oFo4JnV8oxkrUfaNXAkDM+jNtJA4yLrlO1ye
	K/0bH8k8vTXvu5/a3kjjpAG5AwbuYS/RiocWDIb3tDYZ+nfzha/UqqvmNr8xJxSG
	tL0MRxy2v6i8cuwzAJltG2TxvzJqw+Hu0mqeA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EAAzuvuIq82Cd0gwpcEc1wm+gEyC/krk
	1ZeA9MRNCndO8Ctt7rs84h29aJcyKWnwuD2/w2Rw7tp1FaDZMEztZlq/+VoGYpb/
	rtH8M/dRzqAbMTTqGxSQDhCAjw1SyHGMvIA7cjGkgWN/9eg7lQIYyosXCSvV4DM+
	0RpFTcDGn4o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE285BBB4;
	Fri, 22 Feb 2013 18:35:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C698BBB3; Fri, 22 Feb 2013
 18:35:19 -0500 (EST)
In-Reply-To: <7vd2vttfs9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 21 Feb 2013 15:20:54 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 84CFBEDE-7D48-11E2-A5C9-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216883>

Just a quick update.

I am planning to merge the following to 'master':

 * regression fixes and finishing touches to a new feature

   ct/autoconf-htmldir
   jn/less-reconfigure
   as/check-ignore

 * documentation updates

   wk/man-deny-current-branch-is-default-these-days
   wk/user-manual

I'd also want to have this before the final as a regression fix.  I
haven't decided if I should do so before -rc1:

   mh/maint-ceil-absolute

Thanks.
