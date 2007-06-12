From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH 5/5] Add gitmodules(5)
Date: Tue, 12 Jun 2007 12:48:55 +0200
Organization: eudaptics software gmbh
Message-ID: <466E7A17.CEB0F196@eudaptics.com>
References: <20070611225918.GD4323@planck.djpig.de>
		 <11816319211097-git-send-email-hjemli@gmail.com>
		 <20070612080402.GQ955MdfPADPa@greensroom.kotnet.org> <8c5c35580706120127p649227d8gc706cb8b364d02b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Frank Lichtenheld <frank@lichtenheld.de>,
	Junio C Hamano <gitster@pobox.com>, skimo@liacs.nl
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 12 12:47:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy3uo-00025M-IX
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 12:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbXFLKru (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 06:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751974AbXFLKru
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 06:47:50 -0400
Received: from main.gmane.org ([80.91.229.2]:36645 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751805AbXFLKru (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 06:47:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hy3uU-0006FB-44
	for git@vger.kernel.org; Tue, 12 Jun 2007 12:47:38 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Jun 2007 12:47:38 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Jun 2007 12:47:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49945>

Lars Hjemli wrote:
> Multiple checkout paths for a single submodule will bring havoc on
> this plan, so I need to ask: what is the use-case for multiple
> checkout paths?

A use-case is the admin directory in the KDE repository. It has:

KDE (superproject)
 +- kdelibs (subproject)
 |   +- admin (subproject)
 |   +- subdir1
 |   +- ...
 +- kdebase (subproject)
 |   +- admin (subproject)
 |   +- subdir2
 |   +- ...
 +- kdenetwork (subproject)
 |   +- admin (subproject)
 |   +- subdir3
 |   +- ...
 ...

-- Hannes
