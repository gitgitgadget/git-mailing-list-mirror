From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Unable to fork off sideband demultiplexer
Date: Wed, 01 Jun 2011 10:15:54 -0700
Message-ID: <7vk4d5h3qt.fsf@alter.siamese.dyndns.org>
References: <loom.20110601T161508-689@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Randy Brandenburg <randy.brandenburg@woh.rr.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 19:16:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRp1d-0000xs-4n
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 19:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759239Ab1FARQD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 13:16:03 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63334 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758894Ab1FARQB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 13:16:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E5D6441C2;
	Wed,  1 Jun 2011 13:18:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2giKK8SIyDNTSR75UzXOFsGyPWw=; b=J6togW
	45+Fe++S3Ot6Fn9Ob8viOy+n9srfMTWHSD4YJE4Snzt1pW8tczgrP0/hmldBzXcg
	agIra/OdgmsyAPIqaaQYuhj+asVOG1igS3Frkn4CW5BzAYjrQ/B63b5jLv2EblBk
	NnV/yz0XBbkmJfl3wELtdsGUKa76ZxWRwFJos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dMss2ao6thlduJRHhS8poeRYsWmdL4Dr
	bzaD8jvOb6U3Xn5VRiJPPimdXHe2Zd7XuLwClf5TedBzk2vqFcud3Keqn/SpiQ9t
	mH2OUt/UexEhOzso4xrYllI9MxRP+o9W78Yo2X4zIAyV3HmYFlhcdLJ5Z0B2gSBJ
	98CJ+cu1ZS0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C3D4141C1;
	Wed,  1 Jun 2011 13:18:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E531D41C0; Wed,  1 Jun 2011
 13:18:04 -0400 (EDT)
In-Reply-To: <loom.20110601T161508-689@post.gmane.org> (Randy Brandenburg's
 message of "Wed, 1 Jun 2011 14:16:32 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1E3889A2-8C73-11E0-A49B-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174884>

Randy Brandenburg <randy.brandenburg@woh.rr.com> writes:

> # git push
> error: cannot create thread: Unknown error 

Perhaps threading library does not really work on your platform? Does
rebuilding git with "make NO_PTHREADS=YesPlease" help?
