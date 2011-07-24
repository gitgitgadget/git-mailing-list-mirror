From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/18] advice: Introduce error_resolve_conflict
Date: Sun, 24 Jul 2011 11:15:17 -0700
Message-ID: <7vaac3wnnu.fsf@alter.siamese.dyndns.org>
References: <1311095876-3098-1-git-send-email-artagnon@gmail.com>
 <1311095876-3098-2-git-send-email-artagnon@gmail.com>
 <4E284750.4040104@cisco.com> <20110722223555.GB19620@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <hordp@cisco.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 24 20:15:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ql3D4-0000T4-Gl
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 20:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243Ab1GXSPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 14:15:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61400 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752202Ab1GXSPU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 14:15:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74AF13488;
	Sun, 24 Jul 2011 14:15:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9MB8puu4AscbpCh3DoPe002oAsg=; b=CfJcYh
	NS9Z4ellZ16cgYvF37ipLKL8dezyFe65oHwj+hDDtp3xUm0JJqrelzVlgg4UXvAC
	Us0Xae7br2Cmlnm7mEhnGE4FwWRdnZh+XMRB3Aan/IpykTz9VZzjkf15patn1e1e
	/mvn4CxEYKj+FsW1I7SFiBpA0IVc7p3CCI0uk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ryW6ZF7HgPpKV0oHcp+2y41pDbTRlsYH
	XEYobsnXyPh3As6lKqxABdHBc3us/gfLBxtJo+y3Yw13zNO9Temr8O262POFwv9t
	JYC/B7uwqi032nC7w0z2Ymo+JEIeu2JY9YKYO7N+bDWVVtJ3s4pXsdBnHAA0LVMQ
	L9+Q6mx6U7Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BF4E3487;
	Sun, 24 Jul 2011 14:15:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D9B3F3486; Sun, 24 Jul 2011
 14:15:18 -0400 (EDT)
In-Reply-To: <20110722223555.GB19620@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 22 Jul 2011 16:35:57 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E34E3C2E-B620-11E0-A5B8-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177767>

Jeff King <peff@peff.net> writes:

> Still, I think I find it more readable without the comma, and better
> still if every spot were converted to "hint: ". This question has come
> up once or twice before, too, so I don't know that a patch removing the
> commas would be out of line.

Good to see that native speakers seem to think the comma there is funny.

I recall I've complained to one patch that added "Please, ", suggested to
remove that whole "Please, " thing, got ignored, but chose not to press it
further.

Thanks.
