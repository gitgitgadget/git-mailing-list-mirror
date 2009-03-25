From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: .git/index
Date: Wed, 25 Mar 2009 17:52:34 +0000 (GMT)
Message-ID: <alpine.LNX.2.00.0903251749270.11062@reaper.quantumfyre.co.uk>
References: <9e4733910903251016n117c37fdp94f91b2862cd7bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 18:54:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmXJ2-0006j4-Lk
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 18:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753507AbZCYRwv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 13:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754526AbZCYRwu
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 13:52:50 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:32958 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755266AbZCYRwt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 13:52:49 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 64EF12802F4
	for <git@vger.kernel.org>; Wed, 25 Mar 2009 17:52:47 +0000 (GMT)
Received: (qmail 31449 invoked by uid 103); 25 Mar 2009 17:52:34 +0000
Received: from darkphoton.datavampyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.94.2/9162. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.025994 secs); 25 Mar 2009 17:52:34 -0000
Received: from darkphoton.datavampyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 25 Mar 2009 17:52:34 +0000
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <9e4733910903251016n117c37fdp94f91b2862cd7bf@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114629>

On Wed, 25 Mar 2009, Jon Smirl wrote:

> I pushed a repo up to my server. I want to view this repo with gitweb
> but it is not visible in my project list like my other projects. I
> suspect this is because the newly pushed repo is missing .git/index. I
> ran update-server-info on the repo and that didn't create .git/index.
> What command builds this index?

.git/index is the default name used for what is commonly referred to as 
the staging area these days.  It's only needed when you have a work tree, 
and is expected to be absent from a bare repository.

A more likely cause for a repository to not be picked up by gitweb is 
file permissions.

-- 
Julian

  ---
<MFGolfBal> rit/ara:  There's something really demented about UNIX
             underwear...
