From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH 5/5] Add gitmodules(5)
Date: Tue, 12 Jun 2007 15:50:27 +0200
Message-ID: <200706121550.28226.Josef.Weidendorfer@gmx.de>
References: <20070611225918.GD4323@planck.djpig.de> <466E9469.5D6BD391@eudaptics.com> <200706121540.52753.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Lars Hjemli <hjemli@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Junio C Hamano <gitster@pobox.com>, skimo@liacs.nl,
	git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 15:50:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy6lg-0005ql-Kf
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 15:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756138AbXFLNug (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 09:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756052AbXFLNug
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 09:50:36 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:39546 "EHLO
	mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756138AbXFLNuf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jun 2007 09:50:35 -0400
Received: from dhcp-3s-48.lrr.in.tum.de (dhcp-3s-48.lrr.in.tum.de [131.159.35.48])
	by mail.in.tum.de (Postfix) with ESMTP id 00F171A36;
	Tue, 12 Jun 2007 15:50:33 +0200 (MEST)
User-Agent: KMail/1.9.7
In-Reply-To: <200706121540.52753.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49961>

On Tuesday 12 June 2007, Josef Weidendorfer wrote:
> IMHO sharing of the admin submodule repository should even be possible
> if I have a clone of kdelibs and kdebase independent of the big
> KDE superproject.
> 
> It would be nice to allow submodule.<name>.repopath configs globally
> in ~/.gitconfig, and cloning kdelibs should automatically do the
> right thing, ie. use the already available admin repo for the kdelibs
> clone.

I just realize that this should be already possible now by setting
submodule.<name>.url in ~/.gitconfig. It could automatically
use "git-clone -l -s -n ..." if the URL is local.

Josef
