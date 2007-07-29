From: David Kastrup <dak@gnu.org>
Subject: Re: What's in git.git (stable)
Date: Sun, 29 Jul 2007 11:05:42 +0200
Message-ID: <85ir83zijd.fsf@lola.goethe.zz>
References: <7v4plqoyg5.fsf@assigned-by-dhcp.cox.net>
	<7v7iqgtt1j.fsf@assigned-by-dhcp.cox.net>
	<7vk5u7d38h.fsf@assigned-by-dhcp.pobox.com>
	<7vy7idydqa.fsf@assigned-by-dhcp.pobox.com>
	<7v7ipsz7vr.fsf@assigned-by-dhcp.pobox.com>
	<7vk5tj3bj1.fsf@assigned-by-dhcp.cox.net>
	<7vzm20q1l7.fsf_-_@assigned-by-dhcp.cox.net>
	<7vvec4synj.fsf_-_@assigned-by-dhcp.cox.net>
	<85zm1g3nze.fsf@lola.goethe.zz> <85bqdw27mb.fsf@lola.goethe.zz>
	<20070729031612.GB17204@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sun Jul 29 11:06:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF4j6-0005Yw-KJ
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 11:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760820AbXG2JGJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 05:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760707AbXG2JGI
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 05:06:08 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:54342 "EHLO
	mail-in-08.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760778AbXG2JGG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jul 2007 05:06:06 -0400
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net [151.189.8.16])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id 8C32327B9D2;
	Sun, 29 Jul 2007 11:06:03 +0200 (CEST)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id 58FF5ABAEE;
	Sun, 29 Jul 2007 11:06:03 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-017-015.pools.arcor-ip.net [84.61.17.15])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 0C4FD225122;
	Sun, 29 Jul 2007 11:06:02 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 9B7D41CFF95E; Sun, 29 Jul 2007 11:05:42 +0200 (CEST)
In-Reply-To: <20070729031612.GB17204@thunk.org> (Theodore Tso's message of "Sat\, 28 Jul 2007 23\:16\:12 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3804/Sun Jul 29 06:09:31 2007 on mail-in-13.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54097>

Theodore Tso <tytso@mit.edu> writes:

> So I really am beginning to think the right answer is to give up on
> using git-mergetool to support anything other than basic emacs users
> (who just use emacs as an editor, what a concept),

In contrast, you are trying to support only people by using Emacs
_not_ as an editor, but as a mergetool under the control of git.
That's a mistake.

> and for the H4rd C0re emacs l33t, they can use a
> contrib/git-mergetool.el that does everything inside emacs.  Since
> these are the people who want emacs to be their desktop, their
> shell, *and* their window manager, they will probably be happier
> that way....

Sorry, but you are way off here.  The normal, standard use of Emacs is
to start it once and do everything in it.  Its startup time is such
that other uses are not feasible.

(info "(emacs) Entering Emacs")

       Many editors are designed to edit one file.  When done with
    that file, you exit the editor.  The next time you want to edit a
    file, you must start the editor again.  Working this way, it is
    convenient to use a command-line argument to say which file to
    edit.

       However, killing Emacs after editing one each and starting it
    afresh for the next file is both unnecessary and harmful, since it
    denies you the full power of Emacs.  Emacs can visit more than one
    file in a single editing session, and that is the right way to use
    it.  Exiting the Emacs session loses valuable accumulated context,
    such as the kill ring, registers, undo history, and mark ring.
    These features are useful for operating on multiple files, or even
    continuing to edit one file.  If you kill Emacs after each file,
    you don't take advantage of them.

       The recommended way to use GNU Emacs is to start it only once,
    just after you log in, and do all your editing in the same Emacs
    session.  Each time you edit a file, you visit it with the
    existing Emacs, which eventually has many files in it ready for
    editing.  Usually you do not kill Emacs until you are about to log
    out.  *Note Files::, for more information on visiting more than
    one file.

       To edit a file from another program while Emacs is running, you
    can use the `emacsclient' helper program to open a file in the
    already running Emacs.  *Note Emacs Server::.


So git's mergetool philosophy is currently _straight_ set against the
way Emacs is designed to work.

One solution would be to call emacs -q in order to weed out users with
the impunity of customizing Emacs to suit their needs rather than
those of git.

But the sanest is really to call Emacs just the way the user
configured $EDITOR to call it and pass it an initial merge command.
And then decide from the results on the disk what to further do.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
