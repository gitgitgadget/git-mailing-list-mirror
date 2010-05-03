From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Making git work with new remote server
Date: Mon, 03 May 2010 18:14:47 +0200
Message-ID: <4BDEF677.5070807@drmicha.warpmail.net>
References: <28436896.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: amillican <amillican@cogentsystems.com>
X-From: git-owner@vger.kernel.org Mon May 03 18:14:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8yIL-0008EW-AV
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 18:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759605Ab0ECQOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 12:14:51 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50900 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758731Ab0ECQOu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 May 2010 12:14:50 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A0D24F3D62;
	Mon,  3 May 2010 12:14:49 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 03 May 2010 12:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=JY53PpW5tvKgElVkf+7nul1fL54=; b=MIRfpk8Ygj9d6pmF+IllGhEZoiOSJqjldmjHIqgt+MDQxsUh7APFvILWrA6wDBVNyIuPIGbhPcW1OD4YgabmbNbOUkBNFH5jfw8jk/QgD+t5x4X8tNScfk+RYgeijmC3H+43I9Y0pFZat41UcvykBfX09y/Tne6nIwyrPwtZmqE=
X-Sasl-enc: fIFuyXq0wza63PqFSz4MpCDtZodC6PR1kIEi/9gPQgI9 1272903289
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1E1C72E2E2;
	Mon,  3 May 2010 12:14:49 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100429 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <28436896.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146241>

amillican venit, vidit, dixit 03.05.2010 17:59:
> 
>   0  vote down  star
> 	
> 
> I am the CM person for a small company that just started using Git. We have
> two Git repositories currently hosted on a Windows box that is our
> all-purpose Windows server. But, we just set up a dedicated server for our
> CM software on an Ubuntu Linux server named "Callisto".
> 
> So I created a test Git repository on Callisto. I gave its directory all of
> the proper permissions recursively. I had the sysadmin create a login for me
> on Callisto, and I created a key to use for logging in via SSH. I set up my
> key to use a passphrase; I don't know if that could be contributing to my
> problems? Anyway, I know my SSH login works because I tested it through
> puTTY.
> 
> But, even after hours of trials and head scratching, I can't get my Windows
> Git bash (mSysGit) to talk to Callisto for the purposes of pushing or
> pulling Callisto's git repository files. Obviously, when trying a push, I've
> been trying to log into my Callisto account using SSH.
> 
> I keep getting "Fatal error. The remote end hung up unexpectedly." And I've
> even gotten the error that Git doesn't recognize the test repository on
> Callisto as a git repository. I read online that the "Fatal error...hung up
> unexpectedly" is usually a problem with the server connection or
> permissions. So what am I missing or overlooking here? And why doesn't a
> pull using the git:// protocol work, since that only uses read-only access?
> Group and public permissions for the git repository's directory on Callisto
> are set to read and execute, but not write.
> 
> If anyone could help, I would be so grateful. Thank you.

For git:// without ssh you need a running git-daemon on the server.

For helping you more we would need the actual commands you tried and the
exact output.

Cheers,
Michael
