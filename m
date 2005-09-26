From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/3] Support for partial HTTP transfers
Date: Mon, 26 Sep 2005 18:23:45 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509261817080.23242@iabervon.org>
References: <20050926175204.GC9410@reactrix.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 00:20:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK1Jg-0005s6-1G
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 00:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbVIZWTR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 18:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbVIZWTR
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 18:19:17 -0400
Received: from iabervon.org ([66.92.72.58]:19207 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932355AbVIZWTR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2005 18:19:17 -0400
Received: (qmail 2725 invoked by uid 1000); 26 Sep 2005 18:23:45 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Sep 2005 18:23:45 -0400
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20050926175204.GC9410@reactrix.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9346>

On Mon, 26 Sep 2005, Nick Hengeveld wrote:

> Support for partial HTTP transfers - if a previous temp file is detected,
> read it in and start the HTTP transfer from where the previous left off.

You probably want the corresponding code for where it's downloading pack
and index files, which tend to be a lot bigger than individual objects. 

	-Daniel
*This .sig left intentionally blank*
