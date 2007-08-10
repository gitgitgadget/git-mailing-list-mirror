From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: msysgit: does git gui work?
Date: Fri, 10 Aug 2007 12:26:30 +0200
Message-ID: <4856134D-B514-4C24-9B53-932C9F4F5531@zib.de>
References: <3CD6111C-13B5-444C-A28C-A7445C8A199B@zib.de> <E886F099-5E9F-4785-A560-F9AAAA4E4C1F@zib.de> <20070810053158.GJ24573@spearce.org> <B6C82889-ABE0-4B3D-A455-A2EE1CE48297@zib.de> <8FB380EB-CCA4-4BD3-8AD5-93630488D9C9@zib.de> <46BC1827.1060409@trolltech.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 12:25:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJRgk-0001B5-TW
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 12:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765456AbXHJKZr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 06:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764827AbXHJKZq
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 06:25:46 -0400
Received: from mailer.zib.de ([130.73.108.11]:62602 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763002AbXHJKZp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 06:25:45 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7AAPg2x000665;
	Fri, 10 Aug 2007 12:25:42 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7AAPgCG001906
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 10 Aug 2007 12:25:42 +0200 (MEST)
In-Reply-To: <46BC1827.1060409@trolltech.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55526>


On Aug 10, 2007, at 9:47 AM, Marius Storm-Olsen wrote:

>
> I cherry-picked your patches into my local devel branch, but I  
> still have issues with the version number being  
> 1.5.3.rc2.690.g8ca1f6-dirty.
> (You mentioned that you also needed to change the Makefile to a  
> different version numbering scheme, right?)
>
> So, your patches are still not enough to make it work out-of-box.  
> I'll push your patches to the devel branch though, but won't move  
> master until we have something which works. Ok?

Ok. If you tested with a dirty working tree you run into the
following problem. git-gui in msysgit doesn't understand
'-dirty' versions. You need to cherry pick from main git the
following commits:

2dfa54c6cb39c443652440f1ee6fdf5a6067364a git-gui: Skip -dirty suffix  
on core git versions
ec4fceece4a9f155afcadec254caff5cef781c67 git-gui: Brown paper bag  
"dirty git version fix"


btw, does someone know, where stderr of wish is piped to.
It doesn't appear on the mingw console, which makes debugging
more challenging.

	Steffen
