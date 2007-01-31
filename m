From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] Make gitk work reasonably well on Cygwin.
Date: Wed, 31 Jan 2007 17:33:35 +0100
Organization: eudaptics software gmbh
Message-ID: <45C0C4DF.C0EB4495@eudaptics.com>
References: <BAY13-F213DF79906B3889D42369D0A50@phx.gbl> <Pine.LNX.4.63.0701311612420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 31 17:37:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCIQb-0006jU-9d
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 17:35:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbXAaQfN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 11:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbXAaQfN
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 11:35:13 -0500
Received: from main.gmane.org ([80.91.229.2]:47358 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030246AbXAaQfL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 11:35:11 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HCIQI-0001YW-89
	for git@vger.kernel.org; Wed, 31 Jan 2007 17:35:02 +0100
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 17:35:02 +0100
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 17:35:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38272>

Johannes Schindelin wrote:
> I also verified that with my Tcl/Tk installation on MacOSX, a patch like
> this was needed. IIRC Paulus argued that I should get a native TclTk,
> which is supposed to work (though not with the paths on Cygwin, oh well).
> 
> Oh, and it is also needed for MinGW. But I guess it will remain unfixed.

You patch does not improve gitk under MinGW. The layout becomes less
useful because the lower part becomes too high, so that the Search bar
and some part of the patch + file list windows is not visible. :(

-- Hannes
