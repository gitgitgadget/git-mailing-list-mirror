From: Lane Brooks <lane@brooks.nu>
Subject: How to manage merges from one line while excluding its merges from
 another
Date: Fri, 25 Jun 2010 16:26:36 -0600
Message-ID: <4C252D1C.4010702@brooks.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 26 01:31:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSIMk-0006Uq-Hv
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 01:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756990Ab0FYXbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 19:31:17 -0400
Received: from mail.ubixum.com ([65.111.161.108]:50780 "EHLO ubixum.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756987Ab0FYXbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jun 2010 19:31:16 -0400
X-Greylist: delayed 3873 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Jun 2010 19:31:16 EDT
Received: from c-98-202-126-209.hsd1.ut.comcast.net ([98.202.126.209] helo=dome.lane.brooks.nu)
	by ubixum.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <lane@ubixum.com>)
	id 1OSHM5-0001Sp-CB
	for git@vger.kernel.org; Fri, 25 Jun 2010 15:26:40 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10) Gecko/20100621 Fedora/3.0.5-1.fc13 Thunderbird/3.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149713>

I have a tree like this:

      G---H---I---J---K   devel
     /       /       /
A---B---C---D---E---F    main
         \
          L---M---N---O   my


The 'my' branch forked off the 'main' line and for reasons out of my 
control cannot merge the 'main' changes (D,E,F) back.

The 'devel' line is a another line that I need to track and merge from, 
but I only want the changes local to that branch that are not on from 
the mainline. i.e., I only want commits G,H,J.

I want to continue to merge from the devel line as additional commits
are made that are not on the main branch, but I do not want any of the 
future merge commits.

Is there an automated way to do this or do I have to cherry pick 
everything by hand?

Thanks,
Lane
