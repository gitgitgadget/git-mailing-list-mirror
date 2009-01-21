From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Merging adjacent deleted lines?
Date: Wed, 21 Jan 2009 20:49:55 +0100
Message-ID: <200901212049.55556.robin.rosenberg.lists@dewire.com>
References: <57518fd10901211120n62f8d0e9ya8595fc9baa6476c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 20:52:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPj7N-0003AL-DT
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 20:52:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbZAUTuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 14:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbZAUTuk
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 14:50:40 -0500
Received: from mail.dewire.com ([83.140.172.130]:2507 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750AbZAUTuj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 14:50:39 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id BF268147E6CF;
	Wed, 21 Jan 2009 20:50:36 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FxA6CblNCMPD; Wed, 21 Jan 2009 20:50:36 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id EBD1E147E63E;
	Wed, 21 Jan 2009 20:50:35 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <57518fd10901211120n62f8d0e9ya8595fc9baa6476c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106655>

onsdag 21 januari 2009 20:20:50 skrev Jonathan del Strother:
[...]
> So, it looks like I need to be way more careful when merging
> conflicts.  Which leads me to - what tools do you use when studying
> conflicts like that?  git blame seems the obvious one, for getting the
> context of each deletion, but it seems like I need to run it once as
> git blame HEAD lines, and once as git blame MERGE_HEAD lines.  Is
> there something a little more integrated for comparing the origin of
> each change from both merge branches simultaneously?
> 
> Would welcome any thoughts on how you guys approach conflict-resolution

I think you've illustrated a case for graphical merge resolution tools, i.e.
run git mergetool to help resolve the conlicts. It will run a graphical tool
for you.

The list seems to be: kdiff3 kdiff3 tkdiff xxdiff meld gvimdiff opendiff emerge vimdiff

None of the tools can run blame in the merge tool also. That would be nice.

-- robin
