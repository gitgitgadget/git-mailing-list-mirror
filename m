From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git(1): remove a defunct link to "list of authors"
Date: Sun, 09 Dec 2012 22:31:46 -0800
Message-ID: <7vboe2ct9p.fsf@alter.siamese.dyndns.org>
References: <7vobi5hhn9.fsf@alter.siamese.dyndns.org>
 <7vk3sthhfy.fsf@alter.siamese.dyndns.org>
 <CACsJy8A7AYpZs7mTc+B-F7BBLPdACim=gHCg8sK1Aci8YSEB4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 07:32:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ThwuP-0000iV-N6
	for gcvg-git-2@plane.gmane.org; Mon, 10 Dec 2012 07:32:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116Ab2LJGbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2012 01:31:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56211 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751115Ab2LJGbw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2012 01:31:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 563FC6DAC;
	Mon, 10 Dec 2012 01:31:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VNLypWuqTHft+hsQv4mShqNB9oY=; b=g7Sd2/
	9Nor/dex9qZnNGXnDFW/5YRvmsY2qv9lZSQi3W+nD49aBBF8SCFKi8Z9krEP5mOe
	teBApgqjvCjakmQanqhPV9Jo9s8LkApF9Hf2VzElgaHUVbOv1uaLaA6j8hC9YHjz
	aGuz1nxPDYPeOBNO5U3up5N154TIrVMA1/fGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X3N15Wzx62u2OiXOh3Hi7gdmWq2JbFEw
	d0GBflheeWbohTEXd07tOclD6XpfgeHbupvqBp68NAGAqcQe7hD30hnAPBgH4q6a
	n7XuEoGB9bVAkmDVN1hoSB9zJSt6tbxETQuRCBD0Z6emIY0wAS0joMHzKxrzuNk6
	dN+OKPLxqF8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42D086DA2;
	Mon, 10 Dec 2012 01:31:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 20FC16DA0; Mon, 10 Dec 2012
 01:31:50 -0500 (EST)
In-Reply-To: <CACsJy8A7AYpZs7mTc+B-F7BBLPdACim=gHCg8sK1Aci8YSEB4Q@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sun, 9 Dec 2012 20:29:59 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4813E4F6-4293-11E2-B1BD-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211250>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Sat, Dec 8, 2012 at 12:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>  * If somebody has a working replacement URL, we could use that
>>>    instead, of course.  Takers?
>>
>> A possible alternative could be https://www.ohloh.net/p/git/contributors/summary
>
> Nice charts!

Yup.

Their numbers seem to be just 'any commit by the author, with
mailmap applied', and I am of two minds with it.  Counting without
"shortlog --no-merges", depending on the management style of the
project, tends to credit the integrator too much.  Even though
vetting the patches and choosing when to merge the topics is a
significant contribution, it isn't *that* big compared to the work
done by the contributor who took initiative to scratch that itch.

With or without "--no-merges", the big picture you can get out of
"git shortlog -s -n --since=1.year" does not change very much, but
the headline numbers give a wrong impression.

And of course, application of the mailmap is very important, if you
want to get meaningful numbers out of shortlog over a longer period.
