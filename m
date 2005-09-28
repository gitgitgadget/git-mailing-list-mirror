From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: [PATCH 0/3] http-fetch enhancements
Date: Tue, 27 Sep 2005 19:39:47 -0700
Message-ID: <20050928023947.GA385@reactrix.com>
References: <Pine.LNX.4.63.0509261823590.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nick Hengeveld <Nick.Hengeveld@reactrix.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 28 04:44:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKRum-0004i6-4d
	for gcvg-git@gmane.org; Wed, 28 Sep 2005 04:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965246AbVI1Cmz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 22:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965256AbVI1Cmz
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 22:42:55 -0400
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:30335 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S965246AbVI1Cmy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2005 22:42:54 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j8S2dlHC000562;
	Tue, 27 Sep 2005 19:39:47 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j8S2dl6B000560;
	Tue, 27 Sep 2005 19:39:47 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0509261823590.23242@iabervon.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9420>

On Mon, Sep 26, 2005 at 03:29:02PM -0700, Daniel Barkalow wrote:

>    If you happen to know how to have curl do multiple simultaneous downloads,
>    that would be a big performance win, and I should be able to explain how
>    to get this to work. I haven't gotten around to learning libcurl well
>    enough to do the flow control.

The curl multi interface looks pretty straightforward.  What did you have
in mind as far as which requests would be running concurrently and how they
would need to be limited?

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
