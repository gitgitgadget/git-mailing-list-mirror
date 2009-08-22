From: Thell Fowler <git@tbfowler.name>
Subject: Re: What's a good setup for submitting patches to the list
 properly?
Date: Sat, 22 Aug 2009 15:58:43 -0500 (CDT)
Message-ID: <alpine.DEB.2.00.0908221531230.29625@GWPortableVCS>
References: <alpine.DEB.2.00.0908191849220.2012@GWPortableVCS> <alpine.DEB.2.00.0908220953460.2012@GWPortableVCS> <200908222220.35354.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thell Fowler <git@tbfowler.name>, git@vger.kernel.org,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Aug 22 23:00:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MexhA-0003vw-Ct
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 23:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755598AbZHVU7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 16:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754943AbZHVU7J
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 16:59:09 -0400
Received: from 216.38.49.125.servint.net ([216.38.49.125]:55551 "EHLO
	vps5.pyrapat.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbZHVU7I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 16:59:08 -0400
Received: from ip70-178-75-143.ks.ks.cox.net ([70.178.75.143] helo=GWPortableVCS.local)
	by vps5.pyrapat.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <git@tbfowler.name>)
	id 1Mexg5-0001v2-Aj; Sat, 22 Aug 2009 15:59:09 -0500
X-X-Sender: almostautomated@GWPortableVCS
In-Reply-To: <200908222220.35354.chriscool@tuxfamily.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vps5.pyrapat.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tbfowler.name
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126822>

Christian Couder (chriscool@tuxfamily.org) wrote on Aug 22, 2009:

> On Saturday 22 August 2009, Thell Fowler wrote:
> >
> > > What could I have done/checked before sending to make sure that these
> > > would have posted properly?
> 
> Perhaps you could send them to yourself.
> 

Yes, I did.  They all showed up under the correct thread, but then I 
changed how I did it by adding cover-letter to the format-patch options.  

BTW - After looking at the headers it looks like the cover letter header 
worked just fine, but that the cover letter msg-id changed between when 
format-patch created it and when it was sent out causing the reset of the 
msgs to not have anything to reference to.

> > No input on this?  Perhaps I should've posted to the git user or alpine
> > lists?
> 
> It's ok to post this kind of questions on the git mailing list.
> 
> There is "git send-email" that is bundled with git. But I use 
> git-mail-commits from Julian Philips. I am very happy with it. Thanks 
> Julian!
> 

I guess I'll setup smtp and try the send-email route, not sure if that 
is going to change anything having to do with the In-Reply-To field 
and a cover letter or how it shows in the threading.

If that doesn't work then I'll give Julian's mail-commits a whirl.

Thanks for replying Christian!

-- 
Thell
