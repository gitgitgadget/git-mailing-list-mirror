From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Skip timestamp differences for diff --no-index
Date: Wed, 18 Feb 2009 11:53:50 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902181153050.6274@intel-tinevez-2-302>
References: <1234939686-14932-1-git-send-email-mspang@uwaterloo.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Spang <mspang@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Wed Feb 18 11:55:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZk5M-0007no-Ck
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 11:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753709AbZBRKxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 05:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753675AbZBRKxy
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 05:53:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:42362 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752235AbZBRKxx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 05:53:53 -0500
Received: (qmail invoked by alias); 18 Feb 2009 10:53:51 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp060) with SMTP; 18 Feb 2009 11:53:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19uvmYw6vpuVjT2FrFwJ5iTO4vJeyAYxkU9Sdj9V7
	L268yI8D/pScih
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1234939686-14932-1-git-send-email-mspang@uwaterloo.ca>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110525>

Hi,

On Wed, 18 Feb 2009, Michael Spang wrote:

> We display empty diffs for files whose timestamps have changed.
> Usually, refreshing the index makes those empty diffs go away.
> However, when not using the index they are not very useful and
> there is no option to suppress them.
> 
> This forces on the skip_stat_unmatch option for diff --no-index,
> suppressing any empty diffs. This option is also used for diffs
> against the index when "diff.autorefreshindex" is set, but that
> option does not apply to diff --no-index.
> 
> Signed-off-by: Michael Spang <mspang@uwaterloo.ca>
> ---

Nice!  And very nicely written patch!

Thanks,
Dscho
