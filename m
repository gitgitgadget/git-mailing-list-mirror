From: Andreas Krey <a.krey@gmx.de>
Subject: Re: git clone against firewall
Date: Sat, 16 Jan 2010 00:03:57 +0100
Message-ID: <20100115230357.GA10163@inner.home.ulmdo.de>
References: <4B4FACB1.2080902@hartwork.org> <7vzl4fz0zb.fsf@alter.siamese.dyndns.org> <4B50BE10.5010603@hartwork.org> <m2aawf1804.fsf@igel.home> <4B50C311.2040305@hartwork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sebastian Pipping <webmaster@hartwork.org>
X-From: git-owner@vger.kernel.org Sat Jan 16 00:05:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVvE4-0001KH-JB
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 00:05:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758591Ab0AOXFB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 18:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758587Ab0AOXFB
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 18:05:01 -0500
Received: from continuum.iocl.org ([213.146.114.200]:63883 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758487Ab0AOXFB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 18:05:01 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id o0FN3vn12066;
	Sat, 16 Jan 2010 00:03:57 +0100
Content-Disposition: inline
In-Reply-To: <4B50C311.2040305@hartwork.org>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137155>

On Fri, 15 Jan 2010 20:33:37 +0000, Sebastian Pipping wrote:
...
> > Not much that
> > can be done about that.
> 
> My problem actually is not the dropping but that git doesn't stop
> trying.  I actually want it to fail.

It does. After the usual network timeout, which unfortunately is
a few minutes, and thus not really useful for trying several
machines:

  74.43.91.xxx[0: 74.43.91.xxx]: errno=Connection timed out
  fatal: unable to connect a socket (Connection timed out)

Andreas
