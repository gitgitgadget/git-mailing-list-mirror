From: Marc Liyanage <marc@entropy.ch>
Subject: Re: Unable to checkout a particular SVN revision
Date: Mon, 30 Nov 2009 20:59:25 -0800
Message-ID: <F558F791-E9C4-4340-BE3D-A46464F6033B@entropy.ch>
References: <718EEBA2-FA4B-402D-B2FC-A8F14D79F6FF@entropy.ch> <1259513411.32532.22.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Daniele Segato <daniele.bilug@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 01 05:59:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFKps-0000zH-CG
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 05:59:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164AbZLAE7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 23:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753148AbZLAE7Y
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 23:59:24 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:63685 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752986AbZLAE7X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2009 23:59:23 -0500
Received: by yxe17 with SMTP id 17so4305069yxe.33
        for <git@vger.kernel.org>; Mon, 30 Nov 2009 20:59:30 -0800 (PST)
Received: by 10.151.25.6 with SMTP id c6mr8855904ybj.243.1259643569589;
        Mon, 30 Nov 2009 20:59:29 -0800 (PST)
Received: from ?10.0.1.3? (c-76-21-40-129.hsd1.ca.comcast.net [76.21.40.129])
        by mx.google.com with ESMTPS id 6sm1910396ywc.9.2009.11.30.20.59.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Nov 2009 20:59:29 -0800 (PST)
In-Reply-To: <1259513411.32532.22.camel@localhost>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134164>


On 29.11.2009, at 08:50, Daniele Segato wrote:

> You had to understand the difference between a distributed version
> control system (git) and a centralized version control system (svn).

I understand that, I use (pure) git for all my personal projects, and it works great.

And even as a front end for SVN, I am *very* happy with what I got from git-svn so far, I think it is an excellent tool, even better than the actual SVN client. I track an SVN repository in my local git master branch, then branch off locally for development, send patches for review, reorder/consolidate/squash commits back onto my master branch and then dcommit that back to SVN. All that is great.


I would like to understand why 

   git svn clone -r n <url>

does not work as expected while

   git svn clone -r m <url>

does work perfectly fine, if that m revision number happens to have been committed on the particular SVN branch I cloned (you left off that -r in your git svn clone examples). As it is, I have to hunt for the next lower or higher revision number that happens to be on that branch.

I might be doing a poor job explaining what my question is... Basically, what prevents that operation from doing the same thing that SVN does? Lack of information, i.e. should I just clone higher up in the tree?



______________________________
Marc Liyanage
www.entropy.ch

skype mliyanage
iChat liyanage@mac.com
