From: Woody Wu <narkewoody@gmail.com>
Subject: How to specify remote branch correctly
Date: Mon, 17 Dec 2012 02:30:00 +0000 (UTC)
Message-ID: <slrnkct0r3.dsp.narkewoody@zuhnb712.local.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 17 04:40:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkRYr-0001Fj-2S
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 04:40:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086Ab2LQDjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 22:39:55 -0500
Received: from plane.gmane.org ([80.91.229.3]:47559 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750989Ab2LQDjy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 22:39:54 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TkRYh-00019E-AY
	for git@vger.kernel.org; Mon, 17 Dec 2012 04:40:03 +0100
Received: from 59.37.26.98 ([59.37.26.98])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 17 Dec 2012 04:40:03 +0100
Received: from narkewoody by 59.37.26.98 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 17 Dec 2012 04:40:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 59.37.26.98
User-Agent: slrn/0.9.9p1 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211624>

Hi, List

I have two branches in the remote, say, origin/master, origin/foo.  Then
when I tried to switch to the remote foo branch, the following two
methods gave me different results:

1. git checkout foo
2. git checkout origin/foo

The first method run silently with success, but the second method
complains that I got a 'detached HEAD'.  So, I think I don't understand
the difference between 'foo' and 'origin/foo'.  Can someone give me a
hint?

Supposing I have another remote defined in .git/config that points
to another repository but also have a same name branch, say
'remote-x/foo', how do I tell git which 'foo' I want to switch to?

The similar problem also exists for 'fetch' command to me.  From the man
page, I don't find answer of how to specify which remote I am going to
fetch from. Can you help me?

Thanks in advance.


-- 
woody
I can't go back to yesterday - because I was a different person then.
