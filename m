From: "Benjamin Sergeant" <bsergean@gmail.com>
Subject: Re: p4 + svn + git
Date: Thu, 7 Jun 2007 22:27:30 -0700
Message-ID: <1621f9fa0706072227s7b64e4abq682b53eb920c8f53@mail.gmail.com>
References: <1621f9fa0706072145s3ea6d5cdt3c3e6a2eaaffa14c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 07:27:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwX0g-0007uy-FT
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 07:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934838AbXFHF1e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 01:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934860AbXFHF1e
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 01:27:34 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:63494 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934838AbXFHF1d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 01:27:33 -0400
Received: by ug-out-1314.google.com with SMTP id j3so857790ugf
        for <git@vger.kernel.org>; Thu, 07 Jun 2007 22:27:32 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eOqzhnUnSTz6mJtOZ6S3Up/E62rEgod4eI75lAu7IISofe6kCBfTS2IVtXwtOHQy6SExGOaKbeuwL4l9ikeCBFsDrJ3o5TsxhCFnUnfsTjNkWaVLBpZApuRfS2znFhrSJU/DadOVHxpN98DKExJmBuNmtmztPyy80Dn2kqqexmI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hNvK92T/HHD+6esrKO3LGldMWUydkAbtzpabpxxAcAdnhxxB7TqBj7R7Xn13MzRh9vGNmy1p8Ry1sNYBa0BfIpm09TBJMzq4QJ8oWPNo3uos+w1aOnIwHdQ3imjOTmUhw0Qy39p5isTWhnlsJL5uuDu28P6gnXcUOr9tIyKrp3g=
Received: by 10.143.43.20 with SMTP id v20mr127972wfj.1181280450964;
        Thu, 07 Jun 2007 22:27:30 -0700 (PDT)
Received: by 10.143.43.1 with HTTP; Thu, 7 Jun 2007 22:27:30 -0700 (PDT)
In-Reply-To: <1621f9fa0706072145s3ea6d5cdt3c3e6a2eaaffa14c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49433>

On 6/7/07, Benjamin Sergeant <bsergean@gmail.com> wrote:
> That might be too much, but let's ask anyway...

This is probably too much, so on to the next question:
Is there a perforce equivalent of git-svn ?

What I'd like to do:
My main Linux machine will be the gateway.

1. I 'clone' the perforce tree with git-p4. I now have a .git, a full repo.
Can I use this as the equivalent of a subversion server, so that every
other machines pull / push from it.

And once in a while (weekly basis), I push the work that's been done
in git to perforce using the Linux box.

Doest that make sense ?

Thanks,
Benjamin.


>
> My company uses perforce.
> I took a snapshot of some code checked out from perforce (a single
> branch), that I imported into subversion, a while ago, and started
> working with svn only. I have different Unix machines checking in /
> out code code from the subversion server (with svn), and I'd like to
> keep it this way (if possible).
>
> I'm wondering if I could use git as a gateway between both systems, to
> merge code in both direction (svn <-> perforce).
>
> Is this possible, with the help of git-p4import, git-svn, and using
> several branches ?
>
> Thanks,
> Benjamin.
>
