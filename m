From: "Albert Krawczyk" <albert@burgmann.anu.edu.au>
Subject: RE: Git log follow question
Date: Fri, 14 May 2010 14:43:16 +1000
Message-ID: <00a001caf31f$f837e970$e8a7bc50$@burgmann.anu.edu.au>
References: <006d01caf300$703e96a0$50bbc3e0$@burgmann.anu.edu.au> <21464_1273811837_4BECD37D_21464_745_1_20100514043704.GC6075@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "'Jeff King'" <peff@peff.net>, <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 14 06:43:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCmkY-00043c-2i
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 06:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567Ab0ENEnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 00:43:43 -0400
Received: from anumail8.anu.edu.au ([130.56.64.134]:34029 "EHLO
	anumail8.anu.edu.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898Ab0ENEnk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 May 2010 00:43:40 -0400
Received: from mailout2.anu.edu.au (mailout2.anu.edu.au [130.56.64.233])
	by anumail8.anu.edu.au (8.14.3/8.14.3) with ESMTP id o4E4hRnY012770;
	Fri, 14 May 2010 14:43:27 +1000 (EST)
Received: from mailout2.anu.edu.au (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id 6B9119E845F;
	Fri, 14 May 2010 14:43:27 +1000 (EST)
Received: from smtphost.anu.edu.au (ds1.anu.edu.au [130.56.64.53])
	by mailout2.anu.edu.au (Postfix) with ESMTP id E70259E83A5;
	Fri, 14 May 2010 14:43:26 +1000 (EST)
Received: from AlbertDesktop (burg237222.anu.edu.au [150.203.237.222])
	by smtphost.anu.edu.au (8.14.3/8.14.3) with SMTP id o4E4hQd7018525
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 14 May 2010 14:43:26 +1000 (EST)
In-Reply-To: <21464_1273811837_4BECD37D_21464_745_1_20100514043704.GC6075@coredump.intra.peff.net>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQFu9H07c8Vi9oNqeeVf4wYXfLNCagGqe6sqkvsChcA=
Content-Language: en-au
X-PMX-Version: 5.5.9.395186, Antispam-Engine: 2.7.2.376379, Antispam-Data: 2010.5.14.43316 internal
X-PMX-Outbound: anu.edu.au
X-PMX-Info: from-anu
X-PerlMx-Spam: Gauge=IIIIIIII, Probability=8%, Report='
 SUPERLONG_LINE 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1900_1999 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, FORGED_MUA_OUTLOOK 0, __BOUNCE_CHALLENGE_SUBJ 0, __BOUNCE_NDR_SUBJ_EXEMPT 0, __CP_URI_IN_BODY 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __OUTLOOK_MUA 0, __OUTLOOK_MUA_1 0, __SANE_MSGID 0, __TO_MALFORMED_2 0, __URI_NO_WWW 0, __URI_NS , __USER_AGENT_MS_GENERIC 0'
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147045>

Bo and Peff,

Thank you very much for your explanation. 

Linus, thanks in advance for looking at this.

Regards,
Albert 

-----Original Message-----
From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On Behalf Of Jeff King
Sent: Friday, 14 May 2010 2:37 PM
To: Albert Krawczyk
Cc: Linus Torvalds; git@vger.kernel.org
Subject: Re: Git log follow question

On Fri, May 14, 2010 at 10:57:34AM +1000, Albert Krawczyk wrote:

> I'm having an issue understanding the way git log --follow works with 
> git log --parents
>
> When I run
> git log --parents --pretty=format:Commit:%H%nParent:%P%n%n alloc.c I 
> get:
> Commit:4b25d091ba53c758fae0096b8c0662371857b9d9
> Parent:100c5f3b0b27ec6617de1a785c4ff481e92636c1
>
> [...]
>
> When I try to run git log --parents --follow I get this:
> git log --parents --follow --pretty=format:Commit:%H%nParent:%P%n%n 
> alloc.c
>
> Commit:4b25d091ba53c758fae0096b8c0662371857b9d9
> Parent:75b44066f3ed7cde238cdea1f0bf9e2f1744c820

Hmm. The actual parent is 75b44066. You get 100c5f in the first case because basic revision path-limiting simplifies the history graph to remove uninteresting commits (and rewrites the parents).

So the answer isn't _wrong_ exactly, but it is less useful. Seeing the simplified graph is generally what we want. This is a limitation of the way --follow is implemented. It turns off history pruning because our list of what to prune will be changing over time.

Probably we would have to special-case the FOLLOW_RENAMES code to rewrite the parent list before display.

I'm cc'ing Linus, who has more of a clue in both of those areas than I do.

-Peff
--
To unsubscribe from this list: send the line "unsubscribe git" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
