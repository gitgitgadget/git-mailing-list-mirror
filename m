From: jateeq <jawad_atiq@hotmail.com>
Subject: Creating a tarball out of a directory in a bare git repository
Date: Mon, 1 Mar 2010 14:47:45 -0800 (PST)
Message-ID: <27750115.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 01 23:47:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmEP5-0005YY-5y
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 23:47:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895Ab0CAWrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 17:47:46 -0500
Received: from kuber.nabble.com ([216.139.236.158]:45108 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603Ab0CAWrp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 17:47:45 -0500
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1NmEOv-0000uT-2y
	for git@vger.kernel.org; Mon, 01 Mar 2010 14:47:45 -0800
X-Nabble-From: jawad_atiq@hotmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141365>


Hello,

I am developing a web interface, part of which allows the user to download a
tarball of a directory (which is in a bare repostitory on the filesystem) on
clicking on a link.

This is how I am planning on doing it. Just wanted to assess whether this is
efficient enough, or if anyone knows of a better way. I haven't tried this
out yet though, so I don't know if it will work at all.

- list all the files/folders in the directory (i have the sha1 hash of the
directory)
- foreach file in the directory, get the file contents (recurse if there are
further subdirectories). Probably store the result in an array. 
- create a file somewhere on the filesystem out of each file output above.
Store it under the directory name.
- create a tarball out of the 'working' directory as usual.

I was wondering if I can get away without having to create a working version
out of the bare version of the directory (create each file in the directory
and store it somewhere on the filesystem), and then compress it as usual.

I hope someone has a much simpler answer to this problem!

Thanks,
Jawad.
-- 
View this message in context: http://old.nabble.com/Creating-a-tarball-out-of-a-directory-in-a-bare-git-repository-tp27750115p27750115.html
Sent from the git mailing list archive at Nabble.com.
