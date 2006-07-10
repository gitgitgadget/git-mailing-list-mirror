From: Josh Triplett <josht@us.ibm.com>
Subject: Re: [PATCH] git-format-patch: Make the second and subsequent mails
	replies to the first
Date: Mon, 10 Jul 2006 09:43:06 -0700
Message-ID: <1152549787.8890.36.camel@josh-work.beaverton.ibm.com>
References: <1152546266.8890.19.camel@josh-work.beaverton.ibm.com>
	 <Pine.LNX.4.63.0607101801360.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20060710162920.GR20191@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, josht@us.ibm.com
X-From: git-owner@vger.kernel.org Mon Jul 10 18:43:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fzyqm-0001xh-4X
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 18:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422689AbWGJQnI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 12:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422691AbWGJQnI
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 12:43:08 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:36483 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422689AbWGJQnH
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 12:43:07 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k6AGh4WE025856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <git@vger.kernel.org>; Mon, 10 Jul 2006 12:43:05 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k6AGgFbd313002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 10 Jul 2006 10:42:15 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k6AGh48x004615
	for <git@vger.kernel.org>; Mon, 10 Jul 2006 10:43:04 -0600
Received: from dyn9047018143.beaverton.ibm.com (dyn9047018143.beaverton.ibm.com [9.47.18.143])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k6AGh3Er004593;
	Mon, 10 Jul 2006 10:43:03 -0600
To: Erik Mouw <erik@harddisk-recovery.com>
In-Reply-To: <20060710162920.GR20191@harddisk-recovery.com>
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23627>

On Mon, 2006-07-10 at 18:29 +0200, Erik Mouw wrote:
> On Mon, Jul 10, 2006 at 06:01:48PM +0200, Johannes Schindelin wrote:
> > please make that behaviour optional.
> 
> Rather make it consistent with git-send-email. Principle of least
> surprise.

Well, git-send-email does not include an option to disable the threading
headers, so consistency with git-send-email would imply not including
any such option.  I can, however, implement a --no-thread option to omit
the headers, as well as git-send-email's --in-reply-to option to set an
initial In-Reply-To/References.  New patch series shortly.

- Josh Triplett
