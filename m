From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/15] user-manual: Use 'git config --global user.*'
 for setup
Date: Sun, 10 Feb 2013 14:48:01 -0800
Message-ID: <7vobfrrdjy.fsf@alter.siamese.dyndns.org>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
 <b363f5b410098302a02af2d79b5b68ee79210be2.1360508415.git.wking@tremily.us>
 <7vip5zstsa.fsf@alter.siamese.dyndns.org>
 <20130210222508.GC8377@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sun Feb 10 23:48:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4fhO-0007pA-Hr
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 23:48:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756947Ab3BJWsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 17:48:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60247 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756854Ab3BJWsP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 17:48:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DE56C3F5;
	Sun, 10 Feb 2013 17:48:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qJiKUJwuvJxavHf2U3tw04ceA+c=; b=P65CYv
	swc7/6S/OLbTf8+UT+f5BAfgtYXKTQDNG5TJpp9M5rM9o/OZkqDZS5SBfM/azT49
	modcm7AdKrHlz6hdCixayqe9uyor6qTcdmLcx1j46vr3EYDvNNKjI+A9dnTIPgG7
	El7/mz2HNBLgOEOnjabdbsy5nxElkwOLm1Evk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kxycm19lPSJyliEhK86k+myqGrv+2ouD
	yHgfudrICpKIICEe6MCWvxIvqMXejY4w+MqCXucgta3gUOir/b6KGBkBYXCgD4Hj
	wlKSa6ZiO0RuozglIAKveG9/NOiHZS8Akns89JcSb74fKquRD3CT4/q0ittqhWyW
	P7ZVRn26G/U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7D25C3CA;
	Sun, 10 Feb 2013 17:48:12 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B8D34C368; Sun, 10 Feb 2013
 17:48:07 -0500 (EST)
In-Reply-To: <20130210222508.GC8377@odin.tremily.us> (W. Trevor King's
 message of "Sun, 10 Feb 2013 17:25:08 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F2B0A0CC-73D3-11E2-8FAD-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215963>

"W. Trevor King" <wking@tremily.us> writes:

> On Sun, Feb 10, 2013 at 02:12:05PM -0800, Junio C Hamano wrote:
>> > +Which will add the following stanza to a file named `.gitconfig` in
>> > +your home directory:
>> 
>> Looks good, even though I do not think we would want/need to confuse
>> the readers with an unfamiliar word "stanza".
>
> Aw.  I suppose "section" is better?  (It's what Python's ConfigParser
> uses anyway).  I saw "stanza" in another part of the manual and
> thought it was quite poetic ;).

How about not saying anything and say "adds the following"?
