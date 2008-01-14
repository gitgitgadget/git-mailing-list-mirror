From: Pedro Melo <melo@simplicidade.org>
Subject: Re: git-svn: network error while git-svn dcommit
Date: Mon, 14 Jan 2008 15:34:54 +0000
Message-ID: <0876BB1D-8830-47B1-8910-E95BA07EA405@simplicidade.org>
References: <75A83473-664E-4CC8-97ED-119D18F17F76@simplicidade.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Pedro Melo <melo@simplicidade.org>
X-From: git-owner@vger.kernel.org Mon Jan 14 16:35:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JERLA-0002bl-QZ
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 16:35:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbYANPel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 10:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbYANPek
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 10:34:40 -0500
Received: from mail.sl.pt ([212.55.140.13]:54364 "EHLO sl.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751019AbYANPek (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 10:34:40 -0500
Received: (qmail 16667 invoked from network); 14 Jan 2008 15:34:37 -0000
X-Virus-Status: Clean (0.01598 seconds) ; Version: 0.3-0.88.6
X-Spam-Flag: NO
X-Spam-Status: NO (0.0/5.0) (0.00020 seconds / 0.06211 sA)
	Checked: by PTMail-AS v0.1 on mail.sl.pt
Received: from unknown (HELO [10.0.0.5]) (melo@[213.205.66.71])
          (envelope-sender <melo@simplicidade.org>)
          by mail-sl (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 14 Jan 2008 15:34:37 -0000
Received-SPF: neutral (mail-sl: domain of (null) is neutral about designating 213.205.66.71 as permitted sender)
In-Reply-To: <75A83473-664E-4CC8-97ED-119D18F17F76@simplicidade.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70461>

Hi,

sorry to reply to myself. Figure it out.

Created a new branch from the remote svn, brought it up-to-date, then  
got the last applied sha1, and rebased that onto my new branch.

there might be an easier way, but this worked.

Best regards,

On Jan 14, 2008, at 1:20 PM, Pedro Melo wrote:

> Hi,
>
> I was doing a git-svn dcommit (git-1.5.4-rc2)  and the network to  
> the svn server died on me.
>
> Network connection closed unexpectedly: Connection closed  
> unexpectedly at /usr/local/git/bin/git-svn line 450
>
> If I try again, I get a warning about a dirty index.
>
> Cannot dcommit with a dirty index.  Commit your changes first, or  
> stash them with `git stash'.
>  at /usr/local/git/bin/git-svn line 406
>
> What's the best way to recover from this?
>
> Thanks,
> -- 
> Pedro Melo
> Blog: http://www.simplicidade.org/notes/
> XMPP ID: melo@simplicidade.org
> Use XMPP!
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!
