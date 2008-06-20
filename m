From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH 3/3] Make rebase--interactive use OPTIONS_SPEC
Date: Fri, 20 Jun 2008 07:48:10 +0200
Message-ID: <20080620054810.GB7369@leksak.fem-net>
References: <1213929935-15093-1-git-send-email-s-beyer@gmx.net> <1213929935-15093-2-git-send-email-s-beyer@gmx.net> <1213929935-15093-3-git-send-email-s-beyer@gmx.net> <1213929935-15093-4-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 07:49:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9ZUn-00034T-OH
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 07:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbYFTFsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 01:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbYFTFsR
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 01:48:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:39883 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751135AbYFTFsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 01:48:16 -0400
Received: (qmail invoked by alias); 20 Jun 2008 05:48:14 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp054) with SMTP; 20 Jun 2008 07:48:14 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18VO4JflbMVV4S103QtzqyIgRJas/pB7GmzSgdwB8
	xnTkqRcTFAfWgT
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K9ZTm-0003dA-Sc; Fri, 20 Jun 2008 07:48:10 +0200
Content-Disposition: inline
In-Reply-To: <1213929935-15093-4-git-send-email-s-beyer@gmx.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85596>

Ouch, here is a little mistake:
> +OPTIONS_SPEC='
> +git-rebase -i [options] <upstream> [<branch>]

Must be:
	OPTIONS_SPEC='git-rebase -i [options] <upstream> [<branch>]
...or the usage string will be empty.

Are there other reasons for a v2?

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
