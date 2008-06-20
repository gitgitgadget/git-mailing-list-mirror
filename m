From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Importing non-version controlled bits and pieces to Git
Date: Fri, 20 Jun 2008 14:57:51 +0200
Message-ID: <485BA94F.4090805@viscovery.net>
References: <Pine.LNX.4.64.0806201036440.24013@ds9.cixit.se> <20080620115102.GW29404@genesis.frugalware.org> <alpine.DEB.1.00.0806201323390.6439@racer> <Pine.LNX.4.64.0806201339330.4004@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Git Mailing List <git@vger.kernel.org>
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Jun 20 14:58:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9gCZ-00017f-Mu
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 14:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322AbYFTM54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 08:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753312AbYFTM5z
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 08:57:55 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:57530 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309AbYFTM5y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 08:57:54 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1K9gBc-000694-DU; Fri, 20 Jun 2008 14:57:52 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 1B6F54FB; Fri, 20 Jun 2008 14:57:52 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0806201339330.4004@ds9.cixit.se>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85633>

Peter Karlsson schrieb:
> One complicating factor is that I am working with DOS/Windows source
> code, so all text files have CRLF line-endings, which means converting
> before feeding to fast-import, or manually doing "git add" with
> core.autocrlf == true. fast-import can't be set up to do CRLF
> auto-conversion, can it?

No, but you can put `tr -d '\015'` in the pipeline in front of
fast-import. (Unless, of course, you also have to feed binary data.)

-- Hannes
