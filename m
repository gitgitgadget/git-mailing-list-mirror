From: "Joe Fiorini" <joe@faithfulgeek.org>
Subject: git-svn rebase "problems"
Date: Sun, 30 Nov 2008 22:17:56 -0500
Message-ID: <73fd69b50811301917j6535f289uf177976707914e46@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 01 04:19:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6zJZ-0004Kl-Jm
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 04:19:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798AbYLADR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 22:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752789AbYLADR5
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 22:17:57 -0500
Received: from wf-out-1314.google.com ([209.85.200.169]:54844 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777AbYLADR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 22:17:57 -0500
Received: by wf-out-1314.google.com with SMTP id 27so2448909wfd.4
        for <git@vger.kernel.org>; Sun, 30 Nov 2008 19:17:56 -0800 (PST)
Received: by 10.143.12.20 with SMTP id p20mr4329263wfi.169.1228101476075;
        Sun, 30 Nov 2008 19:17:56 -0800 (PST)
Received: by 10.142.82.4 with HTTP; Sun, 30 Nov 2008 19:17:56 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101998>

I'm having some problems with git svn rebase. I'm pretty sure this is
just the way git works, not a problem per se. But it's causing trouble
for me and my team.
My team is currently on Subversion. I'm trying to convince some people
that git is a good way to go.

So I'm using git-svn. My team tends to commit to the svn server fairly
often. It has happened more than once that, because git svn rebase
applies each svn commit sequentially, some of the commits will
conflict with each other - whether or not I have ever touched the
file. Obviously, this is a big problem because if I've never touched
the file, then I probably won't know exactly how to resolve the merge
(the merge markers haven't been solely reliable).

Is there anything I could do to get around this without having to
merge code I'm unfamiliar with?

Thanks all!
Joe Fiorini
--
joe fiorini
http://www.faithfulgeek.org
// freelancing & knowledge sharing
