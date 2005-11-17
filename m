From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Add .git/version
Date: Thu, 17 Nov 2005 17:04:15 +0100
Message-ID: <200511171704.15503.Josef.Weidendorfer@gmx.de>
References: <11322339372137-git-send-email-matlads@dsmagic.com> <20051117151653.GB3626@igloo.ds.co.ug> <Pine.LNX.4.63.0511171634460.17319@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Nov 17 17:12:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcmFM-0005Ho-I1
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 17:04:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbVKQQEV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 11:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbVKQQEV
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 11:04:21 -0500
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:53727 "EHLO
	tuminfo2.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S932166AbVKQQEV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 11:04:21 -0500
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id D2FFA27C2
	for <git@vger.kernel.org>; Thu, 17 Nov 2005 17:04:17 +0100 (MET)
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <Pine.LNX.4.63.0511171634460.17319@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12126>

On Thursday 17 November 2005 16:38, Johannes Schindelin wrote:
> But yes, it might be handy to know at some time. But I think it would make 
> sense to add .git/version *then*, because you can distinguish repositories 
> before/after the change by testing for .git/version.

No, as old git tools then still could corrupt a repository with a new format,
as they currently do not check any kind of format version; it would work if
the git 1 tools would bail out if a .git/version is found ;-)

Josef
