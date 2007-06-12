From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH 5/5] Add gitmodules(5)
Date: Tue, 12 Jun 2007 13:03:26 +0200
Organization: eudaptics software gmbh
Message-ID: <466E7D7E.7BAB2FD@eudaptics.com>
References: <20070611225918.GD4323@planck.djpig.de>
		 <11816319211097-git-send-email-hjemli@gmail.com>
		 <20070612080402.GQ955MdfPADPa@greensroom.kotnet.org>
		 <8c5c35580706120127p649227d8gc706cb8b364d02b9@mail.gmail.com>
		 <466E7A17.CEB0F196@eudaptics.com> <8c5c35580706120352y24e53a10sf339147b22f1286e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Frank Lichtenheld <frank@lichtenheld.de>,
	Junio C Hamano <gitster@pobox.com>, skimo@liacs.nl,
	git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 13:02:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy48k-0004Cl-5q
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 13:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbXFLLCH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 07:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbXFLLCH
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 07:02:07 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:9429 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbXFLLCG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 07:02:06 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtp (Exim 4.44)
	id 1Hy48R-0004g2-8F; Tue, 12 Jun 2007 13:02:03 +0200
Received: from eudaptics.com (unknown [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id AE6DA54D; Tue, 12 Jun 2007 13:02:02 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 0.0 (/)
X-Spam-Report: AWL=0.034
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49947>

Lars Hjemli wrote:
> 
> (readded the gitlist)
> 
> On 6/12/07, Johannes Sixt <J.Sixt@eudaptics.com> wrote:
> > Lars Hjemli wrote:
> > > Multiple checkout paths for a single submodule will bring havoc on
> > > this plan, so I need to ask: what is the use-case for multiple
> > > checkout paths?
> >
> > A use-case is the admin directory in the KDE repository. It has:
> >
> > KDE (superproject)
> >  +- kdelibs (subproject)
> >  |   +- admin (subproject)
> >  |   +- subdir1
> >  |   +- ...
> >  +- kdebase (subproject)
> >  |   +- admin (subproject)
> >  |   +- subdir2
> >  |   +- ...
> >  +- kdenetwork (subproject)
> >  |   +- admin (subproject)
> >  |   +- subdir3
> >  |   +- ...
> >  ...
> 
> But in this case, 'admin' isn't a submodule/subproject contained by
> KDE, right? It's contained in three different submodules/subprojects:
> kdelibs, kdebase and kdenetwork.

Notice how kdelibs, kdebase and kdenetwork are both submodule and
supermodule: They host the submodule admin and are hosted by KDE.

(If I missed the point, then it's because I didn't follow the
discussion; I jumped in because I noticed the symlink proposal by
chance.)

-- Hannes
