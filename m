From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: pack.packSizeLimit, safety checks
Date: Mon, 01 Feb 2010 17:26:55 +0100
Message-ID: <4B6700CF.1090106@viscovery.net>
References: <loom.20100201T101056-232@post.gmane.org> <alpine.LFD.2.00.1002011100550.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sergio <sergio.callegari@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Feb 01 17:27:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nbz7A-00046U-Ec
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 17:27:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755491Ab0BAQ07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 11:26:59 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:2204 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754816Ab0BAQ06 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 11:26:58 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Nbz72-0006JY-E4; Mon, 01 Feb 2010 17:26:56 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 2A6231660F;
	Mon,  1 Feb 2010 17:26:56 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <alpine.LFD.2.00.1002011100550.1681@xanadu.home>
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138621>

Nicolas Pitre schrieb:
> Grrrrr.  This is a terrible discrepency given that all the other 
> arguments in Git are always byte based, with the optional k/m/g suffix, 
> by using git_parse_ulong().  So IMHO I'd just change --max-pack-size to 
> be in line with all the rest and have it accept bytes instead of MB.  
> And of course I'd push such a change to be included in v1.7.0 along with 
> the other incompatible fixes.

While at it, also change --big-file-threshold that fast-import learnt the
other day...

-- Hannes
