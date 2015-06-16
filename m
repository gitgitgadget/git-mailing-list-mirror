From: Eric Raible <raible@nextest.com>
Subject: Visualizing merge conflicts after the fact (using kdiff3)
Date: Mon, 15 Jun 2015 18:17:17 -0700
Message-ID: <557F791D.3080003@nextest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 16 03:22:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4faP-0006Hh-KA
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 03:22:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754967AbbFPBWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 21:22:36 -0400
Received: from exchange.domain1.nextest.com ([12.96.234.114]:48971 "EHLO
	Hermes.DOMAIN1.nextest.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752479AbbFPBWf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Jun 2015 21:22:35 -0400
X-Greylist: delayed 316 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jun 2015 21:22:35 EDT
Received: from [131.101.149.78] (131.101.149.78) by HERMES.DOMAIN1.nextest.com
 (131.101.21.61) with Microsoft SMTP Server id 8.3.327.1; Mon, 15 Jun 2015
 18:17:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271738>

I'm running 1.9.5.msysgit.1, but this is a general git question...

Upon returning from a vacation, I was looking at what people had been
up to, and discovered on merge in which a colleague had resolved a merge
incorrectly.  It turns out that he has pushed *many* merges over the past
year which had conflicts in my code, and now I don't trust any of them.

So naturally I want to check each of them for correctness.

I know about "git log -p -cc SHA -- path", but it really doesn't
show just the conflicts so there's just too much noise in that output.

I use kdiff3 to resolve conflicts, so I'm looking for a way to
visualize these already-resolved conflicts with that tool.
As I said, there are many merges, so the prospect of checking
out each sha, doing the merge, and then comparing the results
is completely untenable.

Can anyone help?  Surely other people have wanted to review how
conflicts were resolved w/out looking at the noise of unconflicted
changes, right?

Thanks - Eric (raible at gmail )
