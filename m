From: Thomas Koch <thomas@koch.ro>
Subject: git svn rebase does not call post-update hook
Date: Tue, 23 Sep 2008 15:45:46 +0200
Organization: Young Media Concepts
Message-ID: <200809231545.46371.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 23 15:47:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki8EF-0005l1-Nc
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 15:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbYIWNpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 09:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbYIWNpv
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 09:45:51 -0400
Received: from koch.ro ([195.34.83.107]:55251 "EHLO
	ve825703057.providerbox.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751445AbYIWNpv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Sep 2008 09:45:51 -0400
Received: from 217-162-251-183.dclient.hispeed.ch ([217.162.251.183] helo=jona.local)
	by ve825703057.providerbox.net with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <thomas@koch.ro>)
	id 1Ki8D2-0006Hm-07
	for git@vger.kernel.org; Tue, 23 Sep 2008 15:45:44 +0200
User-Agent: KMail/1.9.9
X-Face: ##Diipbu!WHqpJ%Eb+k:m;]n%VcrM\f\MJ-:0\<0.r?ULf7g"kC!"Cg,o;D]
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96562>

Hi,

I've followed a blogpost[1] on how to set up a GIT mirror of a SVN repo.
It works just fine, only that I've called the post-update hook manually
so far. It won't get called by "git svn rebase".
Yes, it is executable.
Yes, git svn rebase does fetch updates and rebases master.

[1] http://gsocblog.jsharpe.net/archives/12

Thanks for your bandwidth,
-- 
Thomas Koch, Software Developer
http://www.koch.ro

Young Media Concepts GmbH
Sonnenstr. 4
CH-8280 Kreuzlingen
Switzerland

Tel    +41 (0)71 / 508 24 86
Fax    +41 (0)71 / 560 53 89
Mobile +49 (0)170 / 753 89 16
Web    www.ymc.ch
