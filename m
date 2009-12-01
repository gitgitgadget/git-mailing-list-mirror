From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-merge: a deprecation notice of the ancient command
 line syntax
Date: Mon, 30 Nov 2009 20:07:24 -0800
Message-ID: <7viqcr72wz.fsf@alter.siamese.dyndns.org>
References: <cover.1259524136.git.brlink@debian.org>
 <7v8wdnooza.fsf@alter.siamese.dyndns.org>
 <20091201071234.6117@nanako3.lavabit.com>
 <7vmy23bl4o.fsf@alter.siamese.dyndns.org>
 <7vaay3bkyx.fsf_-_@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0911302251270.5820@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	"Bernhard R. Link" <brlink@debian.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Dec 01 05:07:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFK1f-0004VB-JY
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 05:07:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917AbZLAEHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 23:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752658AbZLAEHb
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 23:07:31 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44098 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442AbZLAEHa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 23:07:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BADB7A3C59;
	Mon, 30 Nov 2009 23:07:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qLPCrm0H4n+VzU+bdjY/PwputwM=; b=U90yGq
	8iCNFzhMiwKGme12+cRpnDxOnf0p49Enru78AoYxhTrmULAFgd6rmuIB9hFteVn2
	hn7tTLXoi7HUPe97d4k/7JGnSIvF0504Ep+P6rBrtH0vptO6MnXAGMElj3PuHM+R
	QZPCQVuTTKhhuv442qM32AWlZqV+3KyOB6zQE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U12I+yg7PONUakxN8/llkaV40q7QwX/k
	tqKnbZOGOtup06AIK/iGzbdiMc/Qu6+BxGlvRwAMdi19/hVxYS3rh4oOJ5ESL8dZ
	pdn4EmwbSOOrTAnibgIVyc7dQURZU6up8tvQ9vHq6WsbGMSE4TamsYm14HFAW99M
	dNzd59zqWqc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7A74AA3C56;
	Mon, 30 Nov 2009 23:07:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EC9C9A3C55; Mon, 30 Nov 2009
 23:07:25 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0911302251270.5820@xanadu.home> (Nicolas
 Pitre's message of "Mon\, 30 Nov 2009 22\:55\:58 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0C0B24EA-DE2F-11DE-AE33-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134163>

Nicolas Pitre <nico@fluxnic.net> writes:

> On Mon, 30 Nov 2009, Junio C Hamano wrote:
>
>> The ancient form of git merge command used in the original sample script
>> has been copied from Linus and are still found everywhere, I think, and
>> people may still have it in their scripts, but on the other hand, it is so
>> unintuitive that even people reasonably familiar with git is surprised by
>> accidentally triggering the support to parse this ancient form.
>> 
>> Gently nudge people to upgrade their script to more recent and readable
>> style for eventual removal of the original syntax.
>> 
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>> 
>>     And this is the first step of such a deprecation.  Perhaps we start
>>     warning in 1.7.0 and remove it in 1.8.0, or something like that.
>
> If this is going to be removed in the future, then it is already 
> deprecated.  Therefore it is much better to start warning now and not 
> wait for 1.7.0.  There is just no point delaying the advice.

Very true.

What I am not absolutely sure about is if the presense of the support for
ancient usage hurts people in real life so much that it is better to
remove it than keep it.  At least we saw one example of a user (who is not
a novice) getting puzzled by it, but that may not be enough datapoint to
decide with.
