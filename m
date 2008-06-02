From: Robert Haines <rhaines@manchester.ac.uk>
Subject: Pushing an --amend-ed commit
Date: Mon, 2 Jun 2008 10:51:47 +0100
Message-ID: <6B355924-0EA9-4AF8-B051-F17FC4530495@manchester.ac.uk>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 02 12:11:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K370u-0004nt-Ty
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 12:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038AbYFBKKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 06:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbYFBKKr
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 06:10:47 -0400
Received: from clarity.mcc.ac.uk ([130.88.200.144]:60605 "EHLO
	clarity.mcc.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbYFBKKr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 06:10:47 -0400
X-Greylist: delayed 1141 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Jun 2008 06:10:47 EDT
Received: from gomwe.mcc.ac.uk ([10.2.18.2])
	by clarity.mcc.ac.uk with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <rhaines@manchester.ac.uk>)
	id 1K36hc-000BEt-Ej; Mon, 02 Jun 2008 10:51:44 +0100
Received: from leela.rcs.manchester.ac.uk ([130.88.1.66]:51154)
	by gomwe.mcc.ac.uk with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69 (FreeBSD))
	(envelope-from <rhaines@manchester.ac.uk>)
	id 1K36hc-0007F3-BO; Mon, 02 Jun 2008 10:51:44 +0100
X-Mailer: Apple Mail (2.924)
X-Authenticated-Sender: Robert Haines from leela.rcs.manchester.ac.uk [130.88.1.66]:51154
X-Authenticated-From: Robert.Haines@manchester.ac.uk
X-UoM: Scanned by the University Mail System. See http://www.itservices.manchester.ac.uk/email/filtering/information/ for details.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83506>

Hi list,

The other day I did the classic:

1) Right, changes all done and committed. Push to public repo.
2) Bugger, missed out an obvious one-liner in a Makefile. Make change  
and --amend that last commit.
3) Push to public repo again... Ah, "Not a strict subset" error, can't  
push...

It's obvious (I think) to me why I get this error - the commit now has  
a different hash so it looks like it would be the wrong thing to do to  
allow the push as far as git is concerned. Right?

So, is it safe to "use the --force" in this instance when pushing?  
This should just replace the old commit with the --amended commit with  
no side-effects, shouldn't it?

Thanks,
Rob

-- 
Robert Haines

Research Associate, RealityGrid          Tel. : +44 (0)161 275 6067
Research Computing Services              Fax. : +44 (0)161 275 0637
University of Manchester                 Email: rhaines@manchester.ac.uk
Oxford Road                              Web  : www.realitygrid.org
Manchester, M13 9PL, UK                       : www.rcs.manchester.ac.uk
