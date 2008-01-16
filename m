From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: Re: [RFC/PATCH] Remove repo-config
Date: Wed, 16 Jan 2008 21:47:33 +0100
Message-ID: <200801162147.33448.kumbayo84@arcor.de>
References: <1200453554-14163-1-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>,
	Karl =?iso-8859-1?q?Hasselstr=F6m?= <kha@treskal.com>
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 21:57:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFFKM-00021S-6t
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 21:57:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbYAPU5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 15:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbYAPU5G
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 15:57:06 -0500
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:34980 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751484AbYAPU5F (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 15:57:05 -0500
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 3EF9B32EC10;
	Wed, 16 Jan 2008 21:57:03 +0100 (CET)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id 3081B2D37DB;
	Wed, 16 Jan 2008 21:57:03 +0100 (CET)
Received: from fnoheim52.netpark.at (fnoheim52.netpark.at [83.68.151.52])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id E1A6E212F62;
	Wed, 16 Jan 2008 21:57:02 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <1200453554-14163-1-git-send-email-dpmcgee@gmail.com>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.92/5487/Wed Jan 16 19:21:33 2008 on mail-in-01.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70746>

On Mittwoch 16 Januar 2008, Dan McGee wrote:
> 'git config' has been used in place of 'git repo-config' for some time in
> the documentation and most of the tools, so remove traces of repo-config
> from the source.
> 
> Signed-off-by: Dan McGee <dpmcgee@gmail.com>
> ---
> 
> Mainly a request for comment, but I sent this patch becuase I noticed
> repo-config is not even listed in command-list.txt. Before the 1.5.4 release,
> I would think it either needs to be listed there or removed entirely.
> 
> Looking forward to 1.5.5, is there any reason to keep an old command like
> this around? It is rarely used and needlessly complicates things, and the
> manpage did nothing but send you to config anyway.
> 
I don't know if this should impact removing schedule, but stgit 0.14.1
(and the current development version) uses "git repo-config" instead of "git config"
in stgit/config.py and certain tests

will post a patch for this as a reply
> All tests pass on Linux 2.6.23.
> 
> -Dan
Greetings Peter
PS: i hope it is ok to add stgit people to CC
