From: walt <w41ter@gmail.com>
Subject: git-bisect not working correctly in the kvm.git repository?
Date: Mon, 17 Nov 2008 09:27:15 -0800
Message-ID: <gfs9hn$hq9$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 17 18:29:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L27u9-0003aA-5H
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 18:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648AbYKQR1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 12:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752467AbYKQR1h
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 12:27:37 -0500
Received: from main.gmane.org ([80.91.229.2]:51116 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752451AbYKQR1h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 12:27:37 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1L27sq-0006PD-6u
	for git@vger.kernel.org; Mon, 17 Nov 2008 17:27:32 +0000
Received: from adsl-69-234-203-176.dsl.irvnca.pacbell.net ([69.234.203.176])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 17 Nov 2008 17:27:32 +0000
Received: from w41ter by adsl-69-234-203-176.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 17 Nov 2008 17:27:32 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-203-176.dsl.irvnca.pacbell.net
User-Agent: Thunderbird/3.0a2pre (X11; 2008111706)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101236>

I'm trying to find a bug introduced somewhere between kvm-69
and kvm-70, so of course I want to git-bisect down to it.

The weirdness is that when I give git-bisect the good and
bad tags, almost everything in my working directory just
disappears, leaving only the qemu subdirectory behind.

Can anyone else reproduce this with the kvm.git repo?
(I don't see this problem with the linux.git repo or the
git.git repo, so it seems to be something with the kvm.git
repo itself.)

Thanks!
