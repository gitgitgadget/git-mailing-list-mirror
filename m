From: Peter Simons <simons@cryp.to>
Subject: Re: Emacs git-mode feature request: support fill-paragraph correctly
Date: Mon, 26 Jan 2009 18:46:15 +0100
Organization: private
Message-ID: <87mydet0yg.fsf@write-only.cryp.to>
References: <87tz7mth3g.fsf@write-only.cryp.to> <808woyz2k7.fsf@tiny.isode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 18:48:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRVYx-00037x-DX
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 18:47:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003AbZAZRq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 12:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751845AbZAZRq2
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 12:46:28 -0500
Received: from main.gmane.org ([80.91.229.2]:60565 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751834AbZAZRq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 12:46:27 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LRVXU-0006Pn-08
	for git@vger.kernel.org; Mon, 26 Jan 2009 17:46:24 +0000
Received: from p54bd1659.dip0.t-ipconnect.de ([84.189.22.89])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 17:46:23 +0000
Received: from simons by p54bd1659.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 17:46:23 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p54bd1659.dip0.t-ipconnect.de
Cancel-Lock: sha1:vn6pf9MfhhNtq+2YmV/zon27tXA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107237>

Bruce Stephens <bruce.stephens@isode.com> writes:

 >> Other modes, such as message-mode, do support that kind of thing
 >> correctly, so apparently it is possible to configure what the
 >> editor considers as a paragraph. Is there some Emacs wizard out
 >> there who'd be kind enough to improve git-mode accordingly?
 >
 > I suspect this doesn't directly relate to git-mode. What mode
 > does emacs say you're in at this point? I'm guessing the buffer
 > name is COMMIT_EDITMSG and the mode is fundamental-mode?

The buffer is in "log-edit" mode.

 > In that case you could stick this in your .emacs if you wanted to
 > use message-mode:
 >
 > (setq auto-mode-alist (cons '("COMMIT_EDITMSG" . message-mode) auto-mode-alist))

Unfortunately, it's not that easy. I'm not an Emacs expert, but I'd
assume that switching into a different mode would change the meaning
of C-c C-c.

Peter
