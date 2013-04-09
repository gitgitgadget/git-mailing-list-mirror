From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/2] Using gitfile repository with clone --reference
Date: Tue, 09 Apr 2013 15:41:52 -0700
Message-ID: <7v8v4rpbrj.fsf@alter.siamese.dyndns.org>
References: <7v8v4rtzw4.fsf@alter.siamese.dyndns.org>
 <1365546120-22048-1-git-send-email-aaron@schrab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Aaron Schrab <aaron@schrab.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 00:42:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPhEl-000554-RP
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 00:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933480Ab3DIWlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 18:41:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44987 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752299Ab3DIWlz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 18:41:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AB9915D69;
	Tue,  9 Apr 2013 22:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a/E16BuxbD4pnZV6phfgcHjC7SY=; b=qlgbiq
	fRHGnd4tge/5czZ+rw6N/BlJgb1SXba65VnA0l2+rvgIc1DgBSOv40NcF8C8jt+l
	YXf3UovVK33TrPi46/C4XdxhljMQv5tUfCSrp7yCQpufm5DW/tOtucNyHfF+y+cY
	QHtvFPKgmIinkN83h6eo3Yv6XJBIF0FJ286IM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=apkm2jDevT+k9gYO0Q0KAO3YZfp1dV+6
	fNlcQSDwYt4mwV9KFGqCze8IZblW0HiwQewzmjWUyNDPRL/7O3uKSclEUCjuOCrW
	mrDtbbvru0uq3YychOU+qfp/7w0dn5kx46B/IrGLItp2dQ66BNkj87nIQ33h3Phz
	zsLLSGj+hmk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EE1015D67;
	Tue,  9 Apr 2013 22:41:54 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 979DE15D65; Tue,  9 Apr
 2013 22:41:53 +0000 (UTC)
In-Reply-To: <1365546120-22048-1-git-send-email-aaron@schrab.com> (Aaron
 Schrab's message of "Tue, 9 Apr 2013 18:21:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AD08D3EE-A166-11E2-8C31-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220648>

Aaron Schrab <aaron@schrab.com> writes:

> Here's the third version of my series for dealing with gitfiles in clone
> --reference.
>
> The first patch is unchanged from the previous version except for the
> addition of a Reviewed-by line.
>
> The second patch has been modified so that it now supports having a .git
> file supplied as the argument to the option directly rather than only
> dealing with that if the containing directory was supplied.  This makes
> the first patch from the series more important, since it would make even
> less sense to complain that the path isn't a directory when a
> non-directory is acceptable.
>
> I've also fixed the minor style issue in the test script from the previous
> versions.

Thanks, will queue.
