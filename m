From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: [PATCH] git-stash: don't complain when listing in a repo with no stash
Date: Mon, 02 Jul 2007 14:02:48 +0900
Message-ID: <200707020503.l6253NPQ020362@mi0.bluebottle.com>
References: <20070702042124.GA29479@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 02 07:03:32 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5E4M-0003sR-VY
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 07:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbXGBFDZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 01:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbXGBFDY
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 01:03:24 -0400
Received: from mi0.bluebottle.com ([206.188.25.15]:39992 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbXGBFDY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 01:03:24 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id l6253NPQ020362
	for <git@vger.kernel.org>; Sun, 1 Jul 2007 22:03:23 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:date:subject:in-reply-to:mime-version:
	content-type:content-transfer-encoding:x-trusted-delivery;
	b=zGAP0Pj0jmQ9nFB3g3oht5zgBDgLfsZ0YWsJGG4VUBsyAW6SOfiDz5injKMWyl1xW
	9ictizL23L+qIALhJo4q62i/mZsG7+IPkQCSNVwksxarmKTGEQEVX638Ep6nYMZ
Received: from nanako3.mail.bluebottle.com ([222.175.53.18])
	(authenticated bits=0)
	by fe1.bluebottle.com (8.13.1/8.13.1) with ESMTP id l6253BSw003575
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 1 Jul 2007 22:03:20 -0700
In-Reply-To: <20070702042124.GA29479@coredump.intra.peff.net>
X-Trusted-Delivery: <744729aa3d08a081a4b1d28694d7bb36>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51344>

Quoting Jeff King <peff@peff.net>:

> Previously, the git-log invocation would complain if a repo
> had not had any stashes created in it yet:
>
> $ git-init
> $ git-stash
> fatal: ambiguous argument 'refs/stash': unknown revision or
>   path not in the working tree.
> Use '--' to separate paths from revisions
>
> Instead, we only call git-log if we actually have a
> refs/stash. We could alternatively create the ref when any
> stash command is called, but it's better for the 'list'
> command to not require write access to the repo.
>
> Signed-off-by: Jeff King <peff@peff.net>

Thank you for correcting the bugs I introduced.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Finally - A spam blocker that actually works.
http://www.bluebottle.com
