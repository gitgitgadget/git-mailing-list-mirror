From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] githooks.txt: put hooks into subsections
Date: Mon, 07 Sep 2009 12:30:08 -0700
Message-ID: <7vd462r1rz.fsf@alter.siamese.dyndns.org>
References: <6bd645c76041635d77e5ecc626e4386bd97715b4.1252168850.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 21:30:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkjvS-0003gK-44
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 21:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbZIGTaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 15:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbZIGTaU
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 15:30:20 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36592 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbZIGTaT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 15:30:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0C79648C52;
	Mon,  7 Sep 2009 15:30:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mcIoz3GmIR5CQFv6ctOJhoti2YI=; b=ZGWq9S
	FqVrxgn4ZUn+MZQLoTji4Zd4zjyurPTeenP5lS4T5iRSgXpiD1j9SiAtHuJm/KYg
	TIhvFLe+N3SVuIaKBCr7JahZpQXIOfppytqDDK6/XWFhHOT8e+C2zVg6AFyzqtzv
	JPZ47vGndOvWgElcYh2j2qzyhaxqs+Oy1SQJA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I2YhgaekYTCm0sy6vzBrpPpUsARCYSgB
	XgyapPvQCD1zrfA1HBxbblYmrysMWjtwGJxsZa0/ZY4Sz8gnVUcPXAn7vFy7QMFl
	ttng65BQ3i3PX08CT3aj7FjK2SdgPaQYOATcci4t4bPlySQ2WBC0kH7Es6DvxGIe
	jTz/fyTye/A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D555848C51;
	Mon,  7 Sep 2009 15:30:16 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3A2DC48C50; Mon,  7 Sep 2009
 15:30:09 -0400 (EDT)
In-Reply-To: <6bd645c76041635d77e5ecc626e4386bd97715b4.1252168850.git.bert.wesarg@googlemail.com> (Bert Wesarg's message of "Sun\,  6 Sep 2009 12\:22\:58 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DF436030-9BE4-11DE-BC3A-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127943>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> All hooks are currently in its own section. Which may confuse users,
> because the section name serves as the hook file name and sections are
> all caps for man pages. Putting them into a new HOOKS section and each
> hook into a subsection keeps the case to lower case.

Sounds like a sane thing to do.  Thanks.
