From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2014, #04; Wed, 26)
Date: Sun, 30 Nov 2014 18:09:31 -0800
Message-ID: <xmqqr3wkruhw.fsf@gitster.dls.corp.google.com>
References: <xmqqoarto8xy.fsf@gitster.dls.corp.google.com>
	<20141127183901.GD4744@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Dec 01 03:09:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvGQm-0005m2-7O
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 03:09:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204AbaLACJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2014 21:09:34 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53912 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752174AbaLACJe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 21:09:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 07662232BB;
	Sun, 30 Nov 2014 21:09:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9hGTOrsr6jJbxQp4rBubcYbLL6E=; b=GK1vQY
	8a2AQYs9eebCBKhY0ydiE8Y6QRiX/6CJtsPo/xEJgS+G153B3ZmjteSQ8blQyBQb
	zsoGDbZ2XFaBTcbPxrVOHmKfCeWfwf4M8tF9pyQNNOGa9Fgw4EwW0Iwf4VPqMdSM
	dR6ugT3W0VQluYVXYBTcKJufN172u5Ri0kLHE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H7IY8UtbMDMgl5khjH4BHW8GNh2Nt408
	Ks8mQVt4rAC66RKYAK2+mM0o2fOUpX+gj588H/L060EAdThEl8RalI8UbyvIcy8/
	rHUhRykS+/TT4lFJaqUcMp28I/QBi31lLbOU4HuzW5i8IpzOjuIQK856Jr7PAfUf
	sXGMLjmwWUM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F1F8D232BA;
	Sun, 30 Nov 2014 21:09:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 77E93232B9;
	Sun, 30 Nov 2014 21:09:32 -0500 (EST)
In-Reply-To: <20141127183901.GD4744@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 27 Nov 2014 18:39:01 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 16F34EDA-78FF-11E4-B307-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260459>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Wed, Nov 26, 2014 at 03:09:45PM -0800, Junio C Hamano wrote:
>> * nd/untracked-cache (2014-10-27) 19 commits
>> ...
>>  - dir.c: optionally compute sha-1 of a .gitignore file
>
> You didn't comment on the status of this branch, and I'm interested.

I think we already saw a few comments responded by the author with
"thanks, will include in a reroll", and that is why the listed are
not even the latest round.

The status was "waiting for a reroll".  I haven't caught up with the
traffic for the past few days, though.
