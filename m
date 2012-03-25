From: greened@obbligato.org
Subject: git-subtree Next Round Ready
Date: Sun, 25 Mar 2012 17:06:06 -0500
Message-ID: <87398we3ox.fsf@smith.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 26 00:10:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBvdn-0004pn-3c
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 00:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249Ab2CYWKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Mar 2012 18:10:15 -0400
Received: from li209-253.members.linode.com ([173.255.199.253]:36256 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932220Ab2CYWKO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2012 18:10:14 -0400
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=smith.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.77)
	(envelope-from <greened@obbligato.org>)
	id 1SBru4-0000kD-H9
	for git@vger.kernel.org; Sun, 25 Mar 2012 13:11:06 -0500
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Ok, I've cleaned things up with git-subtree so the changes
    I had to the test infrastructure are gone. No changes to upstream are needed
    to support git-subtree in contrib/ now. As usual, the branches are here:
   [...] 
 Content analysis details:   (1.4 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
  2.4 DATE_IN_FUTURE_03_06   Date: is 3 to 6 hours after Received: date
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193885>

Ok, I've cleaned things up with git-subtree so the changes I had to the
test infrastructure are gone.  No changes to upstream are needed to
support git-subtree in contrib/ now.

As usual, the branches are here:

git://sources.obbligato.org/git/git.git

gitweb here: http://sources.obbligato.org/?p=git.git;a=summary

There are three branches.  master is the usual.  "subtree-latest" is my
version of git-subtree cleaned up for upstreaming into contrib/.  This
is the pure git-subtree history, ready to be subtree merged.
"subtree-integrated" is a version of upstream git.git with
subtree-latest merged as a subtree (done via git-subtree!).

I assume it will be easier to have Junio or another integrator do the
subtree merge from subtree-latest in his or her workarea but I provide
subtree-integrated so everyone can easily check out what it will look
like.

Let me know of anything else you need.

Thanks!

                         -Dave
