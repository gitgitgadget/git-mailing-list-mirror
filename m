From: greened@obbligato.org
Subject: libgit2 status
Date: Fri, 24 Aug 2012 09:02:43 -0500
Message-ID: <87a9xkqtfg.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 24 16:04:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4uUU-0001Ue-7Q
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 16:04:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484Ab2HXODc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 10:03:32 -0400
Received: from li209-253.members.linode.com ([173.255.199.253]:40112 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932440Ab2HXODA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 10:03:00 -0400
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.77)
	(envelope-from <greened@obbligato.org>)
	id 1T4uZV-0003xd-Tw
	for git@vger.kernel.org; Fri, 24 Aug 2012 09:09:14 -0500
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  What is the status of libgit2 WRT the overall git project?
    I recall that there was some discussion of basing bits of git on libgit2
   once it matures. I ask because I'm starting a project to improve the abysmal
    speed of git-subtree split. It's unbearably slow at the moment and as far
    as I can puzzle out it's due almost entirely to repeated subshell invocations
    to run git commands. [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- ------------- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204210>

What is the status of libgit2 WRT the overall git project?  I recall
that there was some discussion of basing bits of git on libgit2 once it
matures.

I ask because I'm starting a project to improve the abysmal speed of
git-subtree split.  It's unbearably slow at the moment and as far as I
can puzzle out it's due almost entirely to repeated subshell invocations
to run git commands.

I was planning on doing some experiments rewriting bits of git-subtree
using libgit2 but I want to make sure that that isn't wasted work.  It
appears to be exactly what I need to code bits of git-subtree natively.

Thoughts?

                        -Dave
