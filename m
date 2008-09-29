From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/8] Docs: send-email: Man page option ordering
Date: Sun, 28 Sep 2008 20:36:36 -0400
Message-ID: <20080929003636.GA18552@coredump.intra.peff.net>
References: <1222564196-84202-1-git-send-email-mfwitten@mit.edu> <gbne1a$8g2$1@ger.gmane.org> <FB3A852B-728F-4183-A5AF-BA8F8D995AD7@mit.edu> <200809290210.33880.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Witten <mfwitten@mit.edu>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 29 02:44:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kk6sE-00041E-BG
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 02:44:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752992AbYI2Agk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 20:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752982AbYI2Agk
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 20:36:40 -0400
Received: from peff.net ([208.65.91.99]:1616 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752969AbYI2Agk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 20:36:40 -0400
Received: (qmail 20229 invoked by uid 111); 29 Sep 2008 00:36:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 28 Sep 2008 20:36:37 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Sep 2008 20:36:36 -0400
Content-Disposition: inline
In-Reply-To: <200809290210.33880.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96990>

On Mon, Sep 29, 2008 at 02:10:31AM +0200, Jakub Narebski wrote:

> peff>    The manpage, on the other hand, is a comprehensive reference
> peff>    and so should probably be alphabetized for easy reading.
> 
> [...]
> 
> Second, large manpages with large number of options are usually divided
> into sections, see git-rev-list(1) manpage, or rpmbuild(8) manpage. So
> there is precedent for that. And I think it is good precedent.

I am not opposed to dividing it into sections, with options alphabetized
in each section, as long as the section divisions make sense (e.g., in
rev-list, an obvious section is "commit formatting options"). I just
didn't think we had enough here to bother subdividing.

Either way will be in improvement on the current status, which is
apparently random (it looks like it was probably alphabetized at one
point, and then new options were added to the end).

-Peff
