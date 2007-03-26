From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: .gitlink for Summer of Code
Date: Tue, 27 Mar 2007 01:17:58 +0200
Message-ID: <200703270117.59205.Josef.Weidendorfer@gmx.de>
References: <1174825838.12540.5.camel@localhost> <20070326220302.GH22773@admingilde.org> <7vfy7rvct2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Martin Waitz <tali@admingilde.org>, Eric Lesh <eclesh@ucla.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 01:06:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVyGK-0002YB-13
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 01:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbXCZXF4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 19:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbXCZXF4
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 19:05:56 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:53673 "EHLO
	mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750872AbXCZXFz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Mar 2007 19:05:55 -0400
Received: from dhcp-3s-49.lrr.in.tum.de (dhcp-3s-49.lrr.in.tum.de [131.159.35.49])
	by mail.in.tum.de (Postfix) with ESMTP id 313D528E6;
	Tue, 27 Mar 2007 01:05:54 +0200 (MEST)
User-Agent: KMail/1.9.6
In-Reply-To: <7vfy7rvct2.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43201>

On Tuesday 27 March 2007, Junio C Hamano wrote:
> Martin Waitz <tali@admingilde.org> writes:
> 
> > For submodules I currently use <parent>/.git/objects/module/<submodule>/
> > to store the objects belonging to the submodule.
> 
> I was not following the gitlink discussion closely, but what is
> the motivation behind this separation of the object store?

The separation issue is about scalability of submodules, and not
directly about gitlink.

Josef
