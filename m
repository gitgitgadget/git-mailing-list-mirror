From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git checkout error
Date: Tue, 09 Oct 2012 10:55:45 -0700
Message-ID: <7vzk3vfs2m.fsf@alter.siamese.dyndns.org>
References: <CAB9Jk9DUEL_J3MmH_4k7NC82m+crpCf1r3NS3gQBMZy+kvY3-A@mail.gmail.com>
 <m2lifg7zsj.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Angelo Borsotti <angelo.borsotti@gmail.com>,
	git <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Oct 09 19:56:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLe2G-000597-Mu
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 19:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756620Ab2JIRzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 13:55:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59152 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752609Ab2JIRzu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 13:55:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAE929504;
	Tue,  9 Oct 2012 13:55:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nCSuekMcaZXKcVGnZrIQAhimz6M=; b=Q4NRCd
	alud2tuZUi7EmbHR73S3481/aO2yLVq+teBQwr7XyOCeBYrdVA5gcVS0I+oQf1E7
	NrB4ALyTP5ik+2osx2iaAh0m33ED7MOfqEznwKcREiRzNDoCDxckPGA5+tfkZYXS
	GzwpTizvNQwVOlRlUVuj/QxoJKGVK2qEwz4zA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MFrA+ep1w69DVcp/CIvLO2xmKUkvI84a
	3E/qXSx1OUpKxJmeAOULUwt5odqsQiODJAu0I9CsoXLVsIdEZwTgx44Vj9Je00qq
	ebBRsH/5+cYYnbjL1kVF52sNAnlyxWVZZXeEIBy/GBJ5yHdShMTZpF0QSZmFYyFU
	4kp3+Ktn41w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D89F59503;
	Tue,  9 Oct 2012 13:55:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C38494FE; Tue,  9 Oct 2012
 13:55:47 -0400 (EDT)
In-Reply-To: <m2lifg7zsj.fsf@igel.home> (Andreas Schwab's message of "Tue, 09
 Oct 2012 11:36:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8DD13C7A-123A-11E2-9954-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207334>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Angelo Borsotti <angelo.borsotti@gmail.com> writes:
>
>> If they are specified after -b, the command seems to behave as if -b
>> was not specified, e.g.:
>>
>> $ git checkout -b --no-track topic remotes/origin/master
>
> -b requires an argument <new_branch>, which you specify as --no-track
> here.  <start_point> is topic, and the rest is interpreted as <paths>.
>
>> fatal: git checkout: updating paths is incompatible with switching branches.
>
> This error is detected before validating <new_branch>.
>
>> while if they are specified before -b the command behaves properly, e.g.
>>
>> $ git checkout --no-track -b topic remotes/origin/master
>> Switched to a new branch 'topic'
>
> You can also specify --no-track after -b (and its argument):
>
> $ git checkout -b topic --no-track remotes/origin/master

Isn't this "asked and answered" recently with this thread?

    http://thread.gmane.org/gmane.comp.version-control.git/204397
