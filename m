From: Jeff King <peff@peff.net>
Subject: Re: Escape character for .gitconfig
Date: Sat, 17 Dec 2011 05:58:06 -0500
Message-ID: <20111217105806.GB23935@sigill.intra.peff.net>
References: <4EEC6A9D.1060005@icefield.yk.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Erik Blake <erik@icefield.yk.ca>
X-From: git-owner@vger.kernel.org Sat Dec 17 11:58:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rbry4-0005pU-DN
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 11:58:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972Ab1LQK6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 05:58:12 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44800
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751946Ab1LQK6K (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 05:58:10 -0500
Received: (qmail 12218 invoked by uid 107); 17 Dec 2011 11:04:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 17 Dec 2011 06:04:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Dec 2011 05:58:06 -0500
Content-Disposition: inline
In-Reply-To: <4EEC6A9D.1060005@icefield.yk.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187376>

On Sat, Dec 17, 2011 at 11:10:37AM +0100, Erik Blake wrote:

> I have an editor path that includes "(" and ")". No matter how I try
> to escape this character, I get either variations on:
> 
> C:/Program Files (x86)/Notepad++/notepad++.exe: -c: line 0: syntax
> error near unexpected token `('
> C:/Program Files (x86)/Notepad++/notepad++.exe: -c: line 0:
> `C:/Program Files (x86)/Notepad++/notepad++.exe \$@\'
> error: There was a problem with the editor 'C:/Program Files
> (x86)/Notepad++/notepad++.exe'.
> Please supply the message using either -m or -F option.
> 
> or:
> 
> fatal: bad config file line 5 in C:\Users\xxx/.gitconfig

You didn't tell us what you actually tried, so I don't know where you
went wrong.

But you will need to quote the whole value for git to read from your
gitconfig, and then quote any metacharacters in the value so that the
shell doesn't interpret them. I think you want:

  [core]
    editor = "'C:/Program Files (x86)/Notepad++/notepad++.exe'"

-Peff
