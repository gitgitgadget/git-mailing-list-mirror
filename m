From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: oprofile on svn import
Date: Wed, 14 Jun 2006 01:26:57 -0400
Message-ID: <9e4733910606132226u720c74b6tb614df2702a819c5@mail.gmail.com>
References: <9e4733910606131810ya6aa585m5d2349f651b01492@mail.gmail.com>
	 <20060614020108.GB12083@hand.yhbt.net>
	 <20060614044802.GE30825@h4x0r5.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Eric Wong" <normalperson@yhbt.net>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 14 07:27:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqNu9-0001VG-CG
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 07:27:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbWFNF06 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 01:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWFNF06
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 01:26:58 -0400
Received: from nz-out-0102.google.com ([64.233.162.199]:26519 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964881AbWFNF05 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jun 2006 01:26:57 -0400
Received: by nz-out-0102.google.com with SMTP id s18so69027nze
        for <git@vger.kernel.org>; Tue, 13 Jun 2006 22:26:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SEZeXWDmPEWiVbInAdTG5kg8hvqPje1cRs/B+/HaDtUObhgyG2os65tryXBdY2yLkCIUVoeoFGfEb7rbfMnAVMfEzWy0SNZyActpfG4z+J46z3HlGI4Lee6cW2VOHSqsyQb4CNjLIF8kf20IvKcaP0Ung4bMHOEX6b0YWhWY5+I=
Received: by 10.36.33.15 with SMTP id g15mr446635nzg;
        Tue, 13 Jun 2006 22:26:57 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Tue, 13 Jun 2006 22:26:57 -0700 (PDT)
To: "Ryan Anderson" <ryan@michonline.com>
In-Reply-To: <20060614044802.GE30825@h4x0r5.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21828>

On 6/14/06, Ryan Anderson <ryan@michonline.com> wrote:
> On Tue, Jun 13, 2006 at 07:01:08PM -0700, Eric Wong wrote:
> > Anybody want to see how my latest patches to git-svn (and using SVN perl
> > libraries) stacks up against the mozilla repo?  Speedwise, I don't
> > expect git-svn to be too different than git-svnimport, but it should use
> > much less memory (I'll probably port the hacks to git-svnimport, too).
>
> I've got access to a pretty good machine to run this on - where can I
> grab the svn repo from?
> (I can just grab the CVS one and convert it, first, as well, just point
> me at that, if that's got more bandwidth.)

rsync -az cvs-mirror.mozilla.org::mozilla ~/mozilla/cvs-mirror
It took about three days for my machine to convert that cvs to svn.

I have the converted repo local but it is 8.2GB and I have 256kb up.

There is no real purpose in converting mozilla cvs to svn to git other
than to test the tools. My last attempt at svn to git ran five days
before I lost power. Towards the end it was getting significantly slow
implying some kind of n squared problem in the import process. The
idea was to see if cvsimport and svnimport both end up with the same
output.

I am going to use git-cvsimport on the mozilla repo but that tool
needs to 2GB+ physical RAM to run. I ordered 2GB more and it will be
here tomorrow. I have just been playing with the svn conversion while
I wait five days for my 2nd day air package to show up.


>
> --
>
> Ryan Anderson
>   sometimes Pug Majere
>


-- 
Jon Smirl
jonsmirl@gmail.com
