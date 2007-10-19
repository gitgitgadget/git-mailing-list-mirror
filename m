From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] allow git to use the PATH for finding subcommands and
	help docs
Date: Fri, 19 Oct 2007 18:48:16 +0200
Organization: glandium.org
Message-ID: <20071019164816.GA24573@glandium.org>
References: <20071019065931.GB1463@srparish.net> <47185DAF.7060809@viscovery.net> <20071019130402.GD1463@srparish.net> <Pine.LNX.4.64.0710191616490.16728@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Parish <sRp@srparish.net>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 19 18:50:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iiv3L-0007j5-8R
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 18:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759645AbXJSQuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 12:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758337AbXJSQuO
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 12:50:14 -0400
Received: from vawad.err.no ([85.19.200.177]:59589 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760231AbXJSQuM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 12:50:12 -0400
Received: from aputeaux-153-1-53-209.w82-124.abo.wanadoo.fr ([82.124.139.209] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1Iiv2n-0005Bx-UJ; Fri, 19 Oct 2007 18:49:55 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1Iiv1E-0006TV-Cn; Fri, 19 Oct 2007 18:48:16 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710191616490.16728@wbgn129.biozentrum.uni-wuerzburg.de>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61732>

On Fri, Oct 19, 2007 at 04:27:39PM +0200, Johannes Schindelin wrote:
> While reading this, I have to wonder why it is not just simpler to try 
> with builtin_exec_path first, and if that fails, just let exec() find the 
> program in the PATH?

Why not try the directory where the git executable is, too ?

Mike
