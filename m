From: Luben Tuikov <ltuikov@yahoo.com>
Subject: git pull on a branch semantics
Date: Sun, 22 Jan 2006 12:58:51 -0800 (PST)
Message-ID: <20060122205852.255.qmail@web31812.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sun Jan 22 21:59:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0mIZ-0007I0-Vj
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 21:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWAVU6x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jan 2006 15:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWAVU6x
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jan 2006 15:58:53 -0500
Received: from web31812.mail.mud.yahoo.com ([68.142.207.75]:1939 "HELO
	web31812.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751356AbWAVU6x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jan 2006 15:58:53 -0500
Received: (qmail 257 invoked by uid 60001); 22 Jan 2006 20:58:52 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=w9c2gyAEw0bumur28l0yS5ITeeRB8e2j7BVegNskQ8frDLuD+JLykl6gTKvxlBer+UD68J3Y3SyHfZINSV9ySmjx+QTmqrU4sIMT6wFZRslYe44srEqSbOZpl/OV8mZzAhyG8vLj9ta4UAUWuFzm/NnhLx2y5P4EvZwQtVYRFDM=  ;
Received: from [65.74.248.133] by web31812.mail.mud.yahoo.com via HTTP; Sun, 22 Jan 2006 12:58:51 PST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15063>

Hi,

pwd is a git repo; current branch is A; there's a few
branches in this git repo.
In .git/remotes/ I've a file name "projectC", which looks like:

URL:<url>
Pull:projectC:projectC
Push:projectC:projectC

That is both here and remotely I've projectC being a branch
here and remotely.

I'd like to pull changes to projectC only, from the remote projectC to the local projectC, but my
current branch is A.

I blissfully do:

git pull projectC

git correctly tells me that the heads are the same in
branchC here and remote, but it then goes ahead to merge
projectC in the current branch A (project A) since they
have a common ancestor.

But because of the "Pull" line in .git/remotes/projectC
what the intention was is to pull from projectC remotely
and merge any new changes in projectC locally, and only
in projectC (irrespective of what the current branch
is (in the pwd)).

Is this behavior a bug or is this a "feature"?

Thanks,
   Luben
