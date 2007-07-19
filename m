From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [REVISED PATCH 3/6] Add git-notes
Date: Thu, 19 Jul 2007 03:54:51 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707190353570.14781@racer.site>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site>
 <Pine.LNX.4.64.0707160023360.14781@racer.site> <7v8x9h6igv.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0707190331050.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alberto Bertogli <albertito@gmail.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 04:55:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBMAN-0001ad-3N
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 04:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbXGSCy4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 22:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757371AbXGSCy4
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 22:54:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:48291 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751046AbXGSCyz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 22:54:55 -0400
Received: (qmail invoked by alias); 19 Jul 2007 02:54:54 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 19 Jul 2007 04:54:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19pc2UT9YJp/5rtvF65VSBR+rn52hjQC2RNZGC7Xm
	F4lQ85xATnMvQI
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707190331050.14781@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52928>

Hi,

On Thu, 19 Jul 2007, Johannes Schindelin wrote:

> +MESSAGE="$GIT_DIR"/new-notes
> +trap '
> +	test -f "$MESSAGE" && rm "$MESSAGE"
> +' 0

Oh, well.  Probably this should use mktemp and should handle 
GIT_INDEX_FILE, too.

Will do that tomorrow.

Ciao,
Dscho
