From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Working copy revision and push pain
Date: Sun, 23 Mar 2008 15:22:29 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803231519380.4353@racer.site>
References: <47E64F71.3020204@jwatt.org>  <alpine.LSU.1.00.0803231401340.4353@racer.site>  <47E658D3.1060104@jwatt.org>  <51419b2c0803230645l5b07bbf5h9cbf9b6f47373efa@mail.gmail.com>  <47E6612A.5020408@jwatt.org>
 <51419b2c0803230706w5ff88fc7oc7e8e34ab8afa1fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jonathan Watt <jwatt@jwatt.org>, git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 15:23:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdR6R-00022L-D9
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 15:23:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755602AbYCWOWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 10:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753976AbYCWOWf
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 10:22:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:33664 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752560AbYCWOWe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 10:22:34 -0400
Received: (qmail invoked by alias); 23 Mar 2008 14:22:32 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43]
  by mail.gmx.net (mp009) with SMTP; 23 Mar 2008 15:22:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18SHvBJp9ESTkVBYrXhzmvEN1TraC0cYSVBK9wAYQ
	rNmFOuuhjzmmkq
X-X-Sender: gene099@racer.site
In-Reply-To: <51419b2c0803230706w5ff88fc7oc7e8e34ab8afa1fd@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77906>

Hi,

On Sun, 23 Mar 2008, Elijah Newren wrote:

> If there is no currently active branch because you checked out a tag
> or some arbitrary commit, then HEAD is said to be detached, and HEAD
> will track the particular commit you checked out.

I'd say that "track" is the wrong verb here.

> The end result is that HEAD is always the most recent commit to which 
> your working copy is relative to.  See also 
> http://www.kernel.org/pub/software/scm/git/docs/glossary.html
> 
> So, it sounds like we're both saying that in your case, you'd like the
> HEAD become detached and track the sha1 that it previously pointed to
> before your push rather than continuing to track the updated branch.

If you ever propose to detach the HEAD in a remote repository when 
somebody pushed into the referenced branch, I am totally opposed to that.

You can play your own games with the update and post-update hooks as much 
as you want, but please leave official Git alone.  Thankyouverymuch.

Ciao,
Dscho
