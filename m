From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Publishing Question: First time Pushing to nonexsiting directory
Date: Mon, 19 Feb 2007 08:35:26 +0100
Message-ID: <20070219073526.GA26531@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 19 08:56:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJ3No-0003BF-23
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 08:56:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbXBSH4M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 02:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbXBSH4M
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 02:56:12 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:59396 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750726AbXBSH4L (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Feb 2007 02:56:11 -0500
X-Greylist: delayed 1244 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Feb 2007 02:56:11 EST
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 320053F385; Mon, 19 Feb 2007 08:35:26 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.11-2006-07-11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40101>

Hello,
I thought that there is a command available which I can use to push a
repository to a remote nonexisting location (that gets created on the
fly) like in the following scenario:

        - Create a git project on my laptop
        - Check in a few files
        - Publish the git repository to 

        (thinkpad) [~/work/astro-tg] git push 131.188.30.59:/home/cip/adm/sithglan/work/repositories/private/astro/
        fatal: '/home/cip/adm/sithglan/work/repositories/private/astro': unable to chdir or not a git archive
        fatal: The remote end hung up unexpectedly

I thought that I read a comment from Linus(?) long time ago to how to obtain
that. But I am unable to find the e-mail in my archives. If there is no
standard way, how do you do it? Just rsync the files and change the
'origin'?

        Thomas
