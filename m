From: =?UTF-8?B?Sm9uYXMgRmxvZMOpbg==?= <jonas.floden@gmail.com>
Subject: git mergetool from next not working in subdirectory
Date: Fri, 30 Jan 2009 14:05:45 +0100
Message-ID: <glutv9$4b1$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 30 14:07:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSt5l-0003Kq-NV
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 14:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583AbZA3NGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 08:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752533AbZA3NGD
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 08:06:03 -0500
Received: from main.gmane.org ([80.91.229.2]:57043 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752229AbZA3NGA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 08:06:00 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LSt4E-0002RF-Vv
	for git@vger.kernel.org; Fri, 30 Jan 2009 13:05:54 +0000
Received: from c-10a5e155.260-1-64736c10.cust.bredbandsbolaget.se ([85.225.165.16])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 13:05:54 +0000
Received: from jonas.floden by c-10a5e155.260-1-64736c10.cust.bredbandsbolaget.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 13:05:54 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c-10a5e155.260-1-64736c10.cust.bredbandsbolaget.se
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107809>

Hi,

I just upgraded to the current 'next' version of git
(v1.6.1.2-418-gd79e69c). When I run git mergetool from
a subdirectory in my workspace I get the following output:
(with obfuscated output..)

~/src/rep/subdir $ git mergetool
Merging the files: a/b/file.c

git checkout-index: subdir/subdir/a/b/file.c is not in the cache
git checkout-index: subdir/subdir/a/b/file.c is not in the cache
git checkout-index: subdir/subdir/a/b/file.c is not in the cache
Normal merge conflict for 'a/b/file.c':
  {local}: modified

  {remote}: modified

Hit return to start merge resolution tool (kdiff3):

When I hit enter the merge resolution finishes right away
and the file ends up empty.

Note how subdir is duplicated in the output above.

This works perfectly fine with the 'master' version (1.6.1.2-253-ga34a).

Regards,
Jonas
