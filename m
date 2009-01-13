From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: egit problem with sym linked eclipse project dirs
Date: Tue, 13 Jan 2009 22:37:11 +0100
Message-ID: <200901132237.11946.robin.rosenberg.lists@dewire.com>
References: <p0624081cc5928e2885fd@[192.168.1.114]>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Scott Cytacki <scytacki@fastmail.fm>
To: Stephen Bannasch <stephen.bannasch@deanbrook.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 13 22:38:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMqy9-00075R-DZ
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 22:38:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756082AbZAMVhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 16:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755864AbZAMVhR
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 16:37:17 -0500
Received: from mail.dewire.com ([83.140.172.130]:9527 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755578AbZAMVhP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 16:37:15 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C7B8A147E5B9;
	Tue, 13 Jan 2009 22:37:13 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5CItiXNAV-Dt; Tue, 13 Jan 2009 22:37:13 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 46CE9147E5B7;
	Tue, 13 Jan 2009 22:37:13 +0100 (CET)
User-Agent: KMail/1.10.92 (Linux/2.6.27-11-generic; KDE/4.1.85; i686; ; )
In-Reply-To: <p0624081cc5928e2885fd@[192.168.1.114]>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105540>

> To hack around Eclipse's problem with projects in nested directories 
> I clone a repo and then create a new top-level dir that just has 
> symbolic links to all the project directories.
> 
> However when I Team/Share with git using egit the resources become 
> untracked when displayed in Eclipse -- they still are tracked however 
> when I check from the command line.

I've seen this too, but so far not got myself to actually fix it. I think it has do with
that we ask eclipse project for it's path end there we gets off track. Thanks
for providing a good example that help "someone" to fix it. 

Could you add an issue at http://code.google.com/p/egit/issues/list and maybe
include a tar  ball with a simple project displaying this behaviour? (with a note
that the symlinks makes this impossible to recreate on Windows).

-- robin
