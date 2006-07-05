From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Additional merge-base tests
Date: Wed, 5 Jul 2006 10:39:53 +0200
Message-ID: <200607051039.53288.Josef.Weidendorfer@gmx.de>
References: <44A9E6AE.10508@gmail.com> <Pine.LNX.4.63.0607041019580.29667@wbgn013.biozentrum.uni-wuerzburg.de> <7v8xn9gjh5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 05 10:40:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fy2vQ-0004TF-UI
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 10:40:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWGEIj6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Jul 2006 04:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWGEIj6
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Jul 2006 04:39:58 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:47309 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S932356AbWGEIj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jul 2006 04:39:57 -0400
Received: from dhcp-3s-61.lrr.in.tum.de (dhcp-3s-61.lrr.in.tum.de [131.159.35.61])
	by mail.in.tum.de (Postfix) with ESMTP id 3C80B2757;
	Wed,  5 Jul 2006 10:39:56 +0200 (MEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7v8xn9gjh5.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23342>

On Tuesday 04 July 2006 23:15, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > We could introduce a time.maximumSkew variable, and just walk only 
> > that much further when traversing the commits.
> 
> We could have had "commit generation number" in the commit
> object header, and use that instead of commit timestamps for
> these traversal purposes.

Isn't this "commit generation number" information that can be
regenerated on the fly, i.e. a perfect fit for data to be stored
in a persistant cache, e.g. in ".git/tmp/virtual-commit-timestamps"?

Josef
