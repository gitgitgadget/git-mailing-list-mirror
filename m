From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb(1) Fixed English issues
Date: Fri, 23 Mar 2012 11:19:48 -0700
Message-ID: <7vpqc3tc1n.fsf@alter.siamese.dyndns.org>
References: <0316A9BA-627B-4B43-8BF1-392DD7408146@bbn.com>
 <1332509111-sup-2763@pinkfloyd.chass.utoronto.ca>
 <53140318-34FA-4EF1-80F9-CFAD8828B3A1@bbn.com>
 <08B31D69-CE1F-4D27-8AE6-C1C0D76BEED5@spamcop.net>
 <878vircoby.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: D Waitzman <djw@spamcop.net>, git <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Mar 23 19:19:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB95h-00054B-8h
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 19:19:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759040Ab2CWSTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 14:19:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39167 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757869Ab2CWSTv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 14:19:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 848CD743F;
	Fri, 23 Mar 2012 14:19:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6NztqugnjOa8oSMsECdksvBbJt8=; b=UYO9B0
	d8m1cg7+aIpbAbZ6A5EIyb+CriJpRmf+eL/bEJcx3ii8bXAmk29UCfzl4cMAMJB3
	J/Zx0G++tccOx8p5vSFdEH8gXFnhnxS4OUNCQg5Rs7Qe6BhFjtBL9A3DILTLVypl
	RiB3/VPz6CwtiTfiWwrWmzCpkvcdGRTwvmFVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aiylzzydJ+krltZjqEGEAI/bwgcvWIm5
	mFaUq28PdMq3MHX4RODT9TLcpCyvwGAYhWKBbLAE86sMxER/5dzWyb8posYRtgz7
	EQls0bjvLqiTOL7v1Rtba9O4uIvifaJC7ilmeJe16RgJTaxDQ+SMYhUaEmExlv9F
	oboSnJBVZbU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BB08743D;
	Fri, 23 Mar 2012 14:19:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 02231743C; Fri, 23 Mar 2012
 14:19:49 -0400 (EDT)
In-Reply-To: <878vircoby.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Fri, 23 Mar 2012 16:46:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C73BB616-7514-11E1-97F4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193785>

Thomas Rast <trast@student.ethz.ch> writes:

> Note that the correct way to put commentary in the patch mail that does
> not go into the commit message is putting it after the --- marker.
> Also, we write commit messages in the imperative.  The above should
> probably look roughly like
>
>   Subject: Documentation/gitweb: trivial English fixes
>
>   Change "it's" to "its" where a possessive is intended.
>
>   Also add two missing "the" that were noticed by Ben Walton
>   <bwalton@artsci.utoronto.ca>.
>
>   Signed-off-by: David Waitzman <djw@bbn.com>
>   ---
>   This is a trivial patch to correct the english in the man page.  Ben
>   Walton suggested an additional english fix which I have added and
>   squashed with my change.  And then I added it again when he pointed
>   out I missed something in his original email.
>
>    Documentation/gitweb.txt |    4 ++--
>    1 file changed, 2 insertions(+), 2 deletions(-)
>
>   diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
>   index 605a085..168e8bf 100644
>
> Note that I added "Subject:" here to make it an inline patch (though you
> obviously need to remove my extra formatting indent).  If there's no
> Subject pseudoheader, the patch gets the subject of your email, and
> similarly for From and author.

Thanks.  I'll use this with the patch text you are responding to.
