From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] format-patch: autonumber by default
Date: Thu, 02 Oct 2008 15:54:00 +0200
Message-ID: <48E4D278.1000103@viscovery.net>
References: <1222946860-15518-1-git-send-email-giuseppe.bilotta@gmail.com>	 <alpine.DEB.1.00.0810021433130.22125@pacific.mpi-cbg.de.mpi-cbg.de> <cb7bb73a0810020610q657dec7clf85b4ef3575b751f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 15:55:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlOeE-0005eW-Mo
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 15:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907AbYJBNyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 09:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752871AbYJBNyG
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 09:54:06 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:32112 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752754AbYJBNyF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 09:54:05 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KlOcy-0002qk-HU; Thu, 02 Oct 2008 15:54:01 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 4993C6B7; Thu,  2 Oct 2008 15:54:00 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <cb7bb73a0810020610q657dec7clf85b4ef3575b751f@mail.gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97330>

Giuseppe Bilotta schrieb:
> Now, about the reason for this patch: I would say that the most common
> use-case of format-patch being used to prepare multiple patches is
> when one plans on sending a patchset. When format.numbering is set to
> auto, single-patches will still be extracted without numbers, but
> patchset will be properly numbered.
> 
> Of course, there may be cases where one doesn't want numbering (for
> which there is the -N flag already), and of course we want to give the
> user the choice to disable autonumbering at the config level, for
> which there is the new noauto option for format.numbering.

I recall that this has been discussed (months or years ago), but I don't
recall whether there was a conclusion or whether the change was dismissed.
Did you research the ML archives?

-- Hannes
