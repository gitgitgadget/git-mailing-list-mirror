From: Aaron Schrab <aaron@schrab.com>
Subject: Strange behaviour of git diff branch1 ... branch2
Date: Fri, 26 Oct 2012 17:26:50 -0400
Message-ID: <20121026212650.GB2612@pug.qqx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 26 23:38:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRrbS-0006VC-NG
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 23:38:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933851Ab2JZVhx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 17:37:53 -0400
Received: from pug.qqx.org ([50.116.43.67]:59065 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757361Ab2JZVhw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 17:37:52 -0400
X-Greylist: delayed 661 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Oct 2012 17:37:52 EDT
Received: by pug.qqx.org (Postfix, from userid 1000)
	id F3A2157DE5; Fri, 26 Oct 2012 17:26:50 -0400 (EDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208492>

I came across this odd question on stackoverflow:
	http://stackoverflow.com/q/13092854/1507392


If git diff is run with "..." as a separate argument between two 
commit-ish arguments causes it to produce strange output.  The 
differences seem to be the same as if "..." was left out, but change 
lines begin with 4 + or - characters rather than just 1.

Can anybody explain what is happening here?  I don't have any reason to 
want to use that form myself, but I'm very curious about why it produces 
this odd output.

Thanks.
