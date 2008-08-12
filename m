From: Thomas Koch <thomas@koch.ro>
Subject: Re: tried submodules and corrupted repo
Date: Tue, 12 Aug 2008 14:42:14 +0200
Message-ID: <200808121442.14990.thomas@koch.ro>
Reply-To: thomas@koch.ro
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 12 14:44:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KStEI-0008Of-P6
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 14:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435AbYHLMm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 08:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752543AbYHLMm7
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 08:42:59 -0400
Received: from koch.ro ([195.34.83.107]:48019 "EHLO
	ve825703057.providerbox.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752315AbYHLMm6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Aug 2008 08:42:58 -0400
Received: from 217-162-251-183.dclient.hispeed.ch ([217.162.251.183] helo=jona.local)
	by ve825703057.providerbox.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <thomas@koch.ro>)
	id 1KStCl-0003eE-0N
	for git@vger.kernel.org; Tue, 12 Aug 2008 14:42:28 +0200
Content-Disposition: inline
X-Spam_score: -2.3
X-Spam_score_int: -22
X-Spam_bar: --
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92091>

Am Dienstag 12 August 2008 10:09:38 schrieben Sie:
> Hi,
>
> in my trial to use a submodule, it seems that I messed up my repo.
>
> I've put both repos at
> http://git.koch.ro
> clone url is
> http://git.koch.ro/git/REPONAME
>
> I wanted to have the git-php-wrapper repo as a submodule inside wigit,
> which did not work at all. I always ended up with a git-php-wrapper
> subdir and a .git inside it, but no workdir files.
>
> Now I wanted to start from scratch, to clone wigit again to my local
> machine. But when I try
> git clone http://git.koch.ro/git/wigit
> it says:
> Initialized empty Git repository in /var/checkouts/wigit/.git/
> warning: remote HEAD refers to nonexistent ref, unable to checkout.
>
> Is there a way to resque my wigit repo? And how to get the submodule
> working afterwards?
>
> Best regards,

It seems that all my problems araised, because I did not set up my GIT
repo server properly. I forgot to make post-commit executable which runs
git-update-server-info.

Sorry for the noise.
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
