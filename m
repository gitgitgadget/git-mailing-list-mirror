From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2013, #07; Tue, 26)
Date: Thu, 28 Mar 2013 14:40:46 -0700
Message-ID: <7vobe3ryn5.fsf@alter.siamese.dyndns.org>
References: <7v620dss3j.fsf@alter.siamese.dyndns.org>
 <20130327203535.GA5220@sigill.intra.peff.net>
 <878v58worp.fsf@linux-k42r.v.cablecom.net>
 <7vy5d8jz0y.fsf@alter.siamese.dyndns.org>
 <20130327220723.GR2286@serenity.lan>
 <7vobe4jxpr.fsf@alter.siamese.dyndns.org>
 <20130327225215.GS2286@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>,
	git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Matthew Blissett <matt@blissett.me.uk>,
	David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Mar 28 22:41:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULKZW-0002eH-Ic
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 22:41:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754243Ab3C1Vkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 17:40:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62271 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754225Ab3C1Vkt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 17:40:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB83BEE25;
	Thu, 28 Mar 2013 21:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F/5E6A06732DAAQj8l641Bcnnz8=; b=eJG3z+
	gV9a6FmUgJVVsL/cKZHK0P9EhGoyKxFXKu0ExjY9Un3r5MKtiL/X8k5JRM2yivLY
	3dOEe4xlN4rMjMcmXWTD47zKCuZwp82Vw8tETEXkr124LcibBkfp8THL096M9w70
	QHqdKOgRu0BEo2OpCVZpbtsn7t1kdqcvzLlfc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RjaL4I1wzZqwogW/7Z1PrEFdKj8q+aeo
	po3kdy/+jJsZ3O0Vpgza7/L2hhJe+BLtKHDjrN7x+jMZkqexvEo4vZ2knM6gt/8u
	tLCSEeq0XAiregMrB8vuW0Lkc7e4O9WnU1JttwtA8v2RKCyQsmXCDPX4ciEje+wQ
	muiJn8WoLjU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC4BDEE24;
	Thu, 28 Mar 2013 21:40:48 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3A64AEE1E; Thu, 28 Mar 2013
 21:40:48 +0000 (UTC)
In-Reply-To: <20130327225215.GS2286@serenity.lan> (John Keeping's message of
 "Wed, 27 Mar 2013 22:52:15 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 276356B2-97F0-11E2-859B-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219461>

John Keeping <john@keeping.me.uk> writes:

> On Wed, Mar 27, 2013 at 03:15:44PM -0700, Junio C Hamano wrote:
>> John Keeping <john@keeping.me.uk> writes:
>> 
>> > On Wed, Mar 27, 2013 at 02:47:25PM -0700, Junio C Hamano wrote:
>> >> > * jk/difftool-dir-diff-edit-fix (2013-03-14) 3 commits
>> >> >   (merged to 'next' on 2013-03-19 at e68014a)
>> >> >  + difftool --dir-diff: symlink all files matching the working tree
>> >> >  + difftool: avoid double slashes in symlink targets
>> >> >  + git-difftool(1): fix formatting of --symlink description
>> >> 
>> >> I lost track of various discussions on "difftool" and its "symlink
>> >> so that the user can edit working tree files in the tool".
>> >
>> > Would it be easiest if I send a new series incorporating
>> > jk/difftool-dirr-diff-edit-fix and the proposed change to not overwrite
>> > modified working tree files, built on top of t7800-modernize?
>> 
>> I am somewhat reluctant to rewind a topic that has been cooking in
>> 'next' for over a week (the above says 19th).  Rebuilding the
>> style-fixes on top of the above is fine---that topic is much
>> younger.
>
> Sadly that's easier said than done, since it just introduces further
> conflicts as jk/difftool-dir-diff-edit-fix doesn't include
> da/difftool-fixes (now in master).

OK, let's make it simpler then by merging jk/difftool-dir-diff-edit-fix
to 'master'.  The test tweaks and other work can then built on top.
