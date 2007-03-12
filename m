From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] git-init: set up GIT_DIR/workdir if GIT_WORK_DIR is set
Date: Mon, 12 Mar 2007 13:52:07 +0100
Message-ID: <20070312125207.GA16335@moooo.ath.cx>
References: <20070311043250.GA21331@moooo.ath.cx> <20070312115350.GA15179@moooo.ath.cx> <20070312121226.GB2268@always.joy.eth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joshua N Pritikin <jpritikin@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 13:52:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQk0f-0006mz-0U
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 13:52:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965808AbXCLMwM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 08:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965809AbXCLMwM
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 08:52:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:39358 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965808AbXCLMwL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 08:52:11 -0400
Received: (qmail invoked by alias); 12 Mar 2007 12:52:09 -0000
Received: from pD9EBB74D.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.183.77]
  by mail.gmx.net (mp017) with SMTP; 12 Mar 2007 13:52:09 +0100
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1+PY7UH7G+PV/Xv7TC2oSZFvsDPAggbLnMui95Jc5
	lhcv/2Uf5PICBQ
Mail-Followup-To: Joshua N Pritikin <jpritikin@pobox.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070312121226.GB2268@always.joy.eth.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42024>

Joshua N Pritikin <jpritikin@pobox.com> wrote:
> On Mon, Mar 12, 2007 at 12:53:50PM +0100, Matthias Lederhofer wrote:
> > git-init will always put an absolute path in
> > GIT_DIR/workdir, relative paths are resolved from the
> > directory git-init was called from.
> 
> Does that mean I can't move my GIT trees around without changing a 
> config entry? What is that an improvement?
Only when using $GIT_DIR.  $GIT_DIR/workdir is only the default value
for $GIT_WORK_DIR.
