From: Stepan Kasal <kasal@ucw.cz>
Subject: Eliminate curl binary
Date: Tue, 3 Jun 2008 12:53:23 +0200
Organization: <)><
Message-ID: <20080603105323.GA15825@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 13:01:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3UGE-0000sg-VN
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 13:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbYFCLAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 07:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbYFCLAK
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 07:00:10 -0400
Received: from ppp1053.in.ipex.cz ([212.71.160.53]:48530 "EHLO
	ppp1053.in.ipex.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbYFCLAI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 07:00:08 -0400
X-Greylist: delayed 404 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Jun 2008 07:00:08 EDT
Received: from ppp1053.in.ipex.cz (camelia.ucw.cz [127.0.0.1])
	by ppp1053.in.ipex.cz (8.14.2/8.13.8) with ESMTP id m53ArNZo015920
	for <git@vger.kernel.org>; Tue, 3 Jun 2008 12:53:23 +0200
Received: (from kasal@localhost)
	by ppp1053.in.ipex.cz (8.14.2/8.13.8/Submit) id m53ArN7w015919
	for git@vger.kernel.org; Tue, 3 Jun 2008 12:53:23 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83638>

Hello,

git source code uses curl (the binary) on exactly one spot:
git-clone.sh
I would welcome if that spot were rewritten so that git would no
longer require curl, only libcurl.

(I clashed with a design flaw of curl cmd-line interfaace, so I'd
like to uninstalle it.  ;-)  Nothing against libcurl.)

I apologize that I'm not providing a patch, and hope that this quick
bug report (enhancement request) is better than doing nothing.

OTOH, I might write a patch later, so quick hints are welcome.
(A git-* binary shall be called insted of curl in git-clone.sh; shall
it be written from scratch, or is there a git-*.c source which can be
bended for this purpose?)

Have a nice day,
	Stepan Kasal
