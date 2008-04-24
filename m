From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Git on Windows, CRLF issues
Date: Thu, 24 Apr 2008 08:25:56 +0200
Message-ID: <481027F4.5060905@viscovery.net>
References: <alpine.DEB.1.00.0804212145570.21181@perkele.intern.softwolves.pp.se>	 <alpine.DEB.1.00.0804212104560.2298@eeepc-johanness>	 <32541b130804211453x77f3fd49hef645a417a9919ca@mail.gmail.com>	 <20080422023918.GA5402@sigill.intra.peff.net>	 <32541b130804220951p224c9be7ya4e8de5056481fd1@mail.gmail.com>	 <20080423080826.GA11935@sigill.intra.peff.net>	 <480F1671.2060602@viscovery.net> <32541b130804231302i732dbf08v88f8909f241ab99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Peter Karlsson <peter@softwolves.pp.se>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 08:26:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jouus-0007x3-Kf
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 08:26:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbYDXG0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2008 02:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbYDXGZ7
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Apr 2008 02:25:59 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:14832 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbYDXGZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2008 02:25:59 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Jouu4-0005O3-L5; Thu, 24 Apr 2008 08:25:56 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 4CA476B7; Thu, 24 Apr 2008 08:25:56 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <32541b130804231302i732dbf08v88f8909f241ab99@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80295>

Avery Pennarun schrieb:
> On 4/23/08, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> In practice, this is not sufficient. The blob filter must have an
>>  opportunity to decide what it wants to do, not just blindly munge every
>>  blob. The minimum is a path name, e.g. in $1:
> 
> Actually, it may not have been intentional, but because of the way
> 'eval' works, the munge script will find that $path already contains
> the path of the file being munged.  Works for me.

Yes, of course! So I stand corrected, and Jeff's patch makes sense.

For consistency's sake, the path should be made available in, say,
GIT_BLOB_PATH just like the commit is available in GIT_COMMIT.

-- Hannes
