From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: [PATCH v3] gitk: Synchronize highlighting in file view when scrolling diff
Date: Mon, 24 Sep 2012 07:51:56 +0200
Message-ID: <1kqvbob.1e7rv3c1cyer9qM%lists@haller-berlin.de>
References: <20120923065825.GA15889@bloggs.ozlabs.ibm.com>
Cc: git@vger.kernel.org
To: paulus@samba.org (Paul Mackerras)
X-From: git-owner@vger.kernel.org Mon Sep 24 07:52:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TG1aS-0005Mh-8l
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 07:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537Ab2IXFv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 01:51:58 -0400
Received: from server90.greatnet.de ([83.133.96.186]:37603 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325Ab2IXFv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 01:51:58 -0400
Received: from [192.168.0.42] (nat1.ableton.net [217.110.199.117])
	by server90.greatnet.de (Postfix) with ESMTPA id 4044B3B0E92;
	Mon, 24 Sep 2012 07:51:56 +0200 (CEST)
In-Reply-To: <20120923065825.GA15889@bloggs.ozlabs.ibm.com>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.8.2 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206253>

Paul Mackerras <paulus@samba.org> wrote:

> On Wed, Sep 19, 2012 at 08:17:27PM +0200, Stefan Haller wrote:
> > Here's one way how to address your concern. When pressing the search button
> > it will highlight the file that contains the current search hit; if you then
> > scroll from there though, the normal mechanism kicks in again and might
> > highlight the previous file. The same happens now if you select the last file
> > in the list, but it's diff is smaller than a screenful. In the previous
> > patch versions it would select a different file than you clicked on, which
> > is probably also confusing.
> > 
> > Is this what you had in mind?
> 
> Yes, it is, and I applied your patch.  I wonder though if it might
> work better to highlight all the files that are visible?

Interesting idea. I tried it, but I don't like it much, it just looks
and feels so odd. I can send a patch if you're interested in trying it
yourself.

But personally, I really only need the synchronization feature in the
case where a file's diff is longer than fits on a screen; as long as a
file header is visible on the left side, it's prominent enough that I
don't need more guidance.

-Stefan


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
