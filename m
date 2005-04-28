From: Chris Mason <mason@suse.com>
Subject: Re: Finding file revisions
Date: Thu, 28 Apr 2005 13:05:21 -0400
Message-ID: <200504281305.23063.mason@suse.com>
References: <Pine.LNX.4.21.0504281147500.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	Kay Sievers <kay.sievers@vrfy.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 19:00:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRCMx-0002ON-JS
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 19:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbVD1RFd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 13:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbVD1RFd
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 13:05:33 -0400
Received: from ns.suse.de ([195.135.220.2]:45977 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262171AbVD1RF2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 13:05:28 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 4AB55160D96D;
	Thu, 28 Apr 2005 19:05:28 +0200 (CEST)
To: Daniel Barkalow <barkalow@iabervon.org>
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.21.0504281147500.30848-100000@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thursday 28 April 2005 12:08, Daniel Barkalow wrote:
> On Wed, 27 Apr 2005, Chris Mason wrote:
> > I haven't seen a tool yet to find which changeset modified a given file,
> > so I whipped up something.  The basic idea is to:
>
> What is the answer supposed to be in the presence of merges? It seems like
> you shouldn't report the merge that brought in the change, but rather
> (assuming it's available) the changeset that originally made it.

Based on comments from Linus I did make it a little more merge aware.  But 
since my tool was just to tide me over until someone fixed things in gui 
form, I didn't want to kill off too many brain cells coding it.

It sounds as though David's script is already has more merge brains then mine, 
and the git web stuff is pretty slick.  So it seems I didn't look hard enough 
before...

-chris
