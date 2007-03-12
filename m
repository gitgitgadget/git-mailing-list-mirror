From: Joshua N Pritikin <jpritikin@pobox.com>
Subject: Re: [PATCH] git-init: set up GIT_DIR/workdir if GIT_WORK_DIR is set
Date: Mon, 12 Mar 2007 17:42:26 +0530
Message-ID: <20070312121226.GB2268@always.joy.eth.net>
References: <20070311043250.GA21331@moooo.ath.cx> <20070312115350.GA15179@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 12 13:12:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQjOY-0005QD-90
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 13:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965739AbXCLMMv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 08:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965750AbXCLMMv
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 08:12:51 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:35759 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965739AbXCLMMv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 08:12:51 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id C562C2EF
	for <git@vger.kernel.org>; Mon, 12 Mar 2007 08:13:11 -0400 (EDT)
Received: from emit.nirmalvihar.info (house.nirmalvihar.info [61.17.90.7])
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 7B66933B5B
	for <git@vger.kernel.org>; Mon, 12 Mar 2007 08:13:08 -0400 (EDT)
Received: by emit.nirmalvihar.info (sSMTP sendmail emulation); Mon, 12 Mar 2007 17:42:26 +0530
Content-Disposition: inline
In-Reply-To: <20070312115350.GA15179@moooo.ath.cx>
X-PGP-Key: 06E3 3D22 D307 AAE6 ACB4  6B44 A9CA A794 A4A6 0BBD
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42022>

On Mon, Mar 12, 2007 at 12:53:50PM +0100, Matthias Lederhofer wrote:
> git-init will always put an absolute path in
> GIT_DIR/workdir, relative paths are resolved from the
> directory git-init was called from.

Does that mean I can't move my GIT trees around without changing a 
config entry? What is that an improvement?
