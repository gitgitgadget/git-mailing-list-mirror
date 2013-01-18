From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: teach find-rev to find near matches
Date: Fri, 18 Jan 2013 15:14:56 -0800
Message-ID: <7va9s6ozgv.fsf@alter.siamese.dyndns.org>
References: <20130117221933.GK4574@serenity.lan>
 <20130118004917.GA27106@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Jan 19 00:15:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwL9b-000897-St
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 00:15:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755504Ab3ARXPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 18:15:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34127 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754104Ab3ARXO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 18:14:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EC93A1E4;
	Fri, 18 Jan 2013 18:14:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7WktTOGpRUyOaZ1Y/s7XzVzOsug=; b=llLVY/
	S6avijSGDeUnoL13kbqFX9iuzgep4sY/enH3BSmhFvLMaMMsCM/eXksF8FswxKXW
	gId1Dl0Gt6R8GuY+8v/oJrqy/+IRctst23Gyw1KwPmVKdSSHvBAKmNk3l6zlh2ul
	nE86v3Acq+t5vsDgxFYoFBuO8nZAnf3xzDlMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yoxi0B2/AaqUHbAz1nsioCnLrfqxky2C
	SUXs685/ptGIFdaytXmYeS+wkrojRZDmUqRBP7Z8rT40ClrBzzDXMWb3c/Zn5iBl
	Tk8SOAHA7z0aSMAiWHQqKFDVluPBZzqDeBVCZwErsYixSLZI2g5fowpInF9FjIt8
	0TrG2CgtAuE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34C87A1E3;
	Fri, 18 Jan 2013 18:14:58 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A5815A1E0; Fri, 18 Jan 2013
 18:14:57 -0500 (EST)
In-Reply-To: <20130118004917.GA27106@dcvr.yhbt.net> (Eric Wong's message of
 "Fri, 18 Jan 2013 00:49:17 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E029AF14-61C4-11E2-8301-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213950>

Eric Wong <normalperson@yhbt.net> writes:

> I've pushed this out to git://bogomips.org/git-svn along with a few
> other things I seem to have forgotten about :x
>
> John Keeping (1):
>       git-svn: teach find-rev to find near matches
>
> Jonathan Nieder (2):
>       Git::SVN::Editor::T: pass $deletions to ->A and ->D
>       git svn: do not overescape URLs (fallback case)

Thanks; pulled and pushed out.
