From: Thomas Koch <thomas@koch.ro>
Subject: Re: git svn rebase does not call post-update hook
Date: Thu, 25 Sep 2008 09:25:32 +0200
Message-ID: <200809250925.32194.thomas@koch.ro>
Reply-To: thomas@koch.ro
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 25 09:26:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KilFU-0008Fn-Nw
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 09:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbYIYHZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 03:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbYIYHZn
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 03:25:43 -0400
Received: from koch.ro ([195.34.83.107]:38667 "EHLO
	ve825703057.providerbox.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751630AbYIYHZn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Sep 2008 03:25:43 -0400
Received: from 163-0.1-85.cust.bluewin.ch ([85.1.0.163] helo=noname)
	by ve825703057.providerbox.net with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <thomas@koch.ro>)
	id 1KilEG-0002Pv-1x
	for git@vger.kernel.org; Thu, 25 Sep 2008 09:25:36 +0200
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96730>

I think, I've found a kind of answer to my question in this thread:

http://kerneltrap.org/mailarchive/git/2008/8/2/2791714

It says, IMHO,  that it is not intended, to call a hook during git svn
rebase, since git svn commands are always operating on your local repo
and one could easily wrap these commands in a custom script to do
whatever necessary before or after the git svn command.

Am Tuesday 23 September 2008 15:45:46 schrieben Sie:
> Hi,
>
> I've followed a blogpost[1] on how to set up a GIT mirror of a SVN repo.
> It works just fine, only that I've called the post-update hook manually
> so far. It won't get called by "git svn rebase".
> Yes, it is executable.
> Yes, git svn rebase does fetch updates and rebases master.
>
> [1] http://gsocblog.jsharpe.net/archives/12
>
> Thanks for your bandwidth,



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
