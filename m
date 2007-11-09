From: David Brown <git@davidb.org>
Subject: Re: linux-2.6 clone with CygWin git
Date: Fri, 9 Nov 2007 07:03:06 -0800
Message-ID: <20071109150306.GA20531@old.davidb.org>
References: <598D5675D34BE349929AF5EDE9B03E270174D8A2@az33exm24.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org
To: Medve Emilian <Emilian.Medve@freescale.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 16:03:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqVOI-0004f1-5g
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 16:03:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760107AbXKIPDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 10:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760067AbXKIPDJ
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 10:03:09 -0500
Received: from mail.davidb.org ([66.93.32.219]:53526 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759998AbXKIPDI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 10:03:08 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.67 #1 (Debian))
	id 1IqVNy-0005PH-Uw; Fri, 09 Nov 2007 07:03:06 -0800
Mail-Followup-To: Medve Emilian <Emilian.Medve@freescale.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <598D5675D34BE349929AF5EDE9B03E270174D8A2@az33exm24.fsl.freescale.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64199>

On Fri, Nov 09, 2007 at 07:29:07AM -0700, Medve Emilian wrote:

>#       modified:   include/linux/netfilter/xt_CONNMARK.h
>
>Can somebody please double-check this scenario for me just to validate
>that this happens only due to some particular factors combination on my
>box?

It's because of the case-insensitive nature of the filesystem.  The kernel
contains both an xt_connmark.h and an xt_CONNMARK.h file, that are
different.  But only one exists on Windows, so git sees the first one it
wrote as having been modified.

David
