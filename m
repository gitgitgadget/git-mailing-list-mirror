From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] cg-init shouldn't create master branch when pulling
Date: Tue, 03 May 2005 16:48:09 -0400
Message-ID: <1115153289.28520.17.camel@dv.roinet.com>
References: <1114637617.15385.10.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue May 03 22:43:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT4Eb-0007qR-Gw
	for gcvg-git@gmane.org; Tue, 03 May 2005 22:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbVECUta (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 16:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVECUta
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 16:49:30 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:37043
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S261699AbVECUt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2005 16:49:26 -0400
Received: by localhost.localdomain (Postfix, from userid 500)
	id 7CBFDEFF3E; Tue,  3 May 2005 16:48:09 -0400 (EDT)
To: git <git@vger.kernel.org>
In-Reply-To: <1114637617.15385.10.camel@dv>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

Replying to myself.

On Wed, 2005-04-27 at 17:33 -0400, Pavel Roskin wrote:
> Hello!
> 
> >From what I see in the current cogito sources, ".git/refs/heads/master"
> is never used once it's created by cg-init.  I believe the "master"
> branch is only useful when creating a new repository.  Then it's the
> only branch in the repository.
> 
Please ignore this patch for now.  It turn out that the repositories
with only "origin" branch don't get updated properly by cg-update.
Changes don't get merged, so cg-cancel need to be run after cg-update.

It looks like that the "master" branch is needed, although it's not
documented anywhere.  Or maybe we need some further changes to support
origin-only repositories.  In any case, changing cg-init is not
sufficient.

-- 
Regards,
Pavel Roskin

