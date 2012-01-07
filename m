From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 1/2] daemon: add tests
Date: Sat, 7 Jan 2012 12:46:55 +0100
Message-ID: <20120107114655.GA15686@ecki.lan>
References: <7v8vlovavj.fsf@alter.siamese.dyndns.org>
 <m3vcoqevjm.fsf@localhost.localdomain>
 <20120105025154.GA7326@sigill.intra.peff.net>
 <201201070035.52581.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 07 12:55:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjUrm-0004kC-7D
	for gcvg-git-2@lo.gmane.org; Sat, 07 Jan 2012 12:55:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810Ab2AGLzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jan 2012 06:55:12 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:37109 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751009Ab2AGLzL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2012 06:55:11 -0500
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id 1BFED10011;
	Sat,  7 Jan 2012 12:53:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201201070035.52581.jnareb@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188074>

On Sat, Jan 07, 2012 at 12:35:50AM +0100, Jakub Narebski wrote:
> > 
> > We could probably add a "--notify-when-ready" option to git-daemon to
> > do something similar.
> 
> What would git-daemon do what it is ready?  Write to socket, raise signal,
> print to STDOUT / STDERR?

Please have a look at my "git-daemon: produce output when ready" patch.
After opening the socket, git-daemon --verbose writes "Ready to rumble"
to stderr.
