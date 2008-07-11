From: ff <ff@member.org>
Subject: how to undo a git merge?
Date: Fri, 11 Jul 2008 12:16:15 -0400
Message-ID: <fa7d16350807110916x689e316fr6bae01f28e2e1acb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 11 18:17:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHLJ5-0005fc-L2
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 18:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753624AbYGKQQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 12:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753711AbYGKQQS
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 12:16:18 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:15877 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753582AbYGKQQR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 12:16:17 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1932084ywe.1
        for <git@vger.kernel.org>; Fri, 11 Jul 2008 09:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=nBqKklPpFLIC1pnER94JgkjBNJioReWNrfHW1ZnyBX4=;
        b=LjAr7c3K3R52QKnX9uA4cvTk0IL0ymoiJVf7ZMHWPrVgmXSkByyZJrncx8Vx8wuUia
         rigFQKwUVWGvuU5i/dNzz3BqVcgRVgOLCC48PC9YQHCJcElwZjw2/FUxtXEPY31Ar0WG
         oaSaLB5lUPERcCcsyLPtVxGSHtbNNM+RupNBw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=EL5slzKGv6kOcVdvCGaDua59jIMdJZEBikOl2K9LU5rqCpoObDkuuruweZHa6Z53VR
         BkwOqEp7d74ee2LLxEEFy4F8shdKJjo4WHYh12rSR+AK/9Ob9qOmCEVitCqEx1jtoSf7
         DDP/JQVIv6VXMEqRcezyPHoRkSlGLdQxYM87E=
Received: by 10.115.91.2 with SMTP id t2mr14174822wal.62.1215792975906;
        Fri, 11 Jul 2008 09:16:15 -0700 (PDT)
Received: by 10.141.91.21 with HTTP; Fri, 11 Jul 2008 09:16:15 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 0da68d3adade4a32
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88138>

Hello,

I'm a git lover with a question.

I have two git branches that stem from the same exact master branch.
Many commits happened independently on these two branches overtime.
Then, I inadvertently did a merge from one branch into another. The branch
where I merged into now has mixed commits, and also a commit for the merge
itself. I then had more commits added to the branch that I merged into.

Now I would like to revert the merge... what is the best way of doing that?
I would like very much to use something like git-revert <merge_commit_id>
But that does not seem to work.

Any help/pointers of an example illustrating solution to this case
would be greatly
appreciated!

Regards,

-- ff@member.org
