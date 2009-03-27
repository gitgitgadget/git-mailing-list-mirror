From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] init: support --import to add all files and commit
	right after init
Date: Fri, 27 Mar 2009 01:06:26 -0400
Message-ID: <20090327050626.GA23512@coredump.intra.peff.net>
References: <1237978720-2500-1-git-send-email-pclouds@gmail.com> <20090325124219.GA5307@coredump.intra.peff.net> <adf1fd3d0903250549l60e4a2d1j8bd57ba66d24a678@mail.gmail.com> <200903262223.28546.markus.heidelberg@web.de> <alpine.DEB.1.00.0903270259470.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Markus Heidelberg <markus.heidelberg@web.de>,
	Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 27 06:08:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln4Io-0006GB-4p
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 06:08:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755683AbZC0FGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 01:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754447AbZC0FGm
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 01:06:42 -0400
Received: from peff.net ([208.65.91.99]:58217 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753548AbZC0FGm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 01:06:42 -0400
Received: (qmail 18288 invoked by uid 107); 27 Mar 2009 05:06:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 27 Mar 2009 01:06:52 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Mar 2009 01:06:26 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0903270259470.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114849>

On Fri, Mar 27, 2009 at 03:03:07AM +0100, Johannes Schindelin wrote:

> _Again_, as Peff pointed out, you are welcome to use the current method of 
> git init && git add . && git commit, which _does_ launch an editor.
> 
> The fact that you want to spend much time (anyway) doing your initial 
> commit does not allow you to inconvenience others.

Another option would be a patch on top of the original to allow

  git config --global init.importmessage 'Commit inicial'

or

  git config --global init.importeditor true

I have no interest in writing such a patch, but I don't see a reason to
reject it.

-Peff
