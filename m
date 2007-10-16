From: Christer Weinigel <christer@weinigel.se>
Subject: Re: On Tabs and Spaces
Date: Wed, 17 Oct 2007 01:51:09 +0200
Message-ID: <20071017015109.303760cc@localhost.localdomain>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu>
	<471476B7.5050105@users.sourceforge.net>
	<8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com>
	<47148F72.1090602@users.sourceforge.net>
	<1192548367.3821.4.camel@lt21223.campus.dmacc.edu>
	<B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu>
	<3awb7zw6.fsf@blue.sea.net>
	<alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org>
	<1192565900.6430.16.camel@athena>
	<alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Tom Tobin <korpios@korpios.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 02:02:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhwMf-00038h-EE
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 02:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965608AbXJQACH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 20:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965578AbXJQACF
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 20:02:05 -0400
Received: from 2-1-3-15a.ens.sth.bostream.se ([82.182.31.214]:45492 "EHLO
	zoo.weinigel.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965608AbXJQACE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 20:02:04 -0400
X-Greylist: delayed 658 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Oct 2007 20:02:03 EDT
Received: from localhost.localdomain (grue.localnet [10.128.0.1])
	by zoo.weinigel.se (Postfix) with ESMTP id 983A51240774;
	Wed, 17 Oct 2007 01:51:03 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org>
X-Mailer: Claws Mail 2.9.1 (GTK+ 2.10.13; i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61284>

On Tue, 16 Oct 2007 16:05:34 -0700 (PDT)
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> I do indeed. I don't think it's sensible. And I did think I already 
> answered that issue by talking about how most editors don't even
> support it or show the difference between tabs and spaces.
> 
> For example, the editor I use - microemacs - supports tabs just fine.
> It does auto-indentation etc. But it does it with hard-tabs by
> default, so now you have to have some editor-specific setup for that
> particular project if you ever want to do anything else.
> 
> And that's really what it boils down to. Everybody support
> 8-character hardtabs (and usually by default). They may support other
> things *too*, but any time you move away from that standard
> behaviour, you'll most likely find something that doesn't support the
> alternatives.

Unfortunately most editors are totally confused about the difference
between tab size and indentation level.  Visual Studio, probably the
most commonly used development environment on Windows, by default uses
TAB characters that are 4 spaces wide, and users are recommended
not to change that because of that a lot of existing Windows source code
and examples uses those settings.

Two years ago, when I last looked at it, Eclipse, a very commonly used
development environment, managed to confuse tabs and indentation and
make it almost impossible to write Java or C code with a tab size of 8
with a different indentation level.  The Eclipse 3 betas did see some
improvement there, I think it got possible to do the right thing in
Java at least, but the normal text editor and C editor lagged behind.
But it was still a big mess and it was much too easy for someone to get
a tab size which is not 8.  Hopefully this has been fixed by now, but I
wouldn't bet any significant amount of money on it.

Nedit (which runs on Linux) has a very confusing settings dialog with
terms such as "tab spacing", "emulated tabs".  I guess emulated tabs
means the indentation level, but guess how easy that is to mess up.

gedit can control the tab width, but has no setting at all for
configuring the indentation level.  Guess what people do when they want
a 4 space indentation level?  Yes, right, change the tab size to 4.

A a former colleague who used visual slickedit usually produced code
with tab size 4.  I think I've gotten the same crap from ultra edit 32
users.

And so on...  Mercifully, _all_ of these editors have a setting to use
spaces instead of tabs, and telling people to turn on that setting is
the absolutely easiest way of making things "just work".  Yes, I know,
the correct answer is to tell people to always use tab size 8, and I
frequently and loudly do that.  But at the same time, perfect is the
enemy of good.  It's much easier to explain "tabs will act differently
in different editors, but if you always us spaces it will not be a
problem" than to get into a discussion about the semantic difference
between tab size and indentation.

If you assume that everyone is sane and use a tab size of 8 you will
get bitten, sooner or later.  Or actually, you, Linus, who are lucky
enough to work mostly with Linux source, you might personally not get
bitten all that often.  But us poor suckers that have to work with
other people, often Windows programmers, we do.

  /Christer
