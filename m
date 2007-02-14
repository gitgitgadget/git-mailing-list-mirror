From: Bill Lear <rael@zopyra.com>
Subject: Re: Error converting from 1.4.4.1 to 1.5.0?
Date: Wed, 14 Feb 2007 11:20:47 -0600
Message-ID: <17875.17647.74882.218627@lisa.zopyra.com>
References: <17875.13564.622087.63653@lisa.zopyra.com>
	<7vhctor78j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 18:21:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHNoU-0000To-Rt
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 18:21:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbXBNRU5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 12:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbXBNRU5
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 12:20:57 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61488 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814AbXBNRU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 12:20:57 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1EHKtW00652;
	Wed, 14 Feb 2007 11:20:55 -0600
In-Reply-To: <7vhctor78j.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39695>

On Wednesday, February 14, 2007 at 09:15:08 (-0800) Junio C Hamano writes:
>Bill Lear <rael@zopyra.com> writes:
>
>> I then did a commit, and something went wrong:
>>
>> % git commit -a -m "Nuke CVS Id strings"
>> error: Could not read ab66b31e390889e6bcbb2002111e2803c51f42b5
>> error: unable to read tree object HEAD
>> # On branch master
>> error: Could not read ab66b31e390889e6bcbb2002111e2803c51f42b5
>> error: unable to read tree object HEAD
>
>Does 1.4.4 find that object?  What's in HEAD (cat .git/HEAD)?
>What does "git fsck-objects --full" report?

% cat .git/HEAD
ref: refs/heads/master

% git --version
git version 1.5.0-dirty

% git fsck-objects --full
error: Packfile .git/objects/pack/pack-23d1a9af78b4b78d1f3750cf70f83cb91a20ba64.pack SHA1 mismatch with itself
fatal: failed to find delta-pack base object 90bad0d280a6d7c155bbd9582b35ffcf5e3bdd27

% /usr/bin/git --version
git version 1.4.4.1

% /usr/bin/git fsck-objects --full
error: Packfile .git/objects/pack/pack-23d1a9af78b4b78d1f3750cf70f83cb91a20ba64.pack SHA1 mismatch with itself
fatal: failed to find delta-pack base object 90bad0d280a6d7c155bbd9582b35ffcf5e3bdd27

So, all I did was try to do a commit with the new git ... haven't
recloned, or pulled from upstream...



Bill
