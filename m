From: Bahadir Balban <bahadir.balban@gmail.com>
Subject: reverting back both working copy and commits
Date: Wed, 11 Jan 2006 16:32:16 +0000
Message-ID: <7ac1e90c0601110832u6fc3a3bcwb7e584445610e53f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Jan 11 19:41:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwkuE-0003cz-4G
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 19:41:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbWAKSkt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 13:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751720AbWAKSkt
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 13:40:49 -0500
Received: from nproxy.gmail.com ([64.233.182.204]:502 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751716AbWAKSke convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 13:40:34 -0500
Received: by nproxy.gmail.com with SMTP id o25so139958nfa
        for <git@vger.kernel.org>; Wed, 11 Jan 2006 10:40:33 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=t2fInVFMbL/wPYIbXNhl9gpSHa4dCkMJLltRnzg/95+zjXOXboZSq0dSAvdlYTELW05DtS77M4nEo4kKbBU/2NapB5h01sVMzjpk3W7743E0SpzTPBLumBZjQFnEPTj9x2/P+DT/lPi7j9lLItBkcGfAbJx4EPB+/DVH2kiCJSg=
Received: by 10.49.58.9 with SMTP id l9mr61689nfk;
        Wed, 11 Jan 2006 08:32:19 -0800 (PST)
Received: by 10.48.30.15 with HTTP; Wed, 11 Jan 2006 08:32:16 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14496>

Hi,

I made some commits that later on I wanted to cancel. I did:

% git-branch master-2006-get-rid-of-commits

% git-reset --hard [sha1id]

where sha1id is the id of commit I want to revert back to. After this,
git-log points at the right commit (the one with [sha1id]) as the last
commit made. However, the working copy is left in the original state,
i.e with the unwanted changes.. How do I also revert the working
sources into an earlier state.

Because git-commit says "nothing to change" at this stage, git
checkout -f does not cure my problem. How do I also revert working
copy to earlier commit?

Thanks,
Bahadir
