From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: Problem running git-gui
Date: Tue, 17 Jul 2007 14:04:53 +0200
Message-ID: <20070717120453.GD7774@cip.informatik.uni-erlangen.de>
References: <Pine.LNX.4.64.0707171244080.13359@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Tue Jul 17 14:04:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAlnW-0000XS-CD
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 14:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbXGQMEz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 08:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbXGQMEz
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 08:04:55 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:58545 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750736AbXGQMEy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jul 2007 08:04:54 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 928EE3F42C; Tue, 17 Jul 2007 14:04:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707171244080.13359@reaper.quantumfyre.co.uk>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52756>

Hello Julian,

> 'Error in startup script: expected version number but got "1.5.3.GIT"'

I get the same error. However it works with released versions of git:

	(faui04a) [~] git gui
	Error in startup script: invalid command name "git-version"
	while executing
	"git-version >= 1.5.3"
	(in namespace eval "::blame" script line 36)
	invoked from within
	"namespace eval $class $body"
	(procedure "class" line 16)
	invoked from within
	"class blame {

	image create photo ::blame::img_back_arrow -data {R0lGODlhGAAYAIUAAPwCBEzKXFTSZIz+nGzmhGzqfGTidIT+nEzGXHTqhGzmfGzifFzadETCVES+VARWDFzWb..."
	(file "/usr/share/git-gui/lib/blame.tcl" line 4)
	invoked from within
	"source [file join $oguilib $p]"
	("foreach" body line 3)
	invoked from within
	"foreach p $idx {
			if {[lsearch -exact $loaded $p] >= 0} continue
			source [file join $oguilib $p]
			lappend loaded $p
		}"
	invoked from within
	"if {$idx ne {}} {
		set loaded [list]
		foreach p $idx {
			if {[lsearch -exact $loaded $p] >= 0} continue
			source [file join $oguilib $p]
			lappend loa..."
	(file "/usr/bin/git-gui" line 98)

it is because "1.5.3.GIT" is not a number I guess.

	Thomas
