From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] push: document --no-verify
Date: Wed, 22 May 2013 14:12:21 +0200
Message-ID: <878v378b8a.fsf@linux-k42r.v.cablecom.net>
References: <20130522104356.GA5472@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Wed May 22 14:12:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uf7u9-0007cX-8H
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 14:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755199Ab3EVMMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 08:12:25 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:58910 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754865Ab3EVMMY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 08:12:24 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 22 May
 2013 14:12:15 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS22.d.ethz.ch (172.31.51.112) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Wed, 22 May 2013 14:12:21 +0200
In-Reply-To: <20130522104356.GA5472@redhat.com> (Michael S. Tsirkin's message
	of "Wed, 22 May 2013 13:43:56 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225149>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> commit ec55559f937727bcb0fa8a3dfe6af68c188e968a added
> --no-verify flag to git push, but didn't document it.
> It's a useful flag when using pre-push hooks so
> add the documentation.
>
> Suggested-by: Thomas Rast <trast@inf.ethz.ch>
> Cc: Aaron Schrab <aaron@schrab.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
[...]
> +-n::
> +--no-verify::
> +	This option bypasses the pre-commit and commit-msg hooks.
> +	See also linkgit:githooks[5].
> +

Umm, half of that is not correct :-)

Push doesn't have the -n short form that git-commit does, and the hook
names are wrong.

I also ended up writing a patch myself; sorry for not telling you on
IRC:

  http://thread.gmane.org/gmane.comp.version-control.git/225141

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
