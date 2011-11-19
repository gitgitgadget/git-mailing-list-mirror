From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Stack overflow at write_one()
Date: Sat, 19 Nov 2011 13:08:08 -0800
Message-ID: <7vty5zizwn.fsf@alter.siamese.dyndns.org>
References: <4EC81131.2010704@cesarb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Cesar Eduardo Barros <cesarb@cesarb.net>
X-From: git-owner@vger.kernel.org Sat Nov 19 22:08:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRs92-0004A8-9i
	for gcvg-git-2@lo.gmane.org; Sat, 19 Nov 2011 22:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753461Ab1KSVIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Nov 2011 16:08:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53189 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752402Ab1KSVIL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2011 16:08:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23C5D648C;
	Sat, 19 Nov 2011 16:08:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8/uWCx1Pq3rNIv7idocw6e5rFl0=; b=b9IUWG
	hE9GlzNecL9j4WRvk8EGtodGrFUSI2+0F1x3ax+bDz0FAiK0IGzI8Eev2pd7VjmB
	mR+vXttjPxEMRIDloI04edLLTtnrYuhVleprREngDJVjBF8AQetziNOxpEBJYtyK
	DertHE037SpnunRzUG0hZs4k+19nFKo9+n9YE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uFFQa4WF7obzWnw7Q1Y7ohJOwHxUmsW5
	Ssyh9NyCh9p/bXaVVJcXOLiuahUhGq19Z7xVpkFoKL9NSXB0r7uO46R0JqfnQwZ8
	nNJ/Plk3PRplIhy9iFe0sAOT09dX50CUGrn1xBJBsyWqCBmlYWyCp4aw5cx4r/yC
	As2d54ga8RM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B193648B;
	Sat, 19 Nov 2011 16:08:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A627C648A; Sat, 19 Nov 2011
 16:08:09 -0500 (EST)
In-Reply-To: <4EC81131.2010704@cesarb.net> (Cesar Eduardo Barros's message of
 "Sat, 19 Nov 2011 18:27:29 -0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9578788C-12F2-11E1-A79C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185710>

Already found the real cause (jGit bug) and workaround posted, I think.

See $gmane/185573
