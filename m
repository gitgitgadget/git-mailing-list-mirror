From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Oct 2009, #03; Mon, 19)
Date: Mon, 19 Oct 2009 11:58:45 -0700
Message-ID: <7veioz1a8q.fsf@alter.siamese.dyndns.org>
References: <7vhbtv6c76.fsf@alter.siamese.dyndns.org>
 <200910191125.19997.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Oct 19 20:59:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzxRi-0000jI-Im
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 20:59:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757028AbZJSS6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 14:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756920AbZJSS6v
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 14:58:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47950 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756481AbZJSS6u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 14:58:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 641917D089;
	Mon, 19 Oct 2009 14:58:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=RqiuSRab6w4yJ59b3ikt8qt47f4=; b=Ig3ytVSR3NGXH8/oiGhYJhw
	F0lBZMedO45bSgG8q7Ws5UWa+u8sl4Gk9bfymIl6ppidoixgAJHJG12f6JnEf3Jm
	9j5pndbo9LmhWWiFXGS9xf3VouVo1wYXETGHRbweGMVb5G/615l4W7si4WB9TwDO
	XdW4stCR//l22wc5cOTk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=IqiZix5GRb1+5PzMxTqWoT9oxARYOLUKEBVjM/rOdTvv16YTV
	4FE3zfCijFvwjYdQi/iwVG3sP97o9WDRs13P8qDZRtQDwlswfO+0mC6KeVx06NlY
	2Hvo8PjXBqLTkRtFfuINGPQCaqKBPwV8t9Il1M5beko9SwsdL9k+PEQG6Q=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3ABB47D087;
	Mon, 19 Oct 2009 14:58:51 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DA0017D081; Mon, 19 Oct 2009
 14:58:46 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 709DACE4-BCE1-11DE-9B82-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130726>

Johan Herland <johan@herland.net> writes:

> On Monday 19 October 2009, Junio C Hamano wrote:
>> * jh/notes (2009-10-09) 22 commits.
>>  - fast-import: Proper notes tree manipulation using the notes API
>>  ...
>>  - Introduce commit notes
>>  (this branch uses sr/gfi-options.)
>
> Nope. This branch does not use sr/gfi-options. The jh/cvs-helper branch
> does, though.

We should rebase jh/notes on top of v1.6.5 then.

What you are seeing is a mechanically generated mark that notes that the
branch is not forked directly on master but are forked from the commit on
the other branch.  The parent commit of "Introduce commit notes" is
91d578a (fast-import: test the new option command, 2009-09-06).

>> Is this good for 'next' now?
>
> Not all of it.
>
> I suspect the first 14 patches are stable and 'next'-worthy, although
> it would be nice if Dscho had the time to ACK them.
>
> The last patch (#22) needs some major rework based on Shawn's comments
> (I'm working on that, although I currently have less time than I hoped
> for), and that rework might ripple into patches #15 through #21.

Thanks for the status update.
