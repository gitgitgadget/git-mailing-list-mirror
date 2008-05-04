From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: OSX, ZFS, UTF8, git - somebody hates me in this list
Date: Sun, 04 May 2008 14:56:54 -0700
Message-ID: <86skwxd97d.fsf@blue.stonehenge.com>
References: <86wsm9dbhk.fsf@blue.stonehenge.com>
	<20080504215208.GG29038@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun May 04 23:57:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsmDH-0001XD-Dk
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 23:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033AbYEDV44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 17:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753128AbYEDV44
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 17:56:56 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:42138 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095AbYEDV4z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 17:56:55 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id BC6E91DE232; Sun,  4 May 2008 14:56:54 -0700 (PDT)
x-mayan-date: Long count = 12.19.15.5.8; tzolkin = 2 Lamat; haab = 11 Uo
In-Reply-To: <20080504215208.GG29038@spearce.org> (Shawn O. Pearce's message of "Sun, 4 May 2008 17:52:08 -0400")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81203>

>>>>> "Shawn" == Shawn O Pearce <spearce@spearce.org> writes:

Shawn> "Randal L. Schwartz" <merlyn@stonehenge.com> wrote:
>> 
>> repeat by:
>> 0) download the OSX ZFS drivers
>> 1) Make a ZFS partition on OSX.
>> 2) Clone git.git to the ZFS partition
>> 3) immediately type git-status:
>> 
>> # On branch master
>> # Untracked files:
>> #   (use "git add <file>..." to include in what will be committed)
>> #
>> #       "gitweb/test/Ma\314\210rchen"
>> nothing added to commit but untracked files present (use "git add" to track)

Shawn> Isn't this just the normal HFS+ name mangling?

I don't recall having this problem on HFS+.

But, oh, it's because my git.git is on a UFS partition.  So UFS works
fine.  Why shouldn't ZFS (which will be closer to UFS than HFS+)
be the same?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discussion
