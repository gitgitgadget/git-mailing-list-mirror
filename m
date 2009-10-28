From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 0/4] Cygwin MSVC patches
Date: Wed, 28 Oct 2009 07:56:06 +0100
Message-ID: <4AE7EB06.10305@viscovery.net>
References: <4AE7410D.3030109@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>, mstormo@gmail.com
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Oct 28 07:57:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N32Sz-0001ig-Tt
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 07:57:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbZJ1G4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 02:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbZJ1G4H
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 02:56:07 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:60274 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932105AbZJ1G4E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 02:56:04 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N32Ry-00047w-Pj; Wed, 28 Oct 2009 07:56:06 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5ACA2BC81; Wed, 28 Oct 2009 07:56:06 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4AE7410D.3030109@ramsay1.demon.co.uk>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131410>

Ramsay Jones schrieb:
> Hi Junio,
> 
> I've had these patches "hanging around" in my queue, for a few
> weeks, with every intention of adding several more to fix up
> some problems... Hmm, well I haven't got to those yet, so I
> thought I may as well pass these on.
> 
> [PATCH 1/4] MSVC: Fix an "unresolved symbol" linker error on cygwin
> [PATCH 2/4] Makefile: merge two Cygwin configuration sections into one
> [PATCH 3/4] Makefile: keep MSVC and Cygwin configuration separate
> [PATCH 4/4] win32: Improve the conditional inclusion of WIN32 API code
> 
> I think they are all pretty safe (famous last words), but it would be
> a good idea for someone with an MSYS/MinGW installation to test them
> (particularly patch #4; it's really the only one I'm slightly worried
> about :D).
> 
> With these patches, the msvc build on cygwin seems to be working fine.

What is "the msvc build on cygwin"?

Is it "git built with msvc, then run in cygwin"?

-- Hannes
