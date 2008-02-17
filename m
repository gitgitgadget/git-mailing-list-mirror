From: Charles Bailey <charles@hashpling.org>
Subject: Re: [RFC/PATCH] Teach git mergetool to use custom commands defined at config time
Date: Sun, 17 Feb 2008 00:56:20 +0000
Message-ID: <20080217005620.GB504@hashpling.org>
References: <20080216185349.GA29177@hashpling.org> <CD749541-1B3B-4EA7-82A5-0DFC67B953BE@zib.de> <20080217002029.GA504@hashpling.org> <alpine.LSU.1.00.0802170045210.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 17 01:57:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQXq4-0006sL-Ma
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 01:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374AbYBQA43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 19:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753315AbYBQA43
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 19:56:29 -0500
Received: from ptb-relay03.plus.net ([212.159.14.214]:59680 "EHLO
	ptb-relay03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313AbYBQA42 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 19:56:28 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay03.plus.net with esmtp (Exim) id 1JQXpS-0008DZ-DH; Sun, 17 Feb 2008 00:56:26 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m1H0uKMl001385;
	Sun, 17 Feb 2008 00:56:20 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m1H0uK80001384;
	Sun, 17 Feb 2008 00:56:20 GMT
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802170045210.30505@racer.site>
User-Agent: Mutt/1.4.2.1i
X-Plusnet-Relay: c23bbe58d10a0acf718a097e746ad257
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74087>

On Sun, Feb 17, 2008 at 12:46:15AM +0000, Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 17 Feb 2008, Charles Bailey wrote:
> 
> > On Sat, Feb 16, 2008 at 11:37:31PM +0100, Steffen Prohaska wrote:
> > 
> > > Why not just add the tools you have in mind to git mergetool?  If 
> > > everyone did that eventually we would have direct support for a rather 
> > > long list of tools.  This would be the easiest solution for the end 
> > > user: He could just choose the preferred tool and use it.  The 
> > > invocation of each merge tool would be coded in mergetool.  The exact 
> > > command line could be fine tuned and would be reviewed by other git 
> > > developers.
> > > 
> > 
> > I have to disagree with this approach.
> 
> So you'd rather have the end users do the same work for the same tool over 
> and over again?
> 

I'm sorry, I should have made myself clearer. I disagree that the
approach of adding new tool support to the source code as and when they
are encountered is optimal. I believe that it is preferable to have a
solution that allows users to configure, rather then code, support for
their own tools that do not to have native support.

I do not disagree that there is benefit to having a wide range of
tools that are supported natively.

I thought I made a reasonable argument for this in the rest of my
email that you took the headline from, but evidently I came across as
muddled.

Charles.
