From: Jens Axboe <axboe@suse.de>
Subject: Re: git merging
Date: Mon, 20 Jun 2005 16:13:04 +0200
Message-ID: <20050620141303.GN15021@suse.de>
References: <20050617181156.GT6957@suse.de> <Pine.LNX.4.58.0506171132390.2268@ppc970.osdl.org> <20050617183914.GX6957@suse.de> <Pine.LNX.4.58.0506171142500.2268@ppc970.osdl.org> <42B357D7.6030302@pobox.com> <Pine.LNX.4.58.0506171629320.2268@ppc970.osdl.org> <42B36207.3020209@pobox.com> <Pine.LNX.4.58.0506171700200.2268@ppc970.osdl.org> <20050620123053.GI15021@suse.de> <pan.2005.06.20.13.48.30.2680@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 20 16:07:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkMvY-00085n-Rg
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 16:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVFTOMQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Jun 2005 10:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVFTOMQ
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jun 2005 10:12:16 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:2284 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261245AbVFTOL4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jun 2005 10:11:56 -0400
Received: from [62.242.22.158] (helo=router.home.kernel.dk)
	by virtualhost.dk with esmtp (Exim 3.36 #1)
	id 1DkN05-0005ba-00; Mon, 20 Jun 2005 16:11:45 +0200
Received: from nelson.home.kernel.dk ([192.168.0.33] helo=kernel.dk)
	by router.home.kernel.dk with esmtp (Exim 4.22)
	id 1DkN02-0001eP-9Z; Mon, 20 Jun 2005 16:11:42 +0200
Received: by kernel.dk (Postfix, from userid 1000)
	id C45F467D73; Mon, 20 Jun 2005 16:13:04 +0200 (CEST)
To: Matthias Urlichs <smurf@smurf.noris.de>
Content-Disposition: inline
In-Reply-To: <pan.2005.06.20.13.48.30.2680@smurf.noris.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 20 2005, Matthias Urlichs wrote:
> Hi, Jens Axboe wrote:
> 
> > error: cannot map sha1 file c39ae07f393806ccf406ef966e9a15afc43cc36a
> > bad object in tag 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c
> 
> What does "git-cat-file -t" say on these two -- are they botth vald commit
> objects?

axboe@nelson:[.]l/git/linux-2.6-block.git $ git-cat-file -t c39ae07f393806ccf406ef966e9a15afc43cc36a
error: cannot map sha1 file c39ae07f393806ccf406ef966e9a15afc43cc36a
fatal: git-cat-file c39ae07f393806ccf406ef966e9a15afc43cc36a: bad file
axboe@nelson:[.]l/git/linux-2.6-block.git $ git-cat-file -t 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c
tag

-- 
Jens Axboe

