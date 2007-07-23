From: Nix <nix@esperi.org.uk>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Mon, 23 Jul 2007 21:18:22 +0100
Message-ID: <87ps2inab5.fsf@hades.wkstn.nix>
References: <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
	<alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
	<85abttwa7m.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org>
	<7vbqe93qtv.fsf@assigned-by-dhcp.cox.net>
	<20070719053858.GE32566@spearce.org>
	<20070719060922.GF32566@spearce.org> <vpqvecgvmjh.fsf@bauges.imag.fr>
	<20070719105105.GA4929@moonlight.home>
	<86zm1sbpeh.fsf@lola.quinscape.zz>
	<20070719123214.GB4929@moonlight.home>
	<863azka7d4.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jul 23 22:18:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID4Mm-0008V8-Fq
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 22:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935064AbXGWUSv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 16:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933479AbXGWUSu
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 16:18:50 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:50924 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934937AbXGWUSs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 16:18:48 -0400
Received: from esperi.org.uk (nix@hades.wkstn.nix [192.168.14.18])
	by mail.esperi.org.uk (8.12.11.20060614/8.12.11) with ESMTP id l6NKIMhh013111;
	Mon, 23 Jul 2007 21:18:23 +0100
Received: (from nix@localhost)
	by esperi.org.uk (8.12.11.20060614/8.12.11/Submit) id l6NKIMkV010775;
	Mon, 23 Jul 2007 21:18:22 +0100
Emacs: impress your (remaining) friends and neighbors.
In-Reply-To: <863azka7d4.fsf@lola.quinscape.zz> (David Kastrup's message of "Thu, 19 Jul 2007 14:46:47 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
X-DCC-INFN-TO-Metrics: hades 1233; Body=2 Fuz1=2 Fuz2=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53470>

On 19 Jul 2007, David Kastrup stated:
> Tomash Brechko <tomash.brechko@gmail.com> writes:
>> Please consider this: I myself use Git to track my own local
>> projects, and for this usage you proposal have no value for me,
>> i.e. as a _Source_ Code Management system Git is rather complete.
>> But I also track /etc and ~/ in Git, and for this I'd love to have
>> directories, permissions, ownership, other attributes, to be
>> tracked.  I have Perl script wrapping Git that allows me to filter
>> tracked paths by full regexps instead of Git's file globs, and also
>> to filter out too big files assuming that they are binary anyway.
>
> Look, git _tracks_ contents.  Your permissions managements needs to be
> told explicitly when and how things change.  So you end up with git
> _tracking_ material and your permissions/directory management needing
> the level of manual handholding Subversion demands.

Actually, if we had a post-checkout hook, we could use a pre-commit hook
to keep track of directory existence, permissions, et seq, and a post-
checkout hook to restore them.

(But we don't, at least not yet. Adding one is probably quite easy.)
