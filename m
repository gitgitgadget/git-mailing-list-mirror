From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 3/5] git-branch: introduce missing long forms for the
 options
Date: Fri, 26 Aug 2011 10:13:52 -0700
Message-ID: <7vk4a0drjj.fsf@alter.siamese.dyndns.org>
References: <20110825175301.GC519@sigill.intra.peff.net>
 <c79179fa3476629ce47556c219719495c213f5f9.1314367414.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Aug 26 19:14:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwzyi-0000Mo-GI
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 19:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754014Ab1HZRN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 13:13:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61788 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753301Ab1HZRNz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 13:13:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD963411E;
	Fri, 26 Aug 2011 13:13:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yMSi4yCnf2SmtOZmMprLkp34y+o=; b=S0lq9D
	4WgA1SlRInSt5H4SEY1izBE/MOrek9DROegh9qVSdBrEq7yG3L6ARz68FIMr4PlO
	WznITjfdrMBdZakiQ3KZAV+EBaugvz9B3sP4VUXTk7OpvKehDpA+g0WNJ7LpP0LB
	jpFN4qAW8kaZEjzA8IjddqKaq26sK0UqtrRFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dSlpkT39kQeuIcwM85hZSr9VkGRdOyDZ
	Rko/lJ9s3+4UMjSlOzMFOhHZkY6Kq43SNm6+C5K5owsyVplXODm0JLDE5G0sdK7N
	r+l3Z7GRXkQv2Cmqxgc0PhJ6OQlCzZmWDkfu7IS9CfMax4HxM8lG1q3oycNB4yCt
	+14eHy9UVSo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3177411D;
	Fri, 26 Aug 2011 13:13:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 43B15411B; Fri, 26 Aug 2011
 13:13:54 -0400 (EDT)
In-Reply-To: <c79179fa3476629ce47556c219719495c213f5f9.1314367414.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Fri, 26 Aug 2011 16:05:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C6AF52CE-D006-11E0-A685-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180182>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> @@ -100,9 +103,11 @@ OPTIONS
>  	Same as `--color=never`.
>  
>  -r::
> +--remotes::
>  	List or delete (if used with -d) the remote-tracking branches.

I am not sure if this should be "--remoteS".
