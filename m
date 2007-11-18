From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: ! [rejected] master -> master (non-fast forward)
Date: Sun, 18 Nov 2007 19:29:01 +0100
Message-ID: <20071118182901.GA5939@steel.home>
References: <9e4733910711180712n6ee271fau774310e63ab08f6d@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 19:30:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItouC-0006GB-8e
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 19:30:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbXKRS3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 13:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbXKRS3J
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 13:29:09 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:50849 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbXKRS3I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 13:29:08 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzAPrzg==
Received: from tigra.home (Fc945.f.strato-dslnet.de [195.4.201.69])
	by post.webmailer.de (fruni mo20) (RZmta 14.3)
	with ESMTP id z00d9ejAIEHdP9 ; Sun, 18 Nov 2007 19:29:03 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id B740E277AE;
	Sun, 18 Nov 2007 19:29:02 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 0467B56D22; Sun, 18 Nov 2007 19:29:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <9e4733910711180712n6ee271fau774310e63ab08f6d@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65379>

Jon Smirl, Sun, Nov 18, 2007 16:12:10 +0100:
> What's causing this? I'm using stgit on the master branch.
> I'm fixing it each time on the remote server by deleting the ref to master.
> 
> jonsmirl@terra:~/ds$ git push digispeaker
> To ssh://jonsmirl1@git.digispeaker.com/~/projects/digispeaker-kernel.git
>  ! [rejected]        master -> master (non-fast forward)
> error: failed to push to

the branch you are pushing does not fast-forward to the one on
digispeaker. IOW, the master on digispeaker has changed since you made
changes on your local master.
