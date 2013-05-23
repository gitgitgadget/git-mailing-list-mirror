From: Alois Mahdal <Alois.Mahdal.1-ndmail@zxcvb.cz>
Subject: --follow is ignored when used with --reverse
Date: Fri, 24 May 2013 01:23:24 +0200
Message-ID: <20130524012324.295dec77@hugo.daonet.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 24 01:28:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufevw-0006KK-JK
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 01:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759917Ab3EWX22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 19:28:28 -0400
Received: from mail.profitux.cz ([82.208.47.184]:39146 "EHLO mail.profitux.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759888Ab3EWX21 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 19:28:27 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 May 2013 19:28:27 EDT
Received: from hugo.daonet.home ([::ffff:89.177.135.96])
  (AUTH: LOGIN alois.mahdal.1-ndmail@zxcvb.cz, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by mail.profitux.cz with esmtp; Fri, 24 May 2013 01:22:44 +0200
  id 0000000001160681.00000000519EA4C4.0000516A
X-Mailer: Claws Mail 3.9.1 (GTK+ 2.24.17; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225319>

Hello!

This [has been reported][1] to this list about half a year ago
but with no response so I'm  not even sure if it's been
acknowledged as bug.

  [1]: http://marc.info/?l=git&m=135215709307126&q=raw

When I use `git log --follow file` all is OK, but once I add
`--reverse` to it, it no longer follows the file beyond renames.

This makes it hard to query for when the file was really added,
which I was trying to achieve with

    $ git -1 --reverse --follow several_times_renamed_file

Is this going to be fixed?

Thanks,
aL.

-- 
Alois Mahdal
