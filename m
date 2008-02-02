From: walt <wa1ter@myrealbox.com>
Subject: New behavior for git-branch?
Date: Sat, 02 Feb 2008 08:57:52 -0800
Organization: none
Message-ID: <fo27d0$gs7$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 17:57:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLLgZ-0001Om-Iv
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 17:57:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbYBBQ5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 11:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbYBBQ5P
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 11:57:15 -0500
Received: from main.gmane.org ([80.91.229.2]:57949 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750800AbYBBQ5O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 11:57:14 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JLLfy-0002dA-CM
	for git@vger.kernel.org; Sat, 02 Feb 2008 16:57:10 +0000
Received: from adsl-69-234-214-138.dsl.irvnca.pacbell.net ([69.234.214.138])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 16:57:10 +0000
Received: from wa1ter by adsl-69-234-214-138.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 16:57:10 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-214-138.dsl.irvnca.pacbell.net
User-Agent: Thunderbird 3.0a1pre (X11/2008020106)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72287>

Hi,

I've been tracking Junio's git repository for a year or two
and I've used git-bisect many times, but yesterday I got very
disoriented while using git-bisect and git-branch together.
I think I was confused by the output of 'git-branch -v'.

As an example of the new behavior of git-branch, here is what
I see this morning after pulling from Linus:

$git-branch -v
* master ae9458d Merge git://git.infradead.org/battery-2.6
   origin 8af03e7 Merge branch 'for-2.6.25' of git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc

(I discovered the -a flag just this morning.)

$git-branch -av
* master        ae9458d Merge git://git.infradead.org/battery-2.6
   origin        8af03e7 Merge branch 'for-2.6.25' of git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc
   origin/master aa62999 x86: fix bootup crash in native_read_tsc()

In my confusion yesterday, I think I created a new 'origin' which
has nothing to do with Linus' repository -- but I'm not sure.

The old behavior of 'git-branch' always listed 'origin' as well
as 'master', but (I think?) that 'origin' is no longer displayed
using just -v.  Is this correct?  If so, what would be the right
way to un-bollocks my local repository?
