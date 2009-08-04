From: Seba Illingworth <seba.illingworth@gmail.com>
Subject: difftool, open all diff files immediately, not in serial
Date: Tue, 4 Aug 2009 20:49:04 +0000 (UTC)
Message-ID: <loom.20090804T204107-117@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 22:55:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYR2f-00045f-KL
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 22:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657AbZHDUzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 16:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755327AbZHDUzM
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 16:55:12 -0400
Received: from main.gmane.org ([80.91.229.2]:47648 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754300AbZHDUzI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 16:55:08 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1MYR2E-0005Xh-I2
	for git@vger.kernel.org; Tue, 04 Aug 2009 20:55:03 +0000
Received: from 125-239-26-189.jetstream.xtra.co.nz ([125.239.26.189])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 20:55:02 +0000
Received: from seba.illingworth by 125-239-26-189.jetstream.xtra.co.nz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 20:55:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 125.239.26.189 (Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US) AppleWebKit/530.5 (KHTML, like Gecko) Chrome/2.0.172.39 Safari/530.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124807>

The default git diff behavior is to open each diff file in serial 
(wait for previous file to be closed before opening next file).

I'm looking for a way to open all the files at once - in BeyondCompare 
for example this would open all the files in tabs within the same BC window.

This would make it easier to review a complex set of changes; 
flick back and forwards between the diff files and ignore 
unimportant files.

Here's my same question on StackOverflow with a couple of ideas 
I have found (copy files to temp dir and do folder diff, Araxis 
has 'nowait' option): 
http://stackoverflow.com/questions/1220309

--Seba
