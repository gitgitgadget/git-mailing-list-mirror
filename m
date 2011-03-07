From: Dun Peal <dunpealer@gmail.com>
Subject: Is there a way to add a default `--squash` flag for all merges into a head?
Date: Mon, 7 Mar 2011 11:28:09 -0800 (PST)
Message-ID: <9f02bed0-fa18-46b1-a3d3-346e1cc7dc01@k15g2000prk.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 07 20:41:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwgIi-0005XO-6E
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 20:41:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755850Ab1CGTk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 14:40:58 -0500
Received: from mail-yi0-f56.google.com ([209.85.218.56]:35282 "EHLO
	mail-yi0-f56.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755821Ab1CGTk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 14:40:57 -0500
X-Greylist: delayed 768 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Mar 2011 14:40:57 EST
Received: by yib17 with SMTP id 17so3384713yib.1
        for <git@vger.kernel.org>; Mon, 07 Mar 2011 11:40:56 -0800 (PST)
Received: by 10.91.208.16 with SMTP id k16mr438241agq.28.1299526089172; Mon,
 07 Mar 2011 11:28:09 -0800 (PST)
Received: by k15g2000prk.googlegroups.com with HTTP; Mon, 7 Mar 2011 11:28:09
 -0800 (PST)
X-IP: 66.250.141.150
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13)
 Gecko/20101203 Firefox/3.6.13,gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168608>

Hi,

Our main Git repository supports a lot of developers working on
multiple branches from master. Whenever the work on a branch is
finished, the branch-owning developer(s) merge it back to master. That
merge is always done with a `--squash` flag to avoid the 50+ levels
deep graph we would end up with if everyone just used a true merge.

There's a configuration feaute `branch.<name>.rebase` for specifying
that all merges into a branch (master in this case) would be done by
rebase, so I was expecting a similar feature for always squashing back
(since some developers may forget to add the flag). Unfortunately, I
couldn't find it. Does it exist?

Thanks, D.
