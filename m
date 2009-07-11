From: Charles Bailey <charles@hashpling.org>
Subject: Re: Show current SHA1
Date: Sat, 11 Jul 2009 11:16:52 +0100
Message-ID: <20090711101652.GA30698@hashpling.org>
References: <9586f3420907110239nbc35aealb473e1f1b3667410@mail.gmail.com> <874otjlf22.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Allan Kelly <allankelly@gmail.com>, git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Sat Jul 11 12:27:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPZnS-0003ni-BB
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 12:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175AbZGKK07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2009 06:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753011AbZGKK06
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jul 2009 06:26:58 -0400
Received: from relay.pcl-ipout01.plus.net ([212.159.7.99]:7375 "EHLO
	relay.pcl-ipout01.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752587AbZGKK05 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Jul 2009 06:26:57 -0400
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Sat, 11 Jul 2009 06:26:57 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAPMDWErUnw4S/2dsb2JhbADNF4QJBYE7
Received: from pih-relay05.plus.net ([212.159.14.18])
  by relay.pcl-ipout01.plus.net with ESMTP; 11 Jul 2009 11:16:53 +0100
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay05.plus.net with esmtp (Exim) id 1MPZdV-0003MQ-71; Sat, 11 Jul 2009 11:16:53 +0100
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n6BAGqrB031357
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 11 Jul 2009 11:16:52 +0100
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n6BAGqRT031356;
	Sat, 11 Jul 2009 11:16:52 +0100
Content-Disposition: inline
In-Reply-To: <874otjlf22.fsf@iki.fi>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: f7c8c48257d1533687e3db39a902d2e6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123108>

On Sat, Jul 11, 2009 at 12:55:17PM +0300, Teemu Likonen wrote:
> On 2009-07-11 10:39 (+0100), Allan Kelly wrote:
> 
> > The question then is: what is the command to report the current SHA1?
> > Note I never branch in the HTML repo, it's entirely linear.
> 
> If the "current SHA1" means "the SHA1 of the most recent commit in the
> current branch" then usually
> 
>     git show
> 
> is the simplest way. There are many ways to print _only_ the SHA1.
> Examples:
> 
>     git log -1 --pretty=format:%H
>     git rev-list -1 HEAD

For listing a single commit, I usually think of show and rev-parse
before using commands that list multiple commits. (Of course, having
to use --quiet doesn't make show any shorter than log -1.)

    git rev-parse HEAD
    git show --quiet --pretty=format:%H

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
