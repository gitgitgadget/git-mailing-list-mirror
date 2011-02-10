From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase: use @{upstream} if no upstream specified
Date: Wed, 09 Feb 2011 18:25:37 -0800
Message-ID: <7voc6k62xq.fsf@alter.siamese.dyndns.org>
References: <1297125475-19151-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297302842-11296-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Yann Dirson <ydirson@altern.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 10 03:26:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnMEK-0006U1-7s
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 03:26:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754245Ab1BJCZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 21:25:53 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34842 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892Ab1BJCZw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 21:25:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8BBFC4187;
	Wed,  9 Feb 2011 21:26:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p7sTtCSSolhRhb+uKpsRg7YgC2k=; b=mfvXLS
	CBo3y1RrOTK5cEWWNKYmFCJ60wYteimRZw40CmTP9zvtepG25afM0JObOuXZMpqf
	H9moS2Y0qcFSBTwrforo0pRKhvJhQ3JApY94RmeLnkun36MBKWsVsjNKauOF0Tno
	dlE7SspKQSmBCzuMWdD+wNEq+6SkqQD8nV07o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MXvQY3dilt/5czM3F7NmCEFq3pGj/+Pp
	yMBlpz147wNQYL/0k7PI4kimfOKhbB+49yEGb9w3diIewH1XKEeTXoRpcI3ybsfm
	dBt5v5Lfh5j+x7XA4QvrA9VYBH8U5EzZ9lIyGNX2p3dn+YQD1ROO/X/Qhoclpa7r
	MaUoga944CE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 39B01416C;
	Wed,  9 Feb 2011 21:26:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BF694416B; Wed,  9 Feb 2011
 21:26:39 -0500 (EST)
In-Reply-To: <1297302842-11296-1-git-send-email-martin.von.zweigbergk@gmail.com> (Martin
 von Zweigbergk's message of "Wed\,  9 Feb 2011 20\:54\:02 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 34E4A20C-34BD-11E0-A9CD-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166465>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> 'git rebase' without arguments is currently not supported. Make it
> default to 'git rebase @{upstream}'. That is also what 'git pull
> [--rebase]' defaults to, so it only makes sense that 'git rebase'
> defaults to the same thing.

Not that I am fundamentally opposed to the proposed change, but the above is
not a very convincing argument, when the corresponding change to "git merge"
is just started getting discussed.

On top of what commit does this patch apply, by the way?
