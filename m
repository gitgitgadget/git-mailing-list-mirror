From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-multimail: update to version 1.0.0
Date: Wed, 09 Apr 2014 09:35:40 -0700
Message-ID: <xmqqwqey1mw3.fsf@gitster.dls.corp.google.com>
References: <1396884040-26014-1-git-send-email-mhagger@alum.mit.edu>
	<xmqqd2gtm0id.fsf@gitster.dls.corp.google.com>
	<53456EC8.7090109@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Apr 09 18:35:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXvTa-0002T0-8l
	for gcvg-git-2@plane.gmane.org; Wed, 09 Apr 2014 18:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933751AbaDIQfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2014 12:35:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52845 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933100AbaDIQfp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2014 12:35:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F109079303;
	Wed,  9 Apr 2014 12:35:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SU3n/MHfnSflCQpjIa5SvEtv5B8=; b=sGuo3Y
	HYJ9RQMoYxZPbmIj1E/HiXJjTKP/ACRnxlUNaID4Xy9RrZi89hyksVkp75Ci089D
	KRB8+ppjVZ5yZejNtsj5EC650dFL9k0YqU5AlUxWb7cLgCdnW5PFYWAoHnL9XyNK
	vSMzqq9TrjkYlRfEo4lq3NKwWEc1WS6d5ZUfA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KsL/31Dq1QiQj4Lh7RfQJqwGfYtdk1Ne
	mWX4uWAi0Qqzpy8jryMe4yJmcJZNxfgngoBZYhlw58gm/o+05+mYdkgopMPqCbv8
	zOjK9Ar9qt17E5OoM95Cd1gfBSEIdk2m58QdmmlTnOWTTOplhWdPdg7R5PxvF/3F
	ysRXvfk9Elk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E079079302;
	Wed,  9 Apr 2014 12:35:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8AF5979301;
	Wed,  9 Apr 2014 12:35:43 -0400 (EDT)
In-Reply-To: <53456EC8.7090109@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 09 Apr 2014 18:01:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FEA400DA-C004-11E3-89C3-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245978>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>> In the longer term, I have a feeling that we may be better off to
>> make the "git core" tree not be the "batteris included" convenience
>> tree, though....
> ...
> Tell me if/when you want to transition to omitting git-multimail (and
> presumably post-receive-email and maybe others) from the Git source
> tree.  I suppose in that case we would replace the scripts with pointers
> to where they can be obtained.

Yes, that would be a longer-term thing, not related to this "one
round of periodical updates" patch.  I do not have any specific
timeframe in mind at this moment.
