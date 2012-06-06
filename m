From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add the DEFAULT_HELP_FORMAT option to Makefile
Date: Wed, 06 Jun 2012 14:07:03 -0700
Message-ID: <7vk3zkkv48.fsf@alter.siamese.dyndns.org>
References: <20120606135353.GD2597@sigill.intra.peff.net>
 <1339008702-704-1-git-send-email-vfr@lyx.org>
 <7vzk8gl0p0.fsf@alter.siamese.dyndns.org> <4FCFBC9C.6010501@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Wed Jun 06 23:07:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScNRh-00077T-Ks
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 23:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756852Ab2FFVHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 17:07:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49209 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754020Ab2FFVHH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 17:07:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BB0D85BD;
	Wed,  6 Jun 2012 17:07:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j5ITh0ibJy3eex/o07wjQn8mOZ8=; b=s59Kxu
	AmwY6lBihoFf7pCt2JPWeTBdCYb/YdHvyvXw+wUyl5P04MeLpJESmobM9iGjjqSb
	7fKu0kKKllzAl9FXwz53Ub/if0baB3SikVMZ/TEYLuK/hnW3MluITWf8AUknGQiL
	+Qw6LD4Xda7fzcJs4GgSQSngx3819Y6yVywQE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fyro02iMZk5b8s4ig3GehKVCDUzzuVWM
	MxVHXSkwZWHWjHyaEF7hFTTuBI8jNwaqLQaLBoagLi1mOydbBiVwZDiNqzRoMwQe
	U+gwac8Iu4ZtteRFpjYmPvErmbQtVFHjdB3gIYzONXO239aSwOgKgQrWcfLL+BfW
	PU2DnLAXaE8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5351E85BC;
	Wed,  6 Jun 2012 17:07:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DDD4D85BB; Wed,  6 Jun 2012
 17:07:04 -0400 (EDT)
In-Reply-To: <4FCFBC9C.6010501@lyx.org> (Vincent van Ravesteijn's message of
 "Wed, 06 Jun 2012 22:25:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 917B047C-B01B-11E1-89BB-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199355>

Vincent van Ravesteijn <vfr@lyx.org> writes:

> Op 6-6-2012 21:06, Junio C Hamano schreef:
>> I think the choices of PAGER and EDITOR share the same problem, but
>> shouldn't this choice recorded in GIT-BUILD-OPTIONS in some way?
>
> I don't know. The only place I know where GIT-BUILD-OPTIONS  is used
> is in the test suite. The test suite runs fine with the patches.

Actually what I had in mind was GIT-CFLAGS which makes sure that we
rebuild things when compilation options change, but ALL_CFLAGS is
covered already so there is no problem.

Thanks for a sanity check.
