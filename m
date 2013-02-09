From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature request: Allow extracting revisions into directories
Date: Sat, 09 Feb 2013 15:00:28 -0800
Message-ID: <7vehgpum7n.fsf@alter.siamese.dyndns.org>
References: <1359901085.24730.11.camel@t520> <510E8F82.9050306@gmail.com>
 <1359915086.24730.19.camel@t520> <510F03FC.6080501@gmail.com>
 <CABURp0rMk-W8VMRhXoR9YYQSwjWTfPbXz5mhPX3-HKsBSu5_mw@mail.gmail.com>
 <1360425499.3369.10.camel@t520>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Phil Hord <phil.hord@gmail.com>
To: Robert Clausecker <fuzxxl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 00:00:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4JPh-0005RF-SE
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 00:00:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758543Ab3BIXAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 18:00:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41371 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758441Ab3BIXAa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 18:00:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B288C7FE;
	Sat,  9 Feb 2013 18:00:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yqcoPuaHWSnVz1IwUIkhqZS9U88=; b=MRnWt0
	Xc8F8DVqvPHlpY2F6p96puwQkuLJw1G+uzlPKM5DyZCiAEV/Bu6iyp0NgwSrENrA
	d+LVSan26uv2F2iajEiyUVyyRn5TAaFhsXrHgSX3f/y+4s0vOpn1CpCSYp+7Npag
	Pr8artRqQp061iiGeCAlaJi9Nb10k+OBHMKmU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LsQ+SqzCfF3aNZ5CgqFSAQMwlkF31iyQ
	FPfvCgEVOTIeDoIkyVpgVHHJHSgkjoh9fevGcsBVXWtWQlf+zJbUCOG+GZJiFtYa
	1jOq811p8oVzdnoe9jwgUrP43PAHoSXpEwe+EC0Zny1Cxk7u4T/K1TTtC8SQhw1r
	lvVTaiSipe4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D937C7FD;
	Sat,  9 Feb 2013 18:00:30 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A7550C7F9; Sat,  9 Feb 2013
 18:00:29 -0500 (EST)
In-Reply-To: <1360425499.3369.10.camel@t520> (Robert Clausecker's message of
 "Sat, 09 Feb 2013 16:58:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7FE323B6-730C-11E2-827B-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215880>

Robert Clausecker <fuzxxl@gmail.com> writes:

> After thinking a while about how to solve the problems I have, I
> consider the following things as a solution to my problem.
>
> Add an option --isolated, -i to git checkout: Check out a branch / tag /
> revision but do not touch the index. This could be used together with
> --work-tree to check out a branch into an arbitrary directory. Also, it
> satisfies all 4 criteria from [1] and therefore is perfect for
> deployment from a bare repository.
>
> What do you think about this feature request?

I am not Phil, but if you ask me, I think it is borderline between
"meh" and "no way we would give a short-and-sweet -i to something
like this".
