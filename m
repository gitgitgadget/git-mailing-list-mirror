From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Add .git/version
Date: Thu, 17 Nov 2005 17:41:23 +0100
Message-ID: <200511171741.23147.Josef.Weidendorfer@gmx.de>
References: <11322339372137-git-send-email-matlads@dsmagic.com> <200511171644.48438.Josef.Weidendorfer@gmx.de> <437CB0CA.6070306@op5.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Nov 17 17:48:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcmpG-0006Tw-Oz
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 17:41:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbVKQQl1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 11:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbVKQQl1
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 11:41:27 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:20936 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S932410AbVKQQl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 11:41:26 -0500
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id 3CDDF272B
	for <git@vger.kernel.org>; Thu, 17 Nov 2005 17:41:25 +0100 (MET)
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <437CB0CA.6070306@op5.se>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12132>

On Thursday 17 November 2005 17:33, Andreas Ericsson wrote:
> > Why? Ideally, the git commands first should check if they can handle the
> > repository format. If they can not handle the version, they should bail
> > out with an error [*]
> > Now suppose we want to release Git 2 without change the repository
> > format at all. Thus, even if Git 1 tool *would* work with repositories
> > created by Git 2, they will fail in the version check!
> > 
> 
> Not that I have an opinion on these changes, but Netscape 7 still 
> handles HTTP 1.1. Just because we up the major-number for git doesn't 
> mean we have to do the same for the repository format version.

Of course we do not want that.
My comment was about this, as the proposed patch installed a
.git/version file with the git version in it, which would lead to
this strange result.

Josef
