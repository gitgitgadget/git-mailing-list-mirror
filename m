From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: Extremely simple Vim interface for Git
Date: Sun, 7 Sep 2008 16:59:52 +0300
Message-ID: <20080907135952.GD3387@mithlond.arda.local>
References: <20080906193744.GA3122@mithlond.arda.local> <18071eea0809070623v4a54cbb8j2face0724651ef56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Adam <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 07 16:02:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcKp3-0001WB-H9
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 16:01:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753724AbYIGN7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 09:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753734AbYIGN7z
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 09:59:55 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:35502 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753683AbYIGN7y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 09:59:54 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni1.inet.fi (8.5.014)
        id 488F153401D592A0; Sun, 7 Sep 2008 16:59:52 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1KcKnw-0002lQ-AC; Sun, 07 Sep 2008 16:59:52 +0300
Content-Disposition: inline
In-Reply-To: <18071eea0809070623v4a54cbb8j2face0724651ef56@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95141>

Thomas Adam wrote (2008-09-07 14:23 +0100):

> 2008/9/6 Teemu Likonen <tlikonen@iki.fi>:
> > Here's a very simple idea for using Git from Vim editor. Add these lines
> > to your ~/.vimrc file:
> >
> >
> >    command! -complete=file -nargs=* Git   call s:RunShellCommand('git '.<q-args>)
> >    command! -complete=file -nargs=* Svn   call s:RunShellCommand('svn '.<q-args>)
> >    command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)
> 
> Looks interesting.  Have you seen this though:
> 
> http://code.google.com/p/vcscommand/

I have tried it but I made my own because I'm familiar with git's 
command line interface and want to use it inside Vim without (too many) 
restrictions. I find this approach easier because I don't need to learn 
another interface layer.

I'd like to add a hint that Vim command line expands % to current file 
name. Examples:

    :Git add %
    :Git blame -C %
