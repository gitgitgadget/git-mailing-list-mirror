From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] learn to pick/revert into unborn branch
Date: Sun, 23 Dec 2012 11:20:11 -0800
Message-ID: <7vzk14o9sk.fsf@alter.siamese.dyndns.org>
References: <1356117013-20613-1-git-send-email-martinvonz@gmail.com>
 <1356117013-20613-2-git-send-email-martinvonz@gmail.com>
 <7vr4mhpi0l.fsf@alter.siamese.dyndns.org>
 <CANiSa6i0-Z=FkPnSJxgT+3ABHTzgOTNNNUb=wHQpm2DKAN_UOw@mail.gmail.com>
 <CAP8UFD0GsqPSk-WstydjZHXc5WSmDJimfRcx4Mn7Uyw0s3LdpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martinvonz@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 23 20:20:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tmr69-0006C2-KR
	for gcvg-git-2@plane.gmane.org; Sun, 23 Dec 2012 20:20:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105Ab2LWTUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Dec 2012 14:20:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52505 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751511Ab2LWTUO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Dec 2012 14:20:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D092AC60;
	Sun, 23 Dec 2012 14:20:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aAc9vhajl5n6mqLYv4rJcT0nDX0=; b=TMUsdn
	e5zXnyvTFpWONjI6MYPT3Ufzx/+W1kFBA4F1M1Rsezp4XCvC5o3Wbb3XcjhBDLWf
	GlVBi/G8WuKWPN9Tr1zQN1BDdogvFDGneoXb/1WWaHrjLre1VSlihHfDxwzVXj6k
	2NyYiQsYUhyRJScEJTmkR3MxkQmRyORZRNfkU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CNUkxBTHe+2PNgek9rn9ErpOZ3xBi+n2
	+Ysx70qFhyTNz8+RUmoxYrGeQO04Lsb96pvUXAeBkWztd+7s16a6OQZwg+B5uguP
	mZUjXXXWobvcuYRYoxS6MbDN/7MkJhCL5zut0DC5YZSJpimlAt33lVcBgfIFkBoy
	8smHvR+rWG0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88A91AC5F;
	Sun, 23 Dec 2012 14:20:13 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0730FAC5C; Sun, 23 Dec 2012
 14:20:12 -0500 (EST)
In-Reply-To: <CAP8UFD0GsqPSk-WstydjZHXc5WSmDJimfRcx4Mn7Uyw0s3LdpA@mail.gmail.com>
 (Christian Couder's message of "Sun, 23 Dec 2012 08:01:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C651A374-4D35-11E2-B4D8-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212087>

Christian Couder <christian.couder@gmail.com> writes:

> I agree that it would be nice if it worked.

That is not saying anything.

Yes, it would be nice if everything worked.  But the question in the
thread is "with what definition of 'work'?"
