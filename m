From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: Remote git-describe ?
Date: Wed, 24 Jan 2007 12:13:17 +0100
Message-ID: <38b2ab8a0701240313w64c2df57w2542b63eba2294e0@mail.gmail.com>
References: <38b2ab8a0701240231v5ec4acfasd838ececb316500d@mail.gmail.com>
	 <Pine.LNX.4.63.0701241201410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 24 12:13:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9g4Y-0007qf-Io
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 12:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbXAXLNV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 06:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbXAXLNU
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 06:13:20 -0500
Received: from hu-out-0506.google.com ([72.14.214.228]:53681 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171AbXAXLNU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 06:13:20 -0500
Received: by hu-out-0506.google.com with SMTP id 36so126468hui
        for <git@vger.kernel.org>; Wed, 24 Jan 2007 03:13:18 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BMsK3mngoRvkWi0gHyzAe/ZUaZds2Z/vIc/Xu18N3XCZSiF1hteVDm4L5BptcHGHtQ6y2QDWG6c29i7fDMkCnIjx5Zy1q2waxZP0oOrxfVRwnlbQcXo2vqAHVd9jdM3avlKebMUQm30UUd1OYeN4pgJ4Zd2NDE8lCC+9jKaCqC4=
Received: by 10.48.48.13 with SMTP id v13mr2262465nfv.1169637197791;
        Wed, 24 Jan 2007 03:13:17 -0800 (PST)
Received: by 10.49.30.4 with HTTP; Wed, 24 Jan 2007 03:13:17 -0800 (PST)
In-Reply-To: <Pine.LNX.4.63.0701241201410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37626>

On 1/24/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 24 Jan 2007, Francis Moreau wrote:
>
> > I'm looking for a command that would give the same output than 'git
> > describe' but on a remote server.
> >
> > Is this possible ?
>
> It would be possible; at a high cost (especially on the remote server):
> You definitely need _all_ commits between the commit you want to describe
> and the tag it eventually finds, and possibly all other commits, too.
>
> So it boils down to fetching all commit objects. It is much cheaper, and
> more efficient, to just fetch the repo and do it locally.
>

really ? Givinig that I would use it to describe the HEAD of the kernel repo:

        $ git describe --remote=<git-server> HEAD

this would make the server parse all commits between HEAD and the
closest tag which seems to me a lot cheaper than downloading the whole
repo...
-- 
Francis
