From: "Jeff Whiteside" <jeff.m.whiteside@gmail.com>
Subject: Re: Broken index file - any hope?
Date: Fri, 3 Oct 2008 15:09:37 -0700
Message-ID: <3ab397d0810031509i3e54252cp260a78de1d3faf8a@mail.gmail.com>
References: <48E693E9.708@gmx.de> <20081003215319.GX21310@spearce.org>
	 <48E696CB.6040405@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Jonas Schneider" <JonasSchneider@gmx.de>
X-From: git-owner@vger.kernel.org Sat Oct 04 00:11:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlsrJ-0006W3-Ho
	for gcvg-git-2@gmane.org; Sat, 04 Oct 2008 00:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018AbYJCWJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 18:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753163AbYJCWJj
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 18:09:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:1828 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875AbYJCWJj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 18:09:39 -0400
Received: by ug-out-1314.google.com with SMTP id k3so1348101ugf.37
        for <git@vger.kernel.org>; Fri, 03 Oct 2008 15:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=sMqQqYVc+npCtz6E+uvcfp5EyLqCXByyRIzr8fAQDNg=;
        b=sgFQ7zINkqqBV3Jb+zFIOwjCh7NRbEhBKyQgf+U6IUPRvm1CFc0NHIUv87HRfYxynk
         GeoloqU9pLZ0lGyPs5ai3H8jUwEWGz/6M/KfdCTMjsr8/lJQ9sjRdV3gnRI38QaJfqYT
         77Q6MbMevuKT/fuR7NNNBr5SDM3exY+V+33Rk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=u17iTbx1Ymta73jK9y7PrUuPR87cR8c4Vcafl2Ub2VDVwLNLJxRI11DRjJBsi743gd
         GVY9/nYMsfufdHMkpGRxdTg5uxd+c2B+A9aZaH1i22dvMpwDfJjqJjFdoetEJ3J4L8R4
         RvzT+z4gOcY5/yxOLsORTFpRWwr9zszNvk6L4=
Received: by 10.66.220.12 with SMTP id s12mr5794975ugg.5.1223071777290;
        Fri, 03 Oct 2008 15:09:37 -0700 (PDT)
Received: by 10.67.93.17 with HTTP; Fri, 3 Oct 2008 15:09:37 -0700 (PDT)
In-Reply-To: <48E696CB.6040405@gmx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97459>

I don't know if you're new to git, but I used git for about a year
before I knew what the index really was.

Remember, the index file only stores changes you made to the
checkedout code AFTER the last commit, so all your commits are safely
in the tree objects still.

The index is only a place to store changes you made with "git add",
not "git commit".

I'm not sure how you refresh the index file but i would back
everything up and try a "git reset --hard" or something.



On Fri, Oct 3, 2008 at 3:03 PM, Jonas Schneider <JonasSchneider@gmx.de> wrote:
> Shawn O. Pearce schrieb:
>>
>>  git read-tree --reset HEAD
>
> Sadly, this doesnt help. I still get the same error.
> But, if I remove the corrupt index file, I get this:
>
> fatal: just how do you expect me to merge 0 trees?
>
> Does not look like a good sign :/
> Are all my branches (branch==tree?) gone? (okay, werent that much)
>
> Thanks anyway :)
> -- Jonas
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
