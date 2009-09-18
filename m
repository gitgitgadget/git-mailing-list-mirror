From: Michael Andreen <harv@ruin.nu>
Subject: Re: very slow "git gc --aggressive" in GIT-1.6.4.4
Date: Fri, 18 Sep 2009 21:56:56 +0200
Message-ID: <200909182156.56587.harv@ruin.nu>
References: <ee2a733e0909181223j1ffc99edkdb3700adb37fa147@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: SLONIK.AZ@gmail.com
X-From: git-owner@vger.kernel.org Fri Sep 18 22:06:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mojin-0002PW-LO
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 22:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758159AbZIRUF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2009 16:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758147AbZIRUF5
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Sep 2009 16:05:57 -0400
Received: from wave.csbnet.se ([95.80.42.189]:53513 "EHLO wave.csbnet.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758144AbZIRUF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2009 16:05:57 -0400
X-Greylist: delayed 543 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2009 16:05:57 EDT
Received: from river.localnet (river.csbnet.se [95.80.42.188])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by wave.csbnet.se (Postfix) with ESMTPSA id 229C223EE52;
	Fri, 18 Sep 2009 21:56:58 +0200 (CEST)
User-Agent: KMail/1.12.1 (Linux/2.6.28-gentoo-r4; KDE/4.3.1; x86_64; ; )
In-Reply-To: <ee2a733e0909181223j1ffc99edkdb3700adb37fa147@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128810>

On Friday 18 September 2009 21:23:59 Leo Razoumov wrote:
> I noticed that "git gc --agressive" takes 5 times longer with
> git-1.6.4.4 than with git-1.6.2.5.
> 
> Below are benchmarks on my Linux Ubuntu-9.04 laptop (Core2 Duo 2.54GHz).
> As a test repo I use a mirror of the official GIT upstream.

git-1.6.3 and later changed the settings for --aggressive to window=250 and 
depth=250, which produces a tighter pack. The earlier setting wasn't really 
aggressive.

/Michael
