From: Thomas Koch <thomas@koch.ro>
Subject: git svn should refuse to checkin .svn directories
Date: Fri, 18 Apr 2008 13:46:50 +0200
Message-ID: <200804181346.50755.thomas@koch.ro>
Reply-To: thomas@koch.ro
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 19 15:45:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jmp4Y-0000Co-K8
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 13:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbYDRLrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2008 07:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752493AbYDRLrP
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Apr 2008 07:47:15 -0400
Received: from koch.ro ([195.34.83.107]:52367 "EHLO
	ve825703057.providerbox.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752588AbYDRLrO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Apr 2008 07:47:14 -0400
Received: from 217-162-251-183.dclient.hispeed.ch ([217.162.251.183] helo=localhost)
	by ve825703057.providerbox.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <thomas@koch.ro>)
	id 1Jmp3L-0006om-Iu
	for git@vger.kernel.org; Fri, 18 Apr 2008 13:46:55 +0200
User-Agent: KMail/1.9.9
Content-Disposition: inline
X-Spam_score: -1.4
X-Spam_score_int: -13
X-Spam_bar: -
X-Spam_report: Spam detection software, running on the system "ve825703057.providerbox.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  As you might guess I just annoyed my collegues by (temporarily)
	destroying our svn repo. Nobody could checkout anymore, because I accidently
	checked in a .svn directory with git svn. I'm lucky that I'm still allowed
	to use git svn to work on our svn repo... [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.8 ALL_TRUSTED            Passed through trusted hosts only via SMTP
	1.9 TVD_RCVD_IP    
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79889>

As you might guess I just annoyed my collegues by (temporarily) destroying our 
svn repo. Nobody could checkout anymore, because I accidently checked in 
a .svn directory with git svn.

I'm lucky that I'm still allowed to use git svn to work on our svn repo...

Maybe you could add a warning or something else to avoid .svn directories to 
be ever checked in via git svn.

I'm sure that there is also a config option somewhere to get .svn directories 
ignored (also subdirs when adding the parent dir?). But this check should 
really be a default setting to avoid other newcommers to get into trouble 
because they gave git svn a try.


Cheers,
-- 
Thomas Koch, Software Developer
http://www.koch.ro
