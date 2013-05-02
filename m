From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] Remove the CYGWIN_V15_WIN32API build variable
Date: Thu, 02 May 2013 13:41:45 -0700
Message-ID: <7vy5bxyv06.fsf@alter.siamese.dyndns.org>
References: <5182BD49.1070603@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>, mlevedahl@gmail.com,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu May 02 22:41:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UY0K9-0004Qw-OU
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 22:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932895Ab3EBUls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 16:41:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36191 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932843Ab3EBUls (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 16:41:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B19F1BA9E;
	Thu,  2 May 2013 20:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7tPX/aaXH2VxbAAp1v7w2Bm6HWM=; b=LGvR+w
	X54bSIV6JEsRctZ5hw3uBXVIsvoXG/v4XmgmfEcrn/f1XycDXj0TrJ4x8OOVpcG7
	SiIOUUw+K/z/NZxjp4P2Z5n5vwzfZNxr4KPwiciA3/r84ouXk43a4sZxiZIxxEmL
	o0575CmjwPbgutLtJQyk+bJDkda2Fn2tSRWJA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AOkBijBYDtBatwelE6M/LaDI9GFnuNIG
	+mEpIF0S1rnxZtEyfxM0v2L0Is3E185kXplj30y3LWkfSDf+EhR3Tdtfr5QYIxeI
	SXoqga6QmAHfXojFdX/Ejk/NBopJpFizVhpgg0Wa2FH5aMxIDy0u25IOGYD14YUf
	c/GuKy3zqzY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E8A21BA9D;
	Thu,  2 May 2013 20:41:47 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B591D1BA9C;
	Thu,  2 May 2013 20:41:46 +0000 (UTC)
In-Reply-To: <5182BD49.1070603@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Thu, 02 May 2013 20:23:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B4E6C4EA-B368-11E2-A889-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223263>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Version 2 changes:
>
>    - minor edit to commit message to Patch #1
>      (s.%s/NATIVE_WINDOWS/.%s/WINDOWS_NATIVE/.) ;-)
>
>    - add some additional explanation to commit message
>      of Patch #2.

Thanks.

> Note: Since I don't have a commit ID for the first patch,
> I didn't know how to refer to it in the second patch.

At least we know that it will be applied on top of the other one, so
what I usually do in such a case is to say "Now the previous one
fixed that glitch, we can do X, Y and Z to make the world a better
place on top of it."
