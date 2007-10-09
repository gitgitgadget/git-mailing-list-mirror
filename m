From: Michele Ballabio <barra_cuda@katamail.com>
Subject: Two minor glitches in git-gui
Date: Tue, 9 Oct 2007 11:21:59 +0200
Message-ID: <200710091121.59422.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 09 11:18:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfBEO-0006V1-DC
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 11:18:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbXJIJSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 05:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbXJIJSO
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 05:18:14 -0400
Received: from slim-3c.inet.it ([213.92.5.125]:35870 "EHLO slim-3c.inet.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751280AbXJIJSN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 05:18:13 -0400
Received: from host190-56-static.104-80-b.business.telecomitalia.it ([::ffff:80.104.56.190]) by slim-3c.inet.it via I-SMTP-5.4.4-547
	id ::ffff:80.104.56.190+4sPyubaVsP6; Tue, 09 Oct 2007 11:18:09 +0200
User-Agent: KMail/1.9.7
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60372>

On Linux:
  1. run git-gui
  2. open edit->options dialog box
  3. click on "select font". It will open the "choose font" box.
  4. click on "options" box to give it focus.
  5. return to the "choose font" box and try to choose a font.

At this point, the "choose font" box won't react to my actions.

The workaround is to iconify the "select font" dialog box and
then restore it. Can someone reproduce this?

I think I've seen a similar behaviour before, on git-gui's
about window, but I'm not sure (it doesn't trigger anymore).

The other problem is that it is possible to open the same
"choose font" box many times (one is enough :).
