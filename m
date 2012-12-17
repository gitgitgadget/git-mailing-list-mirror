From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] Makefile: remove tracking of TCLTK_PATH
Date: Sun, 16 Dec 2012 23:32:16 -0800
Message-ID: <7vzk1dm8vz.fsf@alter.siamese.dyndns.org>
References: <20121216193850.23461.28099.chriscool@tuxfamily.org>
 <7v4njlpaet.fsf@alter.siamese.dyndns.org>
 <20121217.082241.794967023844368825.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 08:32:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkVBl-0002l6-T0
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 08:32:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218Ab2LQHcU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 02:32:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43307 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750768Ab2LQHcT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 02:32:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 020119C47;
	Mon, 17 Dec 2012 02:32:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gHDMTAMuoQ/lwkrjORQK+b/kfPk=; b=p7JcPL
	QGdnVN8BWid8pFRlvcDyZs4kp88selnDTmwvv/PulhjPYYPhHqFxPtuvvUpUyxe3
	ZwxOEO5/pYuE3R0YYEKCenMHgJEGRc7Hi+3m2XvrkQJWaBl5VXqR+rROzJ8XKJ5u
	vCfv1TBbMwfvoezKGXx+G9rSZygDovHPVt9Vg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L6EVtvq0lCXpYR2wr/BBwpA0YEF2zRLy
	a38NlFdu+Jkh4N8ZXE5jHSKuIXRJBhRtTYdX21sCta4V73JHjUcDNRwqxFAAaH6h
	4/w1r+HpNjk1JkHdAp+ZxjJ2vjzDfi19LoNaGEyZ6XKHqjhwc9AK43uIA271FrJo
	QXqC5LkSWcY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4F1D9C3D;
	Mon, 17 Dec 2012 02:32:18 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D0FF9C3A; Mon, 17 Dec 2012
 02:32:18 -0500 (EST)
In-Reply-To: <20121217.082241.794967023844368825.chriscool@tuxfamily.org>
 (Christian Couder's message of "Mon, 17 Dec 2012 08:22:41 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E2F004AE-481B-11E2-A082-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211652>

Christian Couder <chriscool@tuxfamily.org> writes:

> From: Junio C Hamano <gitster@pobox.com>
>>
>> Christian Couder <chriscool@tuxfamily.org> writes:
>> 
>>> It looks like we are tracking the value of TCLTK_PATH in the main
>>> Makefile for no good reason, as this is done in git-gui too and the
>>> GIT-GUI-VARS is not used in the Makefile.
>> 
>> This was added to the main Makefile when we slurped gitk to our
>> project at the top-level, so I am not surprised if git-gui were
>> not depending on it at all.
>> 
>> A better explanation is that t62ba514 (Move gitk to its own
>> subdirectory, 2007-11-17) should have moved these lines to
>> gitk-git/Makefile (and I think we should move them there in a
>> separate patch).
>
> Yeah, I just sent an updated patch series that does this.

It still seems to talk about git-gui which the snippet you removed
does not have anything to do with, though.
