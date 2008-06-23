From: "Edward Z. Yang" <edwardzyang@thewritingpot.com>
Subject: Re: core.autocrlf and merge conflict output
Date: Sun, 22 Jun 2008 22:23:59 -0400
Message-ID: <485F093F.8020300@thewritingpot.com>
References: <g3miho$se5$1@ger.gmane.org> <7vy74xj7ww.fsf@gitster.siamese.dyndns.org> <g3mvbh$mmj$1@ger.gmane.org> <alpine.DEB.1.00.0806230259140.6439@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 04:25:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAbjr-0002h3-FM
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 04:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920AbYFWCYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 22:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753726AbYFWCYG
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 22:24:06 -0400
Received: from main.gmane.org ([80.91.229.2]:44112 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753581AbYFWCYE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 22:24:04 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KAbiq-0005Q4-3c
	for git@vger.kernel.org; Mon, 23 Jun 2008 02:24:00 +0000
Received: from ool-18e45099.dyn.optonline.net ([24.228.80.153])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jun 2008 02:24:00 +0000
Received: from edwardzyang by ool-18e45099.dyn.optonline.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jun 2008 02:24:00 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ool-18e45099.dyn.optonline.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041206 Thunderbird/1.0 Mnenhy/0.6.0.104
In-Reply-To: <alpine.DEB.1.00.0806230259140.6439@racer>
X-Enigmail-Version: 0.95.6
OpenPGP: id=869C48DA;
	url=http://www.thewritingpot.com/gpgpubkey.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85829>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Johannes Schindelin wrote:
> Funny.  And I thought 1.5.6 contained that patch...  Because 1.5.6 was 
> merged by Steffen recently, and announced on both the msysgit list as well 
> as this one.

And I'm wrong once again. My git checkout was on a detached head and
wasn't updating (apparently, I'm no good at reading error messages).
Switching back to master, pulling and then re-compiling fixed it.

While 99% of this is my fault, there might be a bug in netinstall.
However, I'm going to take that one to the msysgit list.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIXwk/qTO+fYacSNoRAkIhAJ9LU6jH5ThQbu0tSjmkbp7ynEyh5wCdHvbJ
pFVPllbiXjfLrgEYuY+uVlM=
=ZxbH
-----END PGP SIGNATURE-----
