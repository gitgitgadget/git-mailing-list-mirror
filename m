From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clarify: rebase abort leaves <branch> checked-out
Date: Sun, 13 Mar 2011 12:41:23 -0700
Message-ID: <7vtyf6hkpo.fsf@alter.siamese.dyndns.org>
References: <1300035258.5129.12.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	"Johannes E. Schindelin" <johannes.schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Sun Mar 13 20:41:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PyrAi-0002cW-9g
	for gcvg-git-2@lo.gmane.org; Sun, 13 Mar 2011 20:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755181Ab1CMTln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Mar 2011 15:41:43 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59317 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886Ab1CMTlm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Mar 2011 15:41:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0C5E43507;
	Sun, 13 Mar 2011 15:43:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iyICksj8cWj3vZPlBiXYb/InEK4=; b=GGng4t
	vR+ng+PMFYb3cbiMQbZlPFaTxg/ui4yiWKp8OlVkjtgFOxDb9VlrULk5d7/yayQw
	VzQTBd93q/c3LvqyTisu6VxsaeIsyuNbdNksaJ52cWbuprlOalAlhEzZ4dUcms+D
	pRwdyBgxdHtyJ5/dIVx4fkzMCslIyQN3v9F9c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pOYVs2zzKUKKTaLhoM7KeHWGwDsBEmyl
	S4Hbe0YML5c2pGWC8a9+/FD5Fqi14TX49/LOnUoVhJ57f+Zj72zTdelnhWfa0SHI
	US/fvmFjhPYRqLB4SofR34yfEEmASzdezfKkqSic1CeHj/tuhFqFaGy05gXIJiFS
	5AeeLRF9iEo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9E0C53504;
	Sun, 13 Mar 2011 15:43:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6260E3502; Sun, 13 Mar 2011
 15:42:58 -0400 (EDT)
In-Reply-To: <1300035258.5129.12.camel@drew-northup.unet.maine.edu> (Drew
 Northup's message of "Sun, 13 Mar 2011 12:54:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1E138DD0-4DAA-11E0-A226-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168977>

Drew Northup <drew.northup@maine.edu> writes:

> -The latter form is just a short-hand of `git checkout topic`
> -followed by `git rebase master`.
> +*NOTE:* The latter form is just a short-hand of `git checkout topic`
> +followed by `git rebase master`. If the rebase is aborted `topic` will 
> +remain the checked-out branch.

The behaviour is consistent between the case where "this on that" form
succeeds and it stops and gets aborted, and I think both are euqally
noteworthy.  So I'd suggest dropping "if aborted".
