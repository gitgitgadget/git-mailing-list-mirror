From: Bahadir Balban <bahadir.balban@gmail.com>
Subject: Cancelling certain commits
Date: Mon, 16 Jan 2006 13:57:03 +0000
Message-ID: <7ac1e90c0601160557r78599886nca9be9b6672a1bd7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Jan 16 14:57:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyUr9-0002pA-BU
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 14:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWAPN5G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 08:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWAPN5G
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 08:57:06 -0500
Received: from uproxy.gmail.com ([66.249.92.205]:12886 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750765AbWAPN5F convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2006 08:57:05 -0500
Received: by uproxy.gmail.com with SMTP id s2so658748uge
        for <git@vger.kernel.org>; Mon, 16 Jan 2006 05:57:03 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pxZ94jFviN1Blk/GSPVn9exL2CR5CbN+J2teGpviYCS3G7c9Q/jPHR8nFMzUXMl0QFf0qLv9EPRLzO1Tpy2A3uzNF6EXwThv/Ny+IqXu1Z6t8Q5jyPRz0oc7wfEf1XzhIu6/AgP+CvRz66904XUR7SA14AgM+r3icNgg3rjhuJs=
Received: by 10.48.247.7 with SMTP id u7mr246364nfh;
        Mon, 16 Jan 2006 05:57:03 -0800 (PST)
Received: by 10.48.30.15 with HTTP; Mon, 16 Jan 2006 05:57:03 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14744>

Hi,

If I'm not happy with the changes I made in certain commits during
development, how do I cancel those commits and remove them from git
records most cleanly?

For example if I did commits 1 to 10, and want to get rid of commit 3
and 7, such that, the other commits are irrelevant to changes made in
3 and 7, but may involve changes in the same file as 3 and 7 changed,
how do I handle it?

Furthermore, how would I handle it if there was a commit 4, that
depended partially on commit 3? (For example if it uses a type that
was changed in commit 3?) Would I hand-edit commit 4 to fix it?

Many thanks,
Bahadir
