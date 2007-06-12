From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Port git-tag.sh to C.
Date: Mon, 11 Jun 2007 23:28:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0706112314300.5848@iabervon.org>
References: <11813427591137-git-send-email-krh@redhat.com>
 <1b46aba20706081858u7f18d9b2o5602db43d396c19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?X-UNKNOWN?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org, Julian Phillips <julian@quantumfyre.co.uk>
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 05:28:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxx3n-000878-Mz
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 05:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222AbXFLD2k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 23:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752659AbXFLD2k
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 23:28:40 -0400
Received: from iabervon.org ([66.92.72.58]:3757 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752222AbXFLD2k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 23:28:40 -0400
Received: (qmail 2184 invoked by uid 1000); 12 Jun 2007 03:28:39 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Jun 2007 03:28:39 -0000
In-Reply-To: <1b46aba20706081858u7f18d9b2o5602db43d396c19@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49915>

On Sat, 9 Jun 2007, Carlos Rica wrote:

> Feel free to choose the script which you need to get replaced first,
> or, depending on your urgency, you could ask me for one of them and I
> would try to concentrate my efforts on it. Why do you started with
> git-tag? For me, it was enough easy to begin with, perhaps you could
> have other reasons.

Incidentally, I have been working on fetch, based on Julian Phillips's 
version. I'm trying to split out the "how do I communicate with remote 
repositories" code, and use it for pushing and ls-remote as well as fetch. 
I've got a bunch of not-for-official-history development that you should 
look at if you try any of the remote-repository-access scripts.

	-Daniel
*This .sig left intentionally blank*
