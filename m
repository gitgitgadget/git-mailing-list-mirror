From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: git-fetch and unannotated tags
Date: Wed, 25 Apr 2007 20:59:07 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704252056210.1005@reaper.quantumfyre.co.uk>
References: <200704252004.45112.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 21:59:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgne9-0006gf-3N
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 21:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422722AbXDYT7M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 15:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423380AbXDYT7L
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 15:59:11 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:58661 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422722AbXDYT7K (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Apr 2007 15:59:10 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 5123EC60FF
	for <git@vger.kernel.org>; Wed, 25 Apr 2007 20:59:08 +0100 (BST)
Received: (qmail 9670 invoked by uid 103); 25 Apr 2007 20:58:06 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3159. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.03721 secs); 25 Apr 2007 19:58:06 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 25 Apr 2007 20:58:06 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <200704252004.45112.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45556>

On Wed, 25 Apr 2007, Andy Parkins wrote:

> Hello,
>
> I often use unannotated tags to mark particular revisions in a
> repository.  I use unannotated tags just as I would a bookmark.
> Annotated tags I reserve for information about a particular revision
> that I want to share with the world.  In essence I treat unannotated
> tags as private and annotated tags as public.

Why not create a directory .git/refs/bm and put things you don't want to 
make public in there?  You can then use bm/foo etc ...

You could even modify git-tag to create them for you with some appropriate 
switch ...

-- 
Julian

  ---
First Rule of History:
 	History doesn't repeat itself -- historians merely repeat each other.
