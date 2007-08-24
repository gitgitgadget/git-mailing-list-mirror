From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb-projects
Date: Fri, 24 Aug 2007 02:08:24 +0200
Organization: At home
Message-ID: <fal7gn$2vf$1@sea.gmane.org>
References: <9e4733910708231438q4c454686p55cef622e61d6a2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 24 02:08:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOMig-0005Z0-Cg
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 02:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761807AbXHXAIH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 20:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755945AbXHXAIG
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 20:08:06 -0400
Received: from main.gmane.org ([80.91.229.2]:45276 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754129AbXHXAIF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 20:08:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IOMiU-0007gh-0b
	for git@vger.kernel.org; Fri, 24 Aug 2007 02:07:58 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 24 Aug 2007 02:07:58 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 24 Aug 2007 02:07:58 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56540>

[Cc: Jon Smirl <jonsmirl@gmail.com>, git@vger.kernel.org]

Jon Smirl wrote:

> What is the magic incantation for encoding an email address along with
> the project owner name? From the source I see these strings need to be
> URL encoded (it doesn't seem to be in the doc)

It is mentioned in gitweb/INSTALL, in the "Gitweb repositories" section

> but now I'm getting XML errors.
>
> I tried this:
> mpc5200b.git Jon+Smirl+%3Cjonsmirl%2664%3Bgmail.com%3E

I guess that this might have nothing to do with URL-encoding of projects
index file, but with proper escaping in the gitweb, i.e. the string is
not wrapped in esc_html.

In other words, it is a bug in the gitweb.

> Does this string really need to be URL encoded? Couldn't you split on
> the first space and then url encode it in the perl code? That would
> let me write the string in English instead of geek.
> 
> mpc5200b.git Jon Smirl <jonsmirl@gmail.com>

Not possible, as path to repository can contain spaces.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
