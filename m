From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Git on Windows, CRLF issues
Date: Wed, 23 Apr 2008 17:12:15 +0200
Message-ID: <480F51CF.8080200@viscovery.net>
References: <alpine.DEB.1.00.0804212145570.21181@perkele.intern.softwolves.pp.se> <alpine.DEB.1.00.0804212104560.2298@eeepc-johanness> <32541b130804211453x77f3fd49hef645a417a9919ca@mail.gmail.com> <20080422023918.GA5402@sigill.intra.peff.net> <32541b130804220951p224c9be7ya4e8de5056481fd1@mail.gmail.com> <Pine.LNX.4.64.0804230806220.18401@ds9.cixit.se> <20080423081025.GB11935@sigill.intra.peff.net> <Pine.LNX.4.64.0804231445550.18401@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Wed Apr 23 17:15:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jogef-0002vP-Ua
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 17:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbYDWPMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 11:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbYDWPMS
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 11:12:18 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:38273 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbYDWPMR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 11:12:17 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Jogdr-0007bu-FY; Wed, 23 Apr 2008 17:12:15 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 3CD716D9; Wed, 23 Apr 2008 17:12:15 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0804231445550.18401@ds9.cixit.se>
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80223>

Peter Karlsson schrieb:
> [Not seeing any unreachable objects]
> Jeff King:
>> Did you remove refs/original/ ?
> 
> That, and cloned the repository to a new location after the conversion,
> and removing the references to "origin" there. It does seem that the
> objects are still there, but I can't see them with "gitk --all".

Did you clone locally? Then you must use the file:// protocol, otherwise
everything is hard-linked from the origin.

-- Hannes
