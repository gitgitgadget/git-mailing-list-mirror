From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC PATCH] Write new giturl(7) manpage
Date: Mon, 29 Mar 2010 11:48:18 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1003291140270.14365@iabervon.org>
References: <f3271551003290759g154b149fl7877d9b83e1313e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 29 17:48:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwHCT-0007g3-Lq
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 17:48:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696Ab0C2PsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 11:48:21 -0400
Received: from iabervon.org ([66.92.72.58]:55687 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477Ab0C2PsU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 11:48:20 -0400
Received: (qmail 32718 invoked by uid 1000); 29 Mar 2010 15:48:18 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Mar 2010 15:48:18 -0000
In-Reply-To: <f3271551003290759g154b149fl7877d9b83e1313e6@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143484>

On Mon, 29 Mar 2010, Ramkumar Ramachandra wrote:

> Write a new manpage for documenting how different URLs are handled by
> remote helpers.
> ---
>  It severely lacks polish, but I thought I'd send in an early draft requesting
>  comments. Also, I've made it more cryptic than Jonathan's revision and
>  included more references.
> 
>  I'm not entirely happy with it because the remote vcs setting doesn't
>  quite fit here. Plus, it seems like a dirty hack to me. The name doesn't do
>  justice: giturl exists to host Ilari's remote helper notes. How can it be
>  expanded to be more general?
> 
>  Why doesn't urls.txt document <transport>::<address> syntax? Should I
>  fix this?

One useful way of answering questions like this is to find the commits 
that added the <transport>::<address> syntax (probably easiest with git 
blame), and at the commits that touched urls.txt (probably with git log), 
and see if the reading the messages makes it obvious. I'd guess (without 
actually looking myself) that it was just overlooked.

	-Daniel
*This .sig left intentionally blank*
