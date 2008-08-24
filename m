From: Pedro Melo <melo@simplicidade.org>
Subject: Re: [PATCH] allow user aliases for the --author parameter
Date: Sun, 24 Aug 2008 10:19:20 +0100
Message-ID: <8F4F767F-3D7B-4358-AAD3-8E2BC7EA108D@simplicidade.org>
References: <g8jbvd$18k$1@ger.gmane.org> <20080821200255.GB27705@coredump.intra.peff.net> <48AE786C.20201@fastmail.fm> <20080822165047.GA3339@sigill.intra.peff.net> <7vzln492pc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <michaeljgruber+gmane@fastmail.fm>,
	Alex Riesen <fork0@users.sourceforge.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 11:21:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXBln-0001hD-OW
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 11:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399AbYHXJTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 05:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751976AbYHXJTT
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 05:19:19 -0400
Received: from mail.sl.pt ([212.55.140.13]:49277 "EHLO sl.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751850AbYHXJTS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 05:19:18 -0400
Received: (qmail 22382 invoked from network); 24 Aug 2008 09:19:14 -0000
Received: from unknown (HELO [192.168.1.76]) (melo@[81.193.150.226])
          (envelope-sender <melo@simplicidade.org>)
          by mail-sl (qmail-ldap-1.03) with SMTP
          for <peff@peff.net>; 24 Aug 2008 09:19:14 -0000
In-Reply-To: <7vzln492pc.fsf@gitster.siamese.dyndns.org>
Jabber-Id: melo@simplicidade.org
X-Mailer: Apple Mail (2.753.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93524>

Hi,

On Aug 22, 2008, at 10:09 PM, Junio C Hamano wrote:
> Another potential source of this information is the existing  
> commits.  If
> you are communicating with the same set of people already, you already
> have the information in your repository.  I suspect Michael's  
> "selected
> few co-workers that would comfortably fit in a small list of config
> entries without need for any external text file" use case would be  
> better
> served by an approach to look into existing commits.
>
> I often use "git who Jeff" alias to fill the recipient of my e- 
> mails with
> this alias:
>
>     [alias]
>         who = "!sh -c 'git log -1 --pretty=\"format:%an <%ae>\" -- 
> author=\"$1\"' -"

Nice:)

>         one = "!sh -c 'git show -s --pretty=\"format:%h (%s, %ai\"  
> \"$@\" | sed -e \"s/ [012][0-9]:[0-5][0-9]:[0-5][0-9] [-+][0-9][0-9] 
> [0-9][0-9]$/)/\"' -"

Can you explain this one? It seems a bit like git describe, but it  
misses a single char at the beggining?

git (master) $ git one
2ebc02d (Start 1.6.1 cycle, 2008-08-17)

git (master) $ git describe
v1.6.0-2-g2ebc02d

Best regards,
-- 
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!
