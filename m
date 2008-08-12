From: Thomas Koch <thomas@koch.ro>
Subject: tried submodules and corrupted repo
Date: Tue, 12 Aug 2008 10:09:38 +0200
Organization: Young Media Concepts
Message-ID: <200808121009.38941.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 12 10:47:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSpXC-0002oq-Hc
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 10:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029AbYHLIqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 04:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbYHLIqM
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 04:46:12 -0400
Received: from koch.ro ([195.34.83.107]:42477 "EHLO
	ve825703057.providerbox.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751993AbYHLIqL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Aug 2008 04:46:11 -0400
Received: from 217-162-251-183.dclient.hispeed.ch ([217.162.251.183] helo=jona.local)
	by ve825703057.providerbox.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <thomas@koch.ro>)
	id 1KSowz-0007uh-6j
	for git@vger.kernel.org; Tue, 12 Aug 2008 10:09:54 +0200
User-Agent: KMail/1.9.9
Content-Disposition: inline
X-Spam_score: -2.3
X-Spam_score_int: -22
X-Spam_bar: --
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92082>

Hi,

in my trial to use a submodule, it seems that I messed up my repo.

I've put both repos at
http://git.koch.ro
clone url is
http://git.koch.ro/git/REPONAME

I wanted to have the git-php-wrapper repo as a submodule inside wigit,
which did not work at all. I always ended up with a git-php-wrapper
subdir and a .git inside it, but no workdir files.

Now I wanted to start from scratch, to clone wigit again to my local
machine. But when I try
git clone http://git.koch.ro/git/wigit
it says:
Initialized empty Git repository in /var/checkouts/wigit/.git/
warning: remote HEAD refers to nonexistent ref, unable to checkout.

Is there a way to resque my wigit repo? And how to get the submodule
working afterwards? 

Best regards,
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
