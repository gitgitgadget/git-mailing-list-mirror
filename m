From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Re: symbolic link management in git-archive
Date: Thu, 27 Mar 2008 19:20:16 +0000 (UTC)
Message-ID: <loom.20080327T191845-374@post.gmane.org>
References: <loom.20080327T112740-539@post.gmane.org> <7v3aqcb02s.fsf@gitster.siamese.dyndns.org> <loom.20080327T175844-199@post.gmane.org> <7vd4pg9edm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 20:21:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jexeu-0000KZ-Rf
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 20:21:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755731AbYC0TU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 15:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755704AbYC0TU1
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 15:20:27 -0400
Received: from main.gmane.org ([80.91.229.2]:59046 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755588AbYC0TU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2008 15:20:26 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JexeA-0005sK-Pm
	for git@vger.kernel.org; Thu, 27 Mar 2008 19:20:22 +0000
Received: from host45-62-dynamic.6-87-r.retail.telecomitalia.it ([87.6.62.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 27 Mar 2008 19:20:22 +0000
Received: from sergio.callegari by host45-62-dynamic.6-87-r.retail.telecomitalia.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 27 Mar 2008 19:20:22 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.6.62.45 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.13) Gecko/20080325 Ubuntu/7.10 (gutsy) Firefox/2.0.0.13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78361>

Junio C Hamano <gitster <at> pobox.com> writes:

> 
> Under such an option, at least the comment in the archive (both for zip
> and tar) that notes which revision the tarball was taken from should be
> omitted.  As long as that is done, I think it is Ok to have such an
> optional behaviour.
> 

yes, I overlooked this, but it makes perfect sense: if it is not an exact copy
of the tracked state, it should not pretend to be so by indicating a revision.
