From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH 5/5] Add gitmodules(5)
Date: Tue, 12 Jun 2007 12:34:38 +0200
Organization: eudaptics software gmbh
Message-ID: <466E76BE.A3F84A2D@eudaptics.com>
References: <20070611225918.GD4323@planck.djpig.de>
		 <11816319211097-git-send-email-hjemli@gmail.com>
		 <20070612080402.GQ955MdfPADPa@greensroom.kotnet.org> <8c5c35580706120127p649227d8gc706cb8b364d02b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 12 12:33:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy3h5-0007qr-2Y
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 12:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbXFLKdh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 06:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752501AbXFLKdh
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 06:33:37 -0400
Received: from main.gmane.org ([80.91.229.2]:47186 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752083AbXFLKdh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 06:33:37 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hy3gl-0003DF-UI
	for git@vger.kernel.org; Tue, 12 Jun 2007 12:33:28 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Jun 2007 12:33:27 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Jun 2007 12:33:27 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49944>

Lars Hjemli wrote:
> 
> On 6/12/07, Sven Verdoolaege <skimo@kotnet.org> wrote:
> > On Tue, Jun 12, 2007 at 09:05:21AM +0200, Lars Hjemli wrote:
> > > +submodule.<name>.path::
> > > +     Defines the path, relative to the top-level directory of the git
> >
> > Your previous patch had "_a_ path" instead of "_the_ path".
> > I prefer the former since it allows a module to be checkoud out
> > at multiple locations.
> 
> This is somewhat intentional. I want to move the submodule repos into
> .git/submodules/$name/ (with working dir) and symlink this directory
> when 'checking out' the submodule. This would be a simple solution for
> the following problems:
>   -keeping submodule modifications between checkouts
>   -having submodules within submodules

It has already been said in the past that symlinks are *bad*. The don't
exist on Windows (MinGW). Please do not use symlinks for such central
concepts.

-- Hannes
