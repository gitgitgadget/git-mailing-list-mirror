From: amillican <amillican@cogentsystems.com>
Subject: Making git work with new remote server
Date: Mon, 3 May 2010 08:59:34 -0700 (PDT)
Message-ID: <28436896.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 03 17:59:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8y3Z-0000Kz-Qr
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 17:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932974Ab0ECP7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 11:59:35 -0400
Received: from kuber.nabble.com ([216.139.236.158]:42482 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932902Ab0ECP7f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 11:59:35 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1O8y3S-0005yh-5g
	for git@vger.kernel.org; Mon, 03 May 2010 08:59:34 -0700
X-Nabble-From: amillican@cogentsystems.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146240>


  0  vote down  star
	

I am the CM person for a small company that just started using Git. We have
two Git repositories currently hosted on a Windows box that is our
all-purpose Windows server. But, we just set up a dedicated server for our
CM software on an Ubuntu Linux server named "Callisto".

So I created a test Git repository on Callisto. I gave its directory all of
the proper permissions recursively. I had the sysadmin create a login for me
on Callisto, and I created a key to use for logging in via SSH. I set up my
key to use a passphrase; I don't know if that could be contributing to my
problems? Anyway, I know my SSH login works because I tested it through
puTTY.

But, even after hours of trials and head scratching, I can't get my Windows
Git bash (mSysGit) to talk to Callisto for the purposes of pushing or
pulling Callisto's git repository files. Obviously, when trying a push, I've
been trying to log into my Callisto account using SSH.

I keep getting "Fatal error. The remote end hung up unexpectedly." And I've
even gotten the error that Git doesn't recognize the test repository on
Callisto as a git repository. I read online that the "Fatal error...hung up
unexpectedly" is usually a problem with the server connection or
permissions. So what am I missing or overlooking here? And why doesn't a
pull using the git:// protocol work, since that only uses read-only access?
Group and public permissions for the git repository's directory on Callisto
are set to read and execute, but not write.

If anyone could help, I would be so grateful. Thank you.
-- 
View this message in context: http://old.nabble.com/Making-git-work-with-new-remote-server-tp28436896p28436896.html
Sent from the git mailing list archive at Nabble.com.
