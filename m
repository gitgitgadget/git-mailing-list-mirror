From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Questions on 'cvs migration guide''
Date: Fri, 19 Aug 2005 15:17:22 +1200
Message-ID: <46a038f9050818201717f9ed93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Aug 19 05:18:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5xNo-0003DJ-4T
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 05:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbVHSDRX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 23:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbVHSDRX
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 23:17:23 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:54960 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751012AbVHSDRX convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2005 23:17:23 -0400
Received: by rproxy.gmail.com with SMTP id i8so431025rne
        for <git@vger.kernel.org>; Thu, 18 Aug 2005 20:17:22 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qZ+4x6bOIlCZGgGdEE+do5P5UiTaLteyUzaidY88eTMk6wL5wj6KF913bYP4I/0f/UX/1RHa+TPdvdUwb2V8wswD3CO68kBWVast+TdnApqPobzBEhDpi3Hi/DFMdUmrTiNQNV9x6D81BHCwl54jk0PIBVwqLS89h5p2bEpuvP4=
Received: by 10.38.11.4 with SMTP id 4mr849045rnk;
        Thu, 18 Aug 2005 20:17:22 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Thu, 18 Aug 2005 20:17:22 -0700 (PDT)
To: GIT <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

In the section 'Emulating CVS behaviour', where the team setup is
described with a team 'merger'. What is not clear is how to deal with
project-wide branches. Should they be created in the master repo, and
everyone clone a new repo from it?

With a team of 10 people, and perhaps 4 or 5 branches, the setup to
pull stuff back seems messy.

And yet another question: the teammember who is pulling must 'switch'
the merging repo to the right branch, pull from the corresponding
remote repos of each teammember, and push to the public view of the
repo. Is that right?

cheers,


martin
