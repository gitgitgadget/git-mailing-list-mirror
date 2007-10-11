From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: Split a subversion repo into several git repos
Date: Thu, 11 Oct 2007 14:46:26 +0100
Message-ID: <27DDC599-C7A0-4660-B5C6-7DFCEB137C14@steelskies.com>
References: <op.tz09zaizjwclfx@ichi>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Eivind LM" <eivliste@online.no>
X-From: git-owner@vger.kernel.org Thu Oct 11 15:46:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfyNA-000391-BB
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 15:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338AbXJKNqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 09:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752835AbXJKNqe
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 09:46:34 -0400
Received: from juliet.asmallorange.com ([207.210.105.70]:38933 "EHLO
	juliet.asmallorange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752314AbXJKNqd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 09:46:33 -0400
Received: from host217-35-101-26.in-addr.btopenworld.com ([217.35.101.26]:51436 helo=[192.168.1.59])
	by juliet.asmallorange.com with esmtpa (Exim 4.68)
	(envelope-from <maillist@steelskies.com>)
	id 1IfyMy-0005s9-Rh; Thu, 11 Oct 2007 09:46:33 -0400
In-Reply-To: <op.tz09zaizjwclfx@ichi>
X-Mailer: Apple Mail (2.752.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - juliet.asmallorange.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - steelskies.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60597>


On 11 Oct 2007, at 13:51, Eivind LM wrote:

> Hi,
> I would like to convert a subversion repository to Git. The  
> subversion repository used to track development of several projects  
> (only slightly related), and I would like to divide the repository  
> into several smaller git repositories.
>
> For example, I want to convert one subversion repository which  
> contains the folders:
> trunk/projectA
> trunk/projectB
>
> into two git repositories:
> projectA.git
> projectB.git

I have a slightly different layout to you -

projectA/trunk
projectA/branches
projectA/tags
projectB/trunk
projectB/branches
projectB/tags
etc

- but I've been creating separate git repos from that with (for  
example) :

git-svn init -t tags -b branches -T trunk http://svn.host.com/projectA
git-svn fetch


Or will git-svn not work with your sort of layout?
