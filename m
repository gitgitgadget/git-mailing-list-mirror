From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/2] git-svn: use platform specific auth providers
Date: Sun, 29 Apr 2012 08:23:41 +0000
Message-ID: <20120429082341.GA32664@dcvr.yhbt.net>
References: <20120426183634.GA4023@login.drsnuggles.stderr.nl>
 <1335468843-24653-1-git-send-email-matthijs@stdin.nl>
 <20120427082118.GA7257@dcvr.yhbt.net>
 <20120427082559.GC4023@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gustav Munkby <grddev@gmail.com>,
	Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>, git@vger.kernel.org,
	Matthijs Kooijman <matthijs@stdin.nl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 29 10:23:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOPQ7-0006kp-IB
	for gcvg-git-2@plane.gmane.org; Sun, 29 Apr 2012 10:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759Ab2D2IXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Apr 2012 04:23:46 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:37779 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752502Ab2D2IXn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2012 04:23:43 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 238261F6C9;
	Sun, 29 Apr 2012 08:23:42 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20120427082559.GC4023@login.drsnuggles.stderr.nl>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196505>

Matthijs Kooijman <matthijs@stdin.nl> wrote:
> > > On Linux, this makes authentication using passwords from gnome-keyring
> > > and kwallet work (only the former was tested). On Mac OS X, this allows
> > > using the OS X Keychain.
> Signed-off-by: Matthijs Kooijman <matthijs@stdin.nl>

Thanks Matthijs, pushed to master of git://bogomips.org/git-svn for
Junio.

(actually pushed the other night, but I got distracted before
 sending this email :x)
