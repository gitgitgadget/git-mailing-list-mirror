From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Two janitorial patches for builtin/blame.c
Date: Tue, 21 Jan 2014 12:20:37 -0800
Message-ID: <xmqqa9epulwq.fsf@gitster.dls.corp.google.com>
References: <1390157870-29795-1-git-send-email-dak@gnu.org>
	<87d2jlqp7x.fsf@fencepost.gnu.org> <20140121165546.GE18964@google.com>
	<874n4xqlly.fsf@fencepost.gnu.org> <20140121174448.GG18964@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 21 21:20:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5hoU-0002yw-KZ
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 21:20:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbaAUUUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 15:20:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54442 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191AbaAUUUl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 15:20:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A68F63942;
	Tue, 21 Jan 2014 15:20:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tGQH1Rg/BH/YXkGse9w4+cwG2Vo=; b=kcescZ
	6Gq5CQlrwm6IUFBjuR6I6U5zcHXiH2q2cZ+zl5RSRXQvL6SKEeER/yWNGP4cXrK+
	1gnwfek3B/f60xQxlXz9Wk+PUwH2B9PZMlS/MbRSQLBvg+sHUkYVVu09Ziq96eY4
	Z7cXUFcvffhR/sJGLv5dhOac3B75r3Eqttqus=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KMQvKV30SRZoCHVRN/BVsmDoFkrecLA5
	k9p4qdmlCCz8M/TmdaSj0FSCBXkZfKtyoZKkFvDMNDiAsaBjxwzU3cyu4Ao1vFTK
	CpNq/hZrXhCwsl4iNxEMjnbIREzUV+eMygbn55Nl6GTW/wcgmuL/d7X0klGnX9g5
	zSxIleOm/t8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2381C63941;
	Tue, 21 Jan 2014 15:20:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1DE6E6393D;
	Tue, 21 Jan 2014 15:20:39 -0500 (EST)
In-Reply-To: <20140121174448.GG18964@google.com> (Jonathan Nieder's message of
	"Tue, 21 Jan 2014 09:44:48 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7EFDBAD2-82D9-11E3-BB69-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240772>

Jonathan Nieder <jrnieder@gmail.com> writes:

> David Kastrup wrote:
>
>> So my understanding is that when we are talking about _significant_
>> additions to builtin/blame.c (the current patches don't qualify as such
>> really) that
>>
>> a) builtin/blame.c is licensed under GPLv2
>> b) significant contributions to it will not be relicensed under
>> different licenses without the respective contributors' explicit
>> consent.
>
> Yep, that's how it works.
>
> [...]
>> The combination of the SubmittingPatches text with the file notices in
>> builtin/blame.c is not really painting a full picture of the situation.
>
> Any idea how this could be made more clear?  E.g., maybe we should
> bite the bullet and add a line to all source files that don't already
> state a license:
>
> 	/*
> 	 * License: GPLv2.  See COPYING for details.
> 	 */

I vaguely recall that jgit folks at one point wanted to lift this
implementation and were interested in seeing it to be dual licensed
to BSD but that was a long time ago.

  http://git.661346.n2.nabble.com/JGIT-Blame-functionality-for-jgit-td2142726.html
