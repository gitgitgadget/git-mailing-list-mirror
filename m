From: greened@obbligato.org
Subject: Not a git repository: '.'
Date: Sat, 24 Mar 2012 12:26:09 -0500
Message-ID: <87r4wh6hce.fsf@smith.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 24 18:29:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBUmf-0000cn-M2
	for gcvg-git-2@plane.gmane.org; Sat, 24 Mar 2012 18:29:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754952Ab2CXR3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Mar 2012 13:29:41 -0400
Received: from li209-253.members.linode.com ([173.255.199.253]:35996 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754310Ab2CXR3k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2012 13:29:40 -0400
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=smith.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.77)
	(envelope-from <greened@obbligato.org>)
	id 1SBR3F-0006yk-1o
	for git@vger.kernel.org; Sat, 24 Mar 2012 08:30:37 -0500
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  I have a post-receive hook set up that does the following
   when something is pushed to a repository. - Change directory to another non-bare
    repository - Do 'git status' I get this error from the original git push:
    [...] 
 Content analysis details:   (1.4 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
  2.4 DATE_IN_FUTURE_03_06   Date: is 3 to 6 hours after Received: d 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193834>

I have a post-receive hook set up that does the following when something
is pushed to a repository.

- Change directory to another non-bare repository
- Do 'git status'

I get this error from the original git push:

remote: fatal: Not a git repository: '.'

Debug output tells me I am in the correct directory when attempting the
status check.  This directory is a full git workarea (i.e. not a bare
repository).

Any idea what git is complaining about?  I can log on to the server and
do 'git status' in the target directory and everything is fine.

                            -Dave
