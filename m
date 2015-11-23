From: Daniel Fahlke <flyingmana@cotya.com>
Subject: add support for --show-signature in gitk
Date: Mon, 23 Nov 2015 13:16:26 +0100
Message-ID: <5653039A.1000203@cotya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 23 13:23:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0q9S-0003cW-1u
	for gcvg-git-2@plane.gmane.org; Mon, 23 Nov 2015 13:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753281AbbKWMXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2015 07:23:17 -0500
Received: from mailserv.regfish.com ([79.140.61.33]:42582 "EHLO
	mailserv.regfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752852AbbKWMXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2015 07:23:16 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Nov 2015 07:23:16 EST
Received: (qmail 17637 invoked from network); 23 Nov 2015 12:16:35 -0000
Received: from f055197149.adsl.alicedsl.de (HELO [192.168.0.103]) (49250-0001@[78.55.197.149])
          (envelope-sender <flyingmana@cotya.com>)
          by mailserv.regfish.com (qmail-ldap-1.03) with AES128-SHA encrypted SMTP
          for <git@vger.kernel.org>; 23 Nov 2015 12:16:35 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281582>

Hi,

the cli command `git log --show-signatures` has the nice feature of
showing additional informations for signed commits.
I want to add this informations into the gitk view of a commit.

I already have finished a first draft of this here
https://github.com/Flyingmana/git/commit/21a93f15e65765bfa98a28538da641877aa9843a
This only works, when gitk is called together with --show-signature, so
my question now is, how to best add it, and should I add it as config
like the "display nearby tags/heads" one?

I also think about adding it to the commit list somehow, but have no
idea yet how it would fit in a good way there.

Now I hope for a bit of feedback if it is the right direction, or if
there is another attempt to prefer.
