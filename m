From: Stephen Bannasch <stephen.bannasch@deanbrook.org>
Subject: Re: svn svn returning 'fatal: Not a valid object name' on sourceforge svn repo
Date: Sun, 6 Dec 2009 12:49:18 -0500
Message-ID: <p06240802c7419ec49cd5@[192.168.1.106]>
References: <p0624081ac73dd6a1aaff@[63.138.152.192]> <20091205224950.GC2120@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Dec 06 18:49:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHLEx-0001Bc-Lg
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 18:49:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756972AbZLFRtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 12:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756964AbZLFRtf
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 12:49:35 -0500
Received: from deanbrook.org ([72.52.70.192]:53677 "HELO deanbrook.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756929AbZLFRtf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 12:49:35 -0500
Received: from ::ffff:71.123.118.50 ([71.123.118.50]) by deanbrook.org for <git@vger.kernel.org>; Sun, 6 Dec 2009 09:49:40 -0800
In-Reply-To: <20091205224950.GC2120@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134681>

At 2:49 PM -0800 12/5/09, Eric Wong wrote:
>Stephen Bannasch <stephen.bannasch@deanbrook.org> wrote:
>> I use git svn often and normally it works fine.
>>
>> I getting a fatal error trying to clone the asciimathm svn repo at sourceforge:
>>
>> $ git svn clone --trunk=trunk --branches=branches http://asciimathml.svn.sourceforge.net/svnroot/asciimathml asciimathml-svn-git
>> fatal: Not a valid object name
> > ls-tree -z  ./: command returned error: 128
>
>Passing the "-r4:HEAD" parameter to "git svn clone" should work.  It
>looks like the repository was initially miscreated and "trunk" was a
>symlink (and not a directory) in r1.

Thanks Eric, your suggestion worked.

How could you tell the first svn commit was a symlink?
