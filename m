From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: Suggestion: "man git clone"
Date: Fri, 22 Aug 2008 13:02:57 +0200
Message-ID: <g8m6d1$7nf$1@ger.gmane.org>
References: <48ACB29C.7000606@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 13:04:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWURJ-0005w6-5f
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 13:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753755AbYHVLDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 07:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753551AbYHVLDR
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 07:03:17 -0400
Received: from main.gmane.org ([80.91.229.2]:56810 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753346AbYHVLDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 07:03:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KWUQ5-000716-JA
	for git@vger.kernel.org; Fri, 22 Aug 2008 11:03:05 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 11:03:05 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 11:03:05 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <48ACB29C.7000606@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93282>

H. Peter Anvin venit, vidit, dixit 21.08.2008 02:11:
> Given the recent change of "git-foo" to "git foo", it would be really 
> nice if one could type, for example:
> 
> 	man git clone
> 
> and actually get the man page for the git clone command.  There are 
> quite a few other pieces of software which also could benefit from that 
> kind of indirection.
> 
> Right now the above command shows the man page git(1) followed by 
> clone(2), which I believe has be classified as utterly useless behaviour...

The discussion seems to show that altering man and relying on the new
behaviour is no option, and neither is playing games with man's section
options.

How about:

- Change all references inside git (warnings etc) from "man git-bla" to
"git help bla".

- Change all references in the help pages (gitlinks) accordingly.

- Put a warning in the main git man page which redirects the confused
("If you were looking for the manpage of "git bla" and issued "man git
bla", please refer to "man git-bla" or "git help bla".'), maybe just
before the command list there.

This could be supported by an alias mapping "git man" to "git help -m".

I've heard about some other SCMs which have only "scm help bla", so this
suggestion would be in-line with common usage. [Not that git would have
to learn from other SCM's ;) ]

Michael
