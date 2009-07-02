From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Parallell Development / Switching to GIT
Date: Thu, 02 Jul 2009 13:55:12 +0200
Message-ID: <4A4CA020.5020108@viscovery.net>
References: <loom.20090625T095000-90@post.gmane.org> <4A434D6F.2090105@op5.se> <B81058949321C8439B9D742F5F8D8FCA01A75C1D@hpserver.intranet.local> <20090628184714.GA8634@sigio.peff.net> <B81058949321C8439B9D742F5F8D8FCA01A75C33@hpserver.intranet.local> <4A487CCD.1040406@op5.se> <B81058949321C8439B9D742F5F8D8FCA01A75CFA@hpserver.intranet.local> <4A4C51B7.7010000@viscovery.net> <B81058949321C8439B9D742F5F8D8FCA01A75D15@hpserver.intranet.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: "Patrick Neuner - Futureweb.at" <neuner@futureweb.at>
X-From: git-owner@vger.kernel.org Thu Jul 02 13:55:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMKtQ-0007Dr-1t
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 13:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbZGBLzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 07:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752768AbZGBLzW
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 07:55:22 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:64008 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbZGBLzU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 07:55:20 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MMKsi-0005Ru-FG; Thu, 02 Jul 2009 13:55:19 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2885D4E4; Thu,  2 Jul 2009 13:55:12 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <B81058949321C8439B9D742F5F8D8FCA01A75D15@hpserver.intranet.local>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122637>

Please don't top-post on this list.

Patrick Neuner - Futureweb.at schrieb:
>> You cannot have refs/heads/dev and refs/heads/dev/featureA at the same
>> time, just like you cannot have a file and a directory with the same
>> name
>> at the same time. In fact, the refs "database" is implemented as
>> physical
>> files on the file system.
> 
> ok, I see, well then this howto (at the end of page) seems to be misleading. 
> http://www.kernel.org/pub/software/scm/git/docs/howto/update-hook-example.txt
> as it actually works with the update hook, but not with git itself. 

Are you refering to the example line such as

        refs/heads/bw/.*	linus


? Of course, you can have refs/heads/dev/featureA in your repository (and
the shortened branch name would obviously be "dev/featureA"), but then you
cannot have a branch named "dev", i.e. refs/heads/dev.

I don't see how the cited document would be misleading in this regard.

-- Hannes
