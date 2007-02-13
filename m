From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: stgit "unknown user details" bug?
Date: Tue, 13 Feb 2007 10:40:49 +0000
Message-ID: <b0943d9e0702130240x1822f882t4f0d1780647d98ad@mail.gmail.com>
References: <200702130434.l1D4YmrA010122@freya.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Adam J. Richter" <adam@yggdrasil.com>
X-From: git-owner@vger.kernel.org Tue Feb 13 11:41:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGv5j-0006B0-Pu
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 11:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbXBMKkw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 05:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbXBMKkw
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 05:40:52 -0500
Received: from wr-out-0506.google.com ([64.233.184.227]:12178 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbXBMKkw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 05:40:52 -0500
Received: by wr-out-0506.google.com with SMTP id i21so2137663wra
        for <git@vger.kernel.org>; Tue, 13 Feb 2007 02:40:51 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UQ9hPo1OSEPC7HCJqzhrSSlW2ozbuBfeoy0igHmKFnaBjLIVsH6yhO3KdaNLn41lbNq044fD81WpMdIuDL22dzF0XThMLcR/GO1J9auN3S42YeEfFEOykkQ9rHY615JXre9f09F2QOoPo6bJcv9isPnXN3Qotp9Vn70cKeG3hOA=
Received: by 10.114.80.4 with SMTP id d4mr7475625wab.1171363249809;
        Tue, 13 Feb 2007 02:40:49 -0800 (PST)
Received: by 10.115.110.12 with HTTP; Tue, 13 Feb 2007 02:40:49 -0800 (PST)
In-Reply-To: <200702130434.l1D4YmrA010122@freya.yggdrasil.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39513>

On 13/02/07, Adam J. Richter <adam@yggdrasil.com> wrote:
>         First of all, I apologize in advance for cc'ing the busy git

Gmail decided this mail is spam, probably because of the "apologize"
word (frequent in the Nigerian letters :-)).

> mailing list with problems about stgit.  The stgit web page at
> http://www.procode.org/stgit/ says "Please report bugs to Catalin
> Marinas and copy the GIT mailing list."  I would feel less guilty
> about whose time I was spending on reports like this if there were a
> separate stgit-users list.

I asked the GIT people some time ago and they were OK with porcelain
tools postings here. They should let me know if it become annoying.
You could also use https://gna.org/bugs/?group=stgit for reporting
bugs (or search for previous reports).

>         I did the "stg pull" as root, did not set any of the
> GIT_AUTHOR_* environment variables and did not create any kind of git
> or stg configuration file.  No doubt I could work around this by
> setting up some kind of configuration file, but I should not be
> required to do so, especially just to do a "pull".

A quick fix is to run:

git repo-config --global user.name "Adam J. Richter"
git repo-config --global user.email adam@yggdrasil.com

>         I don't mind that a version control system might log user ID
> and email addresses somewhere, but it should still work if I do not
> wish to provide that information.

As Yann said, there is already a bug logged for this issue. I also
think there is a different issue mailed me yesterday with the same
thing when pushing a patch, even though the patch author/committer
information was already in the patch metadata handled by StGIT.

I'll have a look at this.

-- 
Catalin
