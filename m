From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: git-branch, older repos and more confusion
Date: Thu, 12 Apr 2007 16:14:06 +1200
Message-ID: <46a038f90704112114t520374b2qea4f860575c21bce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 06:14:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbqhZ-0003Tr-9l
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 06:14:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422627AbXDLEOJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 00:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422636AbXDLEOJ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 00:14:09 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:25955 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422627AbXDLEOH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 00:14:07 -0400
Received: by wx-out-0506.google.com with SMTP id h31so433084wxd
        for <git@vger.kernel.org>; Wed, 11 Apr 2007 21:14:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ETYFTTzQDY+8Tvszfo9m96kyUnF3KpVXs6P/FPAjhlrXh15CKsHqTq1pTgIZQxDQzDExLXCAmPHOag8O8DrrQ8tTYs5xAjMDla/btDuf4PaNs+vKZDrMicrNOXLKWZkrOi1k3O9XxPJDDFqpQEnYrfcD6dzQiaOyMKEZC8pldFU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=KjTwxRJh8L83L5H0YuFAJIH3eNBgwbeL1KJB3oVodvn4N7KgRyHTv4wjT64PfXY9Tro0h6GIReVG47iELZEUpiNP+uq2JsmunyefJkZl+Vh2Ou0DSTkiEe9a3sci8oFgGTAKKMWGFDaXsHgx0+4CmujbMcxHvvtyE8coxZVFsDw=
Received: by 10.90.34.3 with SMTP id h3mr1333054agh.1176351246297;
        Wed, 11 Apr 2007 21:14:06 -0700 (PDT)
Received: by 10.90.120.11 with HTTP; Wed, 11 Apr 2007 21:14:06 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44317>

Thanks to Peff for helping me out earlier with my git-branch usage.
Alas, I seem to be in trouble again.

My git tracking repo is still using the .git/remotes/origin
infrastructure, and now it turns out I can't seem to do a git-pull and
then a git-format-patch of my local 'master' for patches to go on top
of junio's master. I am using 1.5.1.106.ga32037

I'll get a new checkout, but I'm a bit miffed that this is broken -- I
wanted to use git-format-patch to migrate unmerged patches to the new
checkout.

<rant>
This is all a bit confusing, and "the right way to do it" is changing
too fast. And with the changes, all the little things that make it
easy to manage it are lost, and all the wiki pages and documentation
bits are old and wrong. The simple master/origin scheme works well, is
dead easy to teach, and has worked well for my team of ~14 developers
working on maybe ~40 custom branches. It's pretty safe from errors too
;-)

Alas - I think support for it seems to be going the away... what I am
missing is a clear way to say git-clone <repo>#branch that has the
same properties that `cg-clone <repo>#branch` has. Namely, once you
are done, there are clear names for your "local tip" and "remote tip",
and push and pull do the right thing without extra params.

cheers,


martin
