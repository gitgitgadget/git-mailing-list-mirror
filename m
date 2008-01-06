From: Brian Swetland <swetland@google.com>
Subject: Re: rm and mv commands: should I use them?
Date: Sun, 6 Jan 2008 00:08:01 -0800
Organization: Google, Inc.
Message-ID: <20080106080801.GA1483@bulgaria.corp.google.com>
References: <379EDA94-A67B-483A-BC5F-E961DD52AD0C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jon Hancock <redstarling@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 09:08:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBQYt-00007v-HW
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 09:08:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092AbYAFIIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 03:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751811AbYAFIIZ
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 03:08:25 -0500
Received: from smtp-out.google.com ([216.239.45.13]:34495 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796AbYAFIIY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 03:08:24 -0500
Received: from zps76.corp.google.com (zps76.corp.google.com [172.25.146.76])
	by smtp-out.google.com with ESMTP id m0688ILo005682;
	Sun, 6 Jan 2008 00:08:19 -0800
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:to:cc:subject:message-id:references:
	mime-version:content-type:content-disposition:in-reply-to:organization:user-agent;
	b=NJVIGhgorR0wtUqhKjLeiAaRf4E8lon7G6R+OTS5/nIuSpOM57O8RlbEZiIsZ0Imp
	pElFwaugkiafuw1+GKTyA==
Received: from bulgaria (bulgaria.corp.google.com [172.18.102.38])
	by zps76.corp.google.com with ESMTP id m0688IoY026579;
	Sun, 6 Jan 2008 00:08:18 -0800
Received: by bulgaria (Postfix, from userid 1000)
	id C8D891224A3; Sun,  6 Jan 2008 00:08:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <379EDA94-A67B-483A-BC5F-E961DD52AD0C@gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69717>

[Jon Hancock <redstarling@gmail.com>]
>
> So, do I need to use git's mv and rm commands?  Can't I just rename, add, 
> and remove files using any means I like and then just ensure my "index" is 
> staged properly when I do a commit?  Additionally, is there a simple 
> procedure with git to say: "I want to version exactly what is in my working 
> tree.  If I removed something or added something, just handle it".  This is 
> sort of what "git add ." does, but "git add" doesn't handling things I 
> removed or moved, correct?

"git add ." only adds new or modified files to the index.  You can use
"git add -u ." to update the index to reflect any deleted files.

Brian
