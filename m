From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/7] gitk: Enhance UI popup and accelerator handling.
Date: Thu, 9 Oct 2008 22:02:46 +1100
Message-ID: <18669.58582.403341.404978@cargo.ozlabs.ibm.com>
References: <1223449540-20457-1-git-send-email-angavrilov@gmail.com>
	<1223449540-20457-2-git-send-email-angavrilov@gmail.com>
	<18669.20487.88439.584567@cargo.ozlabs.ibm.com>
	<bb6f213e0810090112l60d7b4c3v42e42d9d769c6057@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alexander Gavrilov" <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 13:04:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KntJR-00045w-SF
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 13:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756002AbYJILCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 07:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755472AbYJILCy
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 07:02:54 -0400
Received: from ozlabs.org ([203.10.76.45]:33806 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754736AbYJILCw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 07:02:52 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 81FE2DDF39; Thu,  9 Oct 2008 22:02:51 +1100 (EST)
In-Reply-To: <bb6f213e0810090112l60d7b4c3v42e42d9d769c6057@mail.gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97839>

Alexander Gavrilov writes:

> On Thu, Oct 9, 2008 at 4:27 AM, Paul Mackerras <paulus@samba.org> wrote:
> >> +    catch { bind . <Shift-Key-XF86_Switch_VT_4> {newview 0} }
> >
> > What is this key, or why is this line needed?
> 
> It is a workaround for an apparent bug in interaction between Tk and
> XKB on some systems.
> XKB configuration files bind those symbols to Ctrl-Alt-F*
> combinations, but Tk's keyboard
> handiling code sees them when Shift-F* is pressed. I'll be glad to
> find a better fix, but that's
> all I could do for now.

OK, that information should go in the patch description.

> > You need to change the error returns in domktag to say "return 0",
> > otherwise this will give a "can't use empty string as operand of "!""
> > Tcl error.
> 
> I did not know this. I'm not that familiar with Tcl...

Then I am amazed at how much you have been able to accomplish...

There's a lot of information available in the Tcl/Tk man pages.  On
Debian or Ubuntu, you need the tcl8.5-doc and tk8.5-doc packages
installed.  Then you can do e.g. "man 3tcl Tcl" to get a summary of
the Tcl language syntax, etc.

BTW, I haven't forgotten about your encoding support patches.  The
last month has been occupied with travelling for Kernel Summit and the
Linux Plumbers Conference, followed by a vacation, and then catching
up with work that has piled up, so I haven't had much time to spare
for gitk hacking.

Paul.
