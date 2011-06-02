From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] gitweb: Move information about installation from
 README to INSTALL
Date: Thu, 02 Jun 2011 11:20:33 -0700
Message-ID: <7vtyc8ccy6.fsf@alter.siamese.dyndns.org>
References: <1307026553-1181-1-git-send-email-jnareb@gmail.com>
 <1307026553-1181-2-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Drew Northup <drew.northup@maine.edu>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 20:20:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSCVn-0007JC-DP
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 20:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754359Ab1FBSUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 14:20:45 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47267 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754304Ab1FBSUn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 14:20:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 460F34440;
	Thu,  2 Jun 2011 14:22:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DXfM1bRcyi0dm1/8BYJEUWKku2k=; b=OL3l9V
	o+aqxn25/Mh1YQfdkbpKMvV6psbtVz1F17MRnqZndRHmQ1kSK+38hHBTaD/Q6raD
	0nHljD8BW08Lm/xO54Fv3desIR/QVvtVAvNBO3bhMBgTOSk40PL0XZM6vdkcjBte
	XqEHiiHccJVs2DXWxitRseN5y3I9gy4fVfkk8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KjgsDHgkmxa5fh+bJO1LVni/UYIyQiM9
	dck5y1cQ3Qa16tYHF687RK8aYPPC+XN30YQUz6J6dJmNC34hYDKrFpvg+BbJNAn/
	PvnRdJMqJ9y6Z2trpl3cD+eNE+13yJqmYd81FgrLESmPuF+CkGRld/XcgtMC9+Mk
	pMxa5HHFY/U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 104EE443F;
	Thu,  2 Jun 2011 14:22:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C3558443A; Thu,  2 Jun 2011
 14:22:43 -0400 (EDT)
In-Reply-To: <1307026553-1181-2-git-send-email-jnareb@gmail.com> (Jakub
 Narebski's message of "Thu, 2 Jun 2011 16:55:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 51725492-8D45-11E0-B0B7-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174966>

Jakub Narebski <jnareb@gmail.com> writes:

> Almost straightformard moving of "How to configure gitweb for your
> local system" section from gitweb/README to gitweb/INSTALL, as it is
> about build time configuration.  Updated references to it.
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
>  gitweb/INSTALL |  115 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  gitweb/README  |  114 -------------------------------------------------------
>  2 files changed, 113 insertions(+), 116 deletions(-)

Looks good.  Thanks.

"git blame" tip of the day. After applying a series like this on a topic
branch, running

 $ git blame -C master.. -- gitweb/INSTALL | grep -C 3 -e '^[^^]' | less -S

lets us view the lines without drowning in the bulk of lines that were
merely moved.
