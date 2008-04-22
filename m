From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Git on Windows, CRLF issues
Date: Tue, 22 Apr 2008 08:31:23 +0200
Message-ID: <480D863B.1040009@viscovery.net>
References: <alpine.DEB.1.00.0804212145570.21181@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Apr 22 08:32:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoC37-0002VW-4n
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 08:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754398AbYDVGb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 02:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754507AbYDVGb1
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 02:31:27 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:34041 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754362AbYDVGb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 02:31:27 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JoC2F-00015y-MJ; Tue, 22 Apr 2008 08:31:25 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 77B776C4; Tue, 22 Apr 2008 08:31:23 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.DEB.1.00.0804212145570.21181@perkele.intern.softwolves.pp.se>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80067>

Peter Karlsson schrieb:
> I have began moving old repositories for Windows-based software to Git.
> Since the tool I am moving from stores everything with CRLF line endings
> and have RCS-like keyword expansion, I'm treating it all as binary data
> when exporting to Git, i.e I have CRLF in the checked-in data (and I do
> want that, since this is Windows-only sources).
> 
> Now the latests msysgit comes along and (finally!) sets core.autocrlf to
> true by default.
> 
> How do I handle this without having everyone breaking check-ins? I can't
> require everyone to do unset core.autocrlf globally. Can I do that with
> gitattributes?

I see 2 other options:

1. Create a custom setup of msysgit that has core.autocrlf set to false.

2. You are still converting repositories? Convert the files in your
repository to LF. I did it like this, but it was a week -or more- worth of
labor to get the scripts in a shape that I could reproduce the conversion
(and it all happened before core.autocrlf even existed).

-- Hannes
