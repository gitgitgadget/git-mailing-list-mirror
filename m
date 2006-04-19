From: David Tweed <tweed314@yahoo.co.uk>
Subject: using git on flash media
Date: Thu, 20 Apr 2006 00:31:25 +0100 (BST)
Message-ID: <20060419233125.89318.qmail@web86912.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: tweed314@yahoo.co.uk
X-From: git-owner@vger.kernel.org Thu Apr 20 01:31:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWM91-0004En-8n
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 01:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWDSXbc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 19:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWDSXbb
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 19:31:31 -0400
Received: from web86912.mail.ukl.yahoo.com ([217.146.177.84]:40883 "HELO
	web86912.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751320AbWDSXbb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Apr 2006 19:31:31 -0400
Received: (qmail 89320 invoked by uid 60001); 19 Apr 2006 23:31:25 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.uk;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=fSUYTEGFQe7wG2hk8UtoYf4v5IkemAYBvjnLmO8sbLsK2Z9mbpR90TWSVV8cIM2Rbz8W8DvL957g/cbMAHRtNHVB+y5pUQ8P6gXImN4pTLl1lEd3Lq0N25YFmBZ4ltRp9//Anbe1kdtGWJJsJVdAi4NDjDGfwCONDqP7FBRumwM=  ;
Received: from [134.225.1.161] by web86912.mail.ukl.yahoo.com via HTTP; Thu, 20 Apr 2006 00:31:25 BST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18949>

I was wondering if anyone here could answer two silly
questions arising from a lack of knowledge about the
precise architecture of git (unfortunately
websearching "using git flash" turns up pages about
miserable people and Macromedia):

Is it reasonable to use git reasonably intensively
keeping it's database on a flash media drive? (Ie, the
flash drive is plugged into a standard desktop machine
and the "actual versions" of the file that're being
managed are on the machine's hard disc, but all of the
git repository data are on a flash media drive. What
I'm basically checking is that it doesn't, I dunno,
rewrite files so frequently that on a modern flash
drive it would wear out the entire drive unreasonably
quickly.

Likewise, supposing that there are several machines
with the same filesystem tree devoted to the
git-chronicled project. Supposing you've got a careful
user who checks out the latest tree from the flash
drive into the machine's hard disk upon sitting down
at one of these machines, and commits to the flash
drive & properly umounts the flash before pulling it
out. The user does this switching between several
machines randomly. (So the git repository on flash
acts to ensure that whenever I sit down at a machine
I'm presented with my latest versions of everything.)
Is there any obvious problem that could come up which
could lead to git getting confused and somehow
corrupting the archive contents on the flash drive?
(Not the kind of catastrophic loss thing that'd be
caught by taking regular backups but some corruption
that'd silently make parts of the repository
un-checkoutable in the main flash repository.) I'm
trying to imagine some program somehow getting
confused and somehow writing some vital piece of
repository data to the "current" hard disc without
realising that means it's not "always readable all the
time", unlike the flash drive proper.

(I know the answer probably ought to be "just make all
the machines networked and communicate via the network
rather than a flash drive", but assume I'm not
amenable to changing.)

Many thanks for any insight,

cheers, david tweed


Send instant messages to your online friends http://uk.messenger.yahoo.com 
