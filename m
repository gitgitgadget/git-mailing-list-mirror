From: Nanako Shiraishi <nanako3@bluebottle.com>
Subject: Re: [PATCH] autodetect core.symlinks in git-init
Date: Fri, 31 Aug 2007 17:00:37 +0900
Message-ID: <200708310800.l7V80k7L005962@mi1.bluebottle.com>
References: <7vodgo2moe.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Git mailing list <git@vger.kernel.org>,
	"Stephen Cuppett" <cuppett@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 10:00:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR1Qy-0005AQ-Sb
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 10:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754359AbXHaIAs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 04:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754311AbXHaIAs
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 04:00:48 -0400
Received: from mi1.bluebottle.com ([206.188.25.14]:47771 "EHLO
	mi1.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754065AbXHaIAr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 04:00:47 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi1.bluebottle.com (8.13.1/8.13.1) with ESMTP id l7V80k7L005962
	for <git@vger.kernel.org>; Fri, 31 Aug 2007 01:00:46 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:date:subject:in-reply-to:mime-version:
	content-type:content-transfer-encoding:x-trusted-delivery;
	b=FfqW5IC8DdGI06fC8nMLvnzc8WhzrMbk4t10qh4Oun6OP7RHljCkll7M4UvM3d0ka
	WD92aB40VdA6CbU/NFJ7RT0lGgETj58sQ2SBfhYY8kxCOs/MNznN+zglJxOuHrZ
Received: from nanako3.mail.bluebottle.com (88-199-30-2.tktelekom.pl [88.199.30.2])
	(authenticated bits=0)
	by fe0.bluebottle.com (8.13.1/8.13.1) with ESMTP id l7V80dTb008548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 31 Aug 2007 01:00:43 -0700
In-Reply-To: <7vodgo2moe.fsf_-_@gitster.siamese.dyndns.org>
X-Trusted-Delivery: <4c3ced7658fa7cc34ac35758ec82ee8c>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57127>

Quoting Junio C Hamano <gitster@pobox.com>:

> We already autodetect if filemode is reliable on the filesystem
> to deal with VFAT and friends.  Do the same for symbolic link
> support.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * The earlier one left the test symlink behind after testing is
>    complete.  Embarrassing...
>
>  builtin-init-db.c |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)

Thank you for a quick patch.  I was about to report that leftover test
file as a bug.  Do you ever sleep?  I am always amazed how quickly any
potential issue raised on the mailing list is resolved.

With this patch my "git init" in a pendrive correctly says "[core]
symlinks = false".

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Get a free email account with anti spam protection.
http://www.bluebottle.com/tag/2
