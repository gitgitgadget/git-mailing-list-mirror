From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: .gitlink for Summer of Code
Date: Tue, 27 Mar 2007 01:14:49 +0200
Message-ID: <200703270114.49365.Josef.Weidendorfer@gmx.de>
References: <1174825838.12540.5.camel@localhost> <200703262133.44520.Josef.Weidendorfer@gmx.de> <vpqodmfss39.fsf@olympe.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Mar 27 01:03:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVyDO-000133-6H
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 01:03:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbXCZXCr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 19:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbXCZXCq
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 19:02:46 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:53656 "EHLO
	mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750708AbXCZXCq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Mar 2007 19:02:46 -0400
Received: from dhcp-3s-49.lrr.in.tum.de (dhcp-3s-49.lrr.in.tum.de [131.159.35.49])
	by mail.in.tum.de (Postfix) with ESMTP id EEA5528E6;
	Tue, 27 Mar 2007 01:02:44 +0200 (MEST)
User-Agent: KMail/1.9.6
In-Reply-To: <vpqodmfss39.fsf@olympe.imag.fr>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43200>

On Monday 26 March 2007, Matthieu Moy wrote:
> Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:
> > The original proposal was to have a standard .git directory for every
> > light-weight checkout inside of the base .git directory, e.g.
> > in <base>/.git/ext/<name>.git where <name> is some identifier for the
> > lightweight checkout, either provided in the .gitlink file or
> > automatically determined.
> 
> That seems really weird. That implies for example:
> [... some good reasons to not do it this way ...]

Ok, you are right.
It is better to not touch the original repository
for lightweight checkouts.

> * You have to manage a name for each lightweight checkout. What would
>   be such name? User-provided? uuidgen-like?

Such a name is interesting as identifier for submodules.
It would be the relative path of the submodule from the supermodule base;
or user supplied.

Lightweight checkouts and submodules have different requirements;
yet, the lightweight checkouts should be so flexible to be
able to be used for submodules checkouts.

Josef
