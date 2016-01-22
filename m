From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2016, #04; Wed, 20)
Date: Fri, 22 Jan 2016 09:57:18 -0800
Message-ID: <xmqqtwm5v6o1.fsf@gitster.mtv.corp.google.com>
References: <xmqqk2n33jxq.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1601221757290.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 22 18:57:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMfxe-0005UO-HR
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 18:57:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754530AbcAVR5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 12:57:23 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55076 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754320AbcAVR5V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 12:57:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A37423E576;
	Fri, 22 Jan 2016 12:57:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bKaG5iDP36fr5Np4/Ov1FbUYIdQ=; b=I2jHWq
	J5bODtbwLSQKnBAQcojvH16vvouYj3n1vJjUc2kbvaJtreL7tSFC1YBD/8qbGF/x
	8gOmajN+h9hlMGmmKfSyYHusCHLRGDvDti20LX8l9I5kcuNcuG68maEaKP7qDYAS
	+kjS2BrV3nXe+vInmFtsoc98LtEZ9eHnPkSXM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M10C0eenQKUry6NJUXRLxK/oSm7fr0BX
	ZbW9A+ryYO34B/+LHdUT9i8VgyKhW0rPQmA3I7oSyKCFVjat25gW+k6hlprnQgCY
	TmM1cfscRCx1HRQdMHx0mWhFGuO7J60sZBwvOvae2ExytOMRMAKZsG5he0+19LOc
	o0XR+qqFJWo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9A6AD3E575;
	Fri, 22 Jan 2016 12:57:20 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CEF4F3E572;
	Fri, 22 Jan 2016 12:57:19 -0500 (EST)
In-Reply-To: <alpine.DEB.2.20.1601221757290.2964@virtualbox> (Johannes
	Schindelin's message of "Fri, 22 Jan 2016 17:58:30 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 94CBB448-C131-11E5-BC99-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284573>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 20 Jan 2016, Junio C Hamano wrote:
>
>> * bb/merge-marker-crlf (2015-11-24) 1 commit
>>  - merge-file: consider core.crlf when writing merge markers
>> 
>>  Write out merge markers using system end-of-line convention.
>> 
>>  Waiting for a re-roll to handle gitattributes.
>>  ($gmane/281701)
>
> For the record, it is $gmane/281700.

Not quite; 281701 is a more correct reference than 281700 at two
counts.  One of them is not your fault, as I haven't explained what
these references _mean_.  These references are not about "Go there
to get the original e-mail of the patch."  And 281700 is wrong by
being off by 100, as the original patch is $gmane/281600, even if
these references meant what you thought they did ;-).

These are "Go there to learn more about the reason behind the
statement above."  I (or anybody) visits 281701 and sees an
unresolved comment in the discussion thread to realize that the
maintainer is doing the right thing by not moving the version that
is queued forward prematurely before issues are resolved.

> I will send out a replacement series shortly.

Thanks.
