From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Git commit error: fatal: Repository has been updated, but
	unable to write new_index file.
Date: Tue, 15 May 2012 23:36:55 +0200
Message-ID: <20120515213648.GA66983@book.hvoigt.net>
References: <34E530A4-A792-42AC-8C19-5F7CB71FA46C@jetbrains.com> <jks9k9$c35$1@dough.gmane.org> <20120327122045.GA7421@ikke-laptop.buyways.nl> <loom.20120515T082415-300@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sylvain <syllant@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 15 23:37:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUPQU-0003U9-Lp
	for gcvg-git-2@plane.gmane.org; Tue, 15 May 2012 23:37:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757032Ab2EOVg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 May 2012 17:36:58 -0400
Received: from t2784.greatnet.de ([83.133.105.219]:40275 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754405Ab2EOVg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2012 17:36:57 -0400
Received: (qmail 6781 invoked from network); 15 May 2012 21:36:55 -0000
Received: from localhost (127.0.0.1)
  by darksea.de with SMTP; 15 May 2012 21:36:55 -0000
Content-Disposition: inline
In-Reply-To: <loom.20120515T082415-300@post.gmane.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197857>

Hi,

On Tue, May 15, 2012 at 06:34:31AM +0000, Sylvain wrote:
> I'm also experiencing this issue (msysGit 1.7.10-preview20120409 + TortoiseGit 
> 1.7.9.0 + Intellij IDEA 11).
> 
> Don't you think it could be related to parallel usage of msysGit + TortoiseGit?
> 
> I.e. after committing with msysGit (through IDEA or not), TortoiseGit would 
> launch a background operation (such as updating index) that would mess with 
> msysGit?
> 
> Just a guess, I don't know internal behaviour of msysGit/TortoiseGit.

This is the wrong list for msysgit please see 

http://groups.google.com/group/msysgit

My guess is that some other program (your virus scanner or IDE ?) is
blocking writing on the index file. In msysgits git gui and the command
line we have a retry fallback that asks you whether you want to try
again. I do not know TortoiseGit I guess that they do not have such
thing and just fail.

Cheers Heiko
