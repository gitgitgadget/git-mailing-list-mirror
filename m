From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] i18n: po for zh_cn
Date: Thu, 02 Feb 2012 00:15:38 -0800
Message-ID: <7vhaz9y7kl.fsf@alter.siamese.dyndns.org>
References: <1328111436-58925-1-git-send-email-worldhello.net@gmail.com>
 <7vr4ye15kr.fsf@alter.siamese.dyndns.org>
 <201202020111.33772.schwarzerf@gmail.com>
 <7vmx91ygst.fsf@alter.siamese.dyndns.org>
 <CANYiYbEG+QqBQi6Xagk-bmRoz3So_f0HVtZRb8+T0f9hXcuq4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frederik Schwarzer <schwarzerf@gmail.com>, git@vger.kernel.org
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 09:15:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsrpa-0007AL-7V
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 09:15:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754286Ab2BBIPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 03:15:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50770 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754061Ab2BBIPl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 03:15:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 420DF7F2F;
	Thu,  2 Feb 2012 03:15:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Isc5QarvJS4u9b5Hz5CtWI9LjeU=; b=XCZOhD
	Wlb7VYBfx/yv1aFed4vbH1x+83ZUsmlP3WDRJRlRh22cC0swUjNI2mBjxiNpY1aN
	WDd+93H7Ub0DoYf2TwydKXzYXKVJlaWdVuUvfHYn11IHYAZhEXBforX8ccjtoKNr
	ImcZqoUGVtDSJw5CnXYJs7ommqALXVSRByFz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HB6UNOidTOw68xGH1cOW32IaD0WWzhXP
	ghwFl3SVyUFqSfP2Y2sk0j017oyQ45ssMPXNVMwwqxGgfGeCfcygD3LXEBnk4K95
	mxLiNuVwB7wm6EC+95m4rFIxXDdnWXLlgynej8ogcC9vNM3NPNlrmvmBH6bg9Toq
	aKiDgBPLyaY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 396647F2E;
	Thu,  2 Feb 2012 03:15:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C28837F2D; Thu,  2 Feb 2012
 03:15:39 -0500 (EST)
In-Reply-To: <CANYiYbEG+QqBQi6Xagk-bmRoz3So_f0HVtZRb8+T0f9hXcuq4w@mail.gmail.com> (Jiang
 Xin's message of "Thu, 2 Feb 2012 14:43:01 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 17C4BF5E-4D76-11E1-93A7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189589>

Jiang Xin <worldhello.net@gmail.com> writes:

> 2012/2/2 Junio C Hamano <gitster@pobox.com>:
> ...
>>  (6) From time to time, the l10n coordinator will pull from "git.git" when
>>     meaningful number of changes are made to the translatable strings.  I
>>     hope this would happen much less often than once per week, preferably
>>     much less frequently. The l10n coordinator updates po/git.pot and
>>     makes a commit, and notifies the l10n teams.
>
> notifies the l10n teams using another mailing list maybe.

I personally think using the regular git@vger.kernel.org list would be
preferrable for this.  People who translate would want to learn the
reasoning that led to the final phrasing of the messages to come up with
usable translation, and following the main list would be one way to do
so. Having to follow two separate list will be an unnecessary burden.

But the choice of how to coordinate his or her work with the l10n teams is
entirely up to the l10n coordinator.

>> And i18n patches that modify the _() markings in the source code, will
>> only go through "git.git" tree in the normal channel, IOW, this mailing
>> list.
>
> Yeah,  works on the codes but not the po files still send to this list.

Many if not all of the po files in gitk and git-gui were discussed on this
list and integrated to the tree with the usual "format-patch to am" review
flow just fine.  You keep saying that l10n patches does not work, but that
is patently wrong.

It is a different matter if it is the most convenient for l10n patches for
both the l10n folks and others to review and discuss on this list, or on
web based services like GitHub.
