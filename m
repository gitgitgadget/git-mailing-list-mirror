From: "Scott R. Godin" <scottg.wp-hackers@mhg2.com>
Subject: Re: [RFE] pre/post-stash hooks
Date: Wed, 24 Feb 2010 14:31:55 -0500
Organization: MAD House Graphics
Message-ID: <hm3urb$1nf$1@dough.gmane.org>
References: <hlmi1o$fk5$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 20:32:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkMy4-00025d-FF
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 20:32:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757769Ab0BXTcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 14:32:15 -0500
Received: from lo.gmane.org ([80.91.229.12]:59516 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757765Ab0BXTcO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 14:32:14 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NkMxt-0001z5-IW
	for git@vger.kernel.org; Wed, 24 Feb 2010 20:32:09 +0100
Received: from pool-71-187-150-2.nwrknj.fios.verizon.net ([71.187.150.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 20:32:09 +0100
Received: from scottg.wp-hackers by pool-71-187-150-2.nwrknj.fios.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 20:32:09 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: pool-71-187-150-2.nwrknj.fios.verizon.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc11 Lightning/1.0b2pre Thunderbird/3.0.1
In-Reply-To: <hlmi1o$fk5$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140981>

giving this a bump since I haven't received any replies on it yet, and 
it's a valid question, IMHO.

On 02/19/2010 12:33 PM, Scott R. Godin wrote:
> While I had known about git stash, and just never used it, I'd finally
> gotten to the point where it was needed, only to discover something that
> I found interesting.
>
> My use case may a bit rare at the moment, I'll admit, but not at all
> far-fetched, and probably growing in usage as time goes on.
>
> In contrib/hooks is the script 'setgitperms.perl' which, when added to
> pre-commit, post-merge, and post-checkout, makes sure to track the file
> permissions fully, not just +/-x. This can be vitally important for
> webdevelopers who must keep certain permissions on certain directories,
> such as for e-commerce solutions like Magento, etc, so that the clients
> may upload new product images through the interface rather than via ftp.
>
> However when I recently used stash to push some changes aside while I
> did something else first, and then ran git stash pop, I realized that
> there weren't any hooks that would enable setgitperms.perl to be
> ensuring/tracking the file permissions are applied correctly after stash
> usage.
>
> Granted that full directory/file permissions may not be all that
> important to some of you coders, but I can assure you that web
> developers may not see it that way.
>
> Again granted, I could probably set up a Makefile, but not everyone
> knows how to do that (particularly those webdevelopers who aren't coders
> who would typically be familiar with Makefiles.
>
> Also granted I could probably find a way to work around this issue with
> an alias, but my thought is that I shouldn't have to.
>
> There are some of us who exist who have this funny thought that
> computers should be able to do things for us without us having to
> explicitly tell them to, specifically, every time. We'd prefer to set
> things up generally "just do this EVERY time for EVERYthing" and forget
> about it, and let the computer handle it. I'm sure you're familiar with
> us, since we are us. :-)
>
> So, with this in mind, in addition to requesting pre/post-stash hooks
> just for this alone, I'd like to solicit some thought from the rest of
> you as to potential possible usages/requirements for said hooks for
> reasons _other_ than running 'setgitperms.perl'
>
> Are there any reasons why pre/post-stash hooks _shouldn't_ exist?
>
> How difficult would it be to implement?
>


-- 
(please respond to the list as opposed to my email box directly,
unless you are supplying private information you don't want public
on the list)
