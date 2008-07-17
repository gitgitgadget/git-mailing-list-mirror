From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Subversion is actually not so simple (was RE: Considering teaching plumbing to users harmful)
Date: Thu, 17 Jul 2008 19:37:02 +0200
Message-ID: <200807171937.03270.jnareb@gmail.com>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <m3od4wse30.fsf@localhost.localdomain> <63BEA5E623E09F4D92233FB12A9F79430238A167@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "David Kastrup" <dak@gnu.org>, git@vger.kernel.org
To: "Craig L. Ching" <cching@mqsoftware.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 19:38:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJXQe-0005uq-R7
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 19:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757145AbYGQRhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 13:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755772AbYGQRhJ
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 13:37:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:40047 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818AbYGQRhH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 13:37:07 -0400
Received: by ug-out-1314.google.com with SMTP id h2so684170ugf.16
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 10:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=xboS00HBXiSQbrpfqQfCMDKP3fH8rFUGeFG2GVPy8+8=;
        b=xoFA+hHwf4ejZ3yAQW8Oym9htkqBbqDi5x9674Wf41zHHVMRsN63XqJ8wrGil8cum/
         HxtzYs+yEI+zMNvbVDJyDSNoutH3eM+TdA9b0ACUAZtdqGlU4CfL6PqZE9mI+zHhADyk
         KzfDh4ESRl44qq3dDTVEw//h3Mu0x37PUzGNo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=neYtdq+BlxTxbwNJ0sgunR7qe4MMAIP8WGsgZ3n30l73dWeHMOYCDk25OOJEupWwDs
         T/l8PKhzDddLKcXaFGGKJP2vJC3ny0Kqjs9mHdhEGgil+5c6565uunPZrwR6lYp2DcXS
         HvTmPYWKqSPe8z3xyP3q0QCOi7/JlA4clSelU=
Received: by 10.66.216.7 with SMTP id o7mr4087341ugg.66.1216316225751;
        Thu, 17 Jul 2008 10:37:05 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.254.74])
        by mx.google.com with ESMTPS id j27sm3641722ugc.59.2008.07.17.10.37.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 17 Jul 2008 10:37:05 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <63BEA5E623E09F4D92233FB12A9F79430238A167@emailmn.mqsoftware.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88890>

On Thu, 17 July 2008, Craig L. Ching wrote:

> For instance, SVN has a history of having to invent concepts that just
> shouldn't need to be invented.  Their latest release includes something
> they call "merge tracking", but it falls on the floor in the face of
> what they call "reflective merging." [1]  I don't find "merge tracking"
> and "reflective merges" concepts that I should *have* to understand when
> it comes to working with a VCS, the VCS should just *do* those things.
> Those concepts just don't exist in Git.  Frankly, I don't find
> Subversion to be easier to use than Git at all and this is coming from a
> very long-time CVS user.  I do find, however, that Git has a very large
> vocabulary and that does take some time to learn, but I'd argue that
> this is due to it's inherent flexibility than it is due to any inherent
> flaws.
> 
> [1] -- http://blogs.open.collab.net/svn/2008/07/subversion-merg.html

WTF!?!

Without merge tracking (which at minimum means that commits which are
result of [true] merging contain information about which commits were
merged) you can't really display and reconstruct history.  Without new
svn:mergeinfo one had to rely on third party extensions (SVK or svnmerge)
or on information contained in commit message to get this info.  It is
very good that at last Subversion 1.5 finally does include merge
information.

But, if I understand correctly, and if information in mentioned blog
is correct, then Subversion _fails_ to use this information fully.
Instead of finding merge bases (see http://revctrl.org ... errr, it
is now full of spam, and there is no easy way to revert to some older
version, so you would have to browse history), and doing 3-way merge[1],
it requires of user to explicitly request automatical merge:

  $ svn merge --reintegrate url://feature-branch .

and from the blog it looks like Subversion just generates patch and
applies it.  Or do I understand it incorrectly?

[1] CVS did it, even Bram Cohen of Codeville agrees now[2] that 3-way
    merge is a correct way to go
[2] http://bramcohen.livejournal.com/52148.html 
    "3. Use 3-way merge"
-- 
Jakub Narebski
Poland
