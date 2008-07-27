From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Cleaning up log messages
Date: Sun, 27 Jul 2008 14:16:30 -0400
Message-ID: <9e4733910807271116q29323664l8d44fdded1de8c8e@mail.gmail.com>
References: <9e4733910807271050y7fb5f77coec05bd68421baaab@mail.gmail.com>
	 <alpine.DEB.1.00.0807272000270.5526@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 27 20:17:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNAoG-0002sd-O1
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 20:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbYG0SQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 14:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757893AbYG0SQc
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 14:16:32 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:20461 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbYG0SQc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 14:16:32 -0400
Received: by wr-out-0506.google.com with SMTP id 69so3380225wri.5
        for <git@vger.kernel.org>; Sun, 27 Jul 2008 11:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=IL9RnlyRZKBKtl/IFd6vOgZlyjegKwEqwf1Ib/+f6DU=;
        b=aZByRZ9grm5eTTBR2KLMxuA4gsWC5tqgTFVSjpfVu5DuKcT8RBE0GbgL5DnMnGD/8M
         dtTA5RC4pDIIMvrI/fScUdwKYPx9QWR387Qp1zYs7aafwwvlJYp2sBy2Gb64nL67E5Eh
         e5AAR5MGznJLTwx/No5zLXLjBNBSocORXI2hQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=X9rQCILETErJ+RKSd3iUmHXnkcQRrmemi0K2O3crLyKNMHcjCUd3kCAuWbkj1P449T
         NIIszB6I9fHxTV0L8gsxtRWqJXxpR37pe+VooKfClI0BLkl8aS/9HHbvRm2H7pxwDGJq
         CoHkvRD8lOGkbHCiCqUie9PDgfZp+tE04c5vo=
Received: by 10.90.98.13 with SMTP id v13mr6131789agb.86.1217182590771;
        Sun, 27 Jul 2008 11:16:30 -0700 (PDT)
Received: by 10.150.205.1 with HTTP; Sun, 27 Jul 2008 11:16:30 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807272000270.5526@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90352>

On 7/27/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>
>  On Sun, 27 Jul 2008, Jon Smirl wrote:
>
>  > I was playing around with git log for the kernel and observed that there
>  > is a lot of noise when trying to do statistics on the number of commits.
>  >
>  > For example:
>  >
>  > Author: Greg K-H <gregkh@suse.de>
>  > Author: Greg KH <gregkh@suse.de>
>  > Author: Greg KH <greg@kroah.com>
>  > Author: Greg KH <greg@press.(none)>
>  > Author: gregkh@suse.de <gregkh@suse.de>
>  > Author: Greg Kroah-Hartman <gregkh@suse>
>  > Author: Greg Kroah-Hartman <gregkh@suse.de>
>  > Author: Greg Kroah-Hartman <greg@kroah.com>
>  >
>  > I don't see an obvious way to do this with git, but it would be neat
>  > to have a 'clean' option on git log that would take each email address
>  > (author, signed-off, acked, etc) and map it through a table which
>  > would convert old email addresses in to the current one and also
>  > standardize the formatting of the names.
>
>
> Something like .mailmap?
>
>  And to show the mapped author name instead of the committed one, you would
>  use "--pretty=format:%aN"?  (Needs 1.6.0-rc0 at least, IIRC)

So we can already do this? Where is a .mailmap for the kernel tree?

-- 
Jon Smirl
jonsmirl@gmail.com
