From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: AW: AW: Parallell Development / Switching to GIT
Date: Thu, 02 Jul 2009 08:20:39 +0200
Message-ID: <4A4C51B7.7010000@viscovery.net>
References: <loom.20090625T095000-90@post.gmane.org> <4A434D6F.2090105@op5.se> <B81058949321C8439B9D742F5F8D8FCA01A75C1D@hpserver.intranet.local> <20090628184714.GA8634@sigio.peff.net> <B81058949321C8439B9D742F5F8D8FCA01A75C33@hpserver.intranet.local> <4A487CCD.1040406@op5.se> <B81058949321C8439B9D742F5F8D8FCA01A75CFA@hpserver.intranet.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: "Patrick Neuner - Futureweb.at" <neuner@futureweb.at>
X-From: git-owner@vger.kernel.org Thu Jul 02 08:21:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMFfI-0000Lp-8u
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 08:21:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752564AbZGBGUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 02:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752560AbZGBGUt
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 02:20:49 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:12076 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379AbZGBGUt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 02:20:49 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MMFey-000289-8G; Thu, 02 Jul 2009 08:20:48 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D95FF4E4; Thu,  2 Jul 2009 08:20:39 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <B81058949321C8439B9D742F5F8D8FCA01A75CFA@hpserver.intranet.local>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122624>

Patrick Neuner - Futureweb.at schrieb:
> We use the update-hook to check into which branches pushes are allowed per different ssh keys. 
> Now, I wonder how I am able to create branches that are below another branch. 
> 
> Like 
> Refs/heads/master
> Refs/heads/dev
> Refs/heads/dev/featureA
> Refs/heads/dev/featureB
> 
> Instead of
> Refs/heads/featureA
> 
> Anything I tried either results in an error or creates the branch under /refs/heads/. 

You cannot have refs/heads/dev and refs/heads/dev/featureA at the same
time, just like you cannot have a file and a directory with the same name
at the same time. In fact, the refs "database" is implemented as physical
files on the file system.

-- Hannes
