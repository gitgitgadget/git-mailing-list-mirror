From: Paul Mackerras <paulus@samba.org>
Subject: Re: New features in gitk
Date: Mon, 29 Oct 2007 10:13:43 +1100
Message-ID: <18213.6055.235067.730640@cargo.ozlabs.ibm.com>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
	<20071028183216.GA4310@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Oct 29 01:52:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImIs8-0004DU-Vr
	for gcvg-git-2@gmane.org; Mon, 29 Oct 2007 01:52:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327AbXJ2Awi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 20:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752295AbXJ2Awi
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 20:52:38 -0400
Received: from ozlabs.org ([203.10.76.45]:43645 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752181AbXJ2Awh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 20:52:37 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 20D08DDF69; Mon, 29 Oct 2007 11:52:35 +1100 (EST)
In-Reply-To: <20071028183216.GA4310@artemis.corp>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62591>

Pierre Habouzit writes:

> As you seem to be the guy to ask for, I've a couple of requests wrt
> gitk.
> 
>   * the diff window is quite bad with merge commits, the colorization is
>     rather poor, and the last version you just merged isn't especially
>     better.

That's not a request, that's a grizzle. :)  What would you like it to
look like?

>   * the 'sha1' input field is a major pain in the UI: the cut&paste
>     interaction is very poor. I don't know why, but it's often very very
>     hard to really copy the sha id, probably because it's selected by
>     default.

It's selected so that the contents are in the cut buffer and you can
paste them in an xterm with middle-button.  Possibly I need to check
that control-C (or command-C under macos) is properly bound to copy.

>   * the fact that it remembers the position where it was in the WM when
>     it was closed is really annoying. the WM is supposed to place the
>     window. With at least ion3 and xinerama it often shows up on the
>     wrong screen. Remembering the window size though is fine.

That came in with some changes that make gitk start up correctly under
windows.  I could see about making it set the window position only
under windows.

>   * still wrt the layout, the focus is quite cumbersome. Gitk would be
>     really really really nice to be used only from the keyboard, but
>     because of a very unclear focus policy, it really isn't for me.
>     Maybe it's just me, and I know this may not be 100% helpful, but I
>     never know which part of gitk will receive my keys (history part,
>     diff part, tree, ...).

What focus policy would you like?

Paul.
