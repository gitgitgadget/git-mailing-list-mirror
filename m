From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Support builds when sys/param.h is missing
Date: Sat, 15 Dec 2012 09:53:42 -0800
Message-ID: <7va9tfurq1.fsf@alter.siamese.dyndns.org>
References: <CAEvUa7mHHy1=aOMfg4hNnDzod4zSnNHZN87isgf6Yxh5cRAf0Q@mail.gmail.com>
 <7vpq2curpa.fsf@alter.siamese.dyndns.org>
 <CAEvUa7kZE-p0oVV+JpXY4y-=ieB-=THTrO4hxzZsFYhLvgvbFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: David Michael <fedora.dm0@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 18:54:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjvwC-0007Ew-6U
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 18:54:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430Ab2LORxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 12:53:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47786 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795Ab2LORxr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 12:53:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBF2B9D26;
	Sat, 15 Dec 2012 12:53:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qa+Sq2W/kgRNS7fb4Ue2QJwaIvM=; b=S3AoGp
	nIvfX6HTlJ7gIKxDpOxTu74R/gy3ZKn0+S8/GkmGDFv0oXTBiX2ITWbXwsd9lswZ
	l/oDBfSkL/8E+/PE9XGQYEP/G1mhtINRDi+ANarseeTuEoJFI1VEqAgoHJeCXesE
	xhGVH4jY58KyiKUpZ9dnyV7j1SALgcE7IzV4A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KFdmDt4vQ6OppenP5s1EaXIQtAz8D4dX
	lLGVkJmwbcft2D0y2UJm4IxwUhl5zrKb1nCR6QZGlo7d6Sp9b8GRHFynV8e0SeaO
	JP1Ocbu2KI1RDkNWq2py1UU/WJqxm8crivQ4W7yIkzoGH4DI5/NNZ+5HfqmBSWgU
	bXzizCPkCwc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A8E389D24;
	Sat, 15 Dec 2012 12:53:46 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 22EAB9D20; Sat, 15 Dec 2012
 12:53:44 -0500 (EST)
In-Reply-To: <CAEvUa7kZE-p0oVV+JpXY4y-=ieB-=THTrO4hxzZsFYhLvgvbFw@mail.gmail.com> (David
 Michael's message of "Fri, 14 Dec 2012 21:46:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5E32279C-46E0-11E2-9122-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211540>

David Michael <fedora.dm0@gmail.com> writes:

> On Fri, Dec 14, 2012 at 6:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> I have this suspicion that nobody would notice if we simply stopped
>> including the header.
>
> While I'm not aware of any subtleties it could be causing on other
> platforms, it does seem fine to drop sys/param.h on my test GNU/Linux
> systems.
>
> I can resend the series and just remove the include, if preferred.

I am sure the patch as posted is much safer, but I was hoping that
folks on non-Linux platforms may say "I tried to compile with the
include removed, and I get identical binaries from before".  Until
that happens, I would prefer queuing your patch as-is.

Thanks.
