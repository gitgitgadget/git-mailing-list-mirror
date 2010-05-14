From: "Albert Krawczyk" <albert@burgmann.anu.edu.au>
Subject: RE: Git log follow question
Date: Sat, 15 May 2010 08:39:26 +1000
Message-ID: <004001caf3b6$4f1082c0$ed318840$@burgmann.anu.edu.au>
References: <006d01caf300$703e96a0$50bbc3e0$@burgmann.anu.edu.au> <20100514043704.GC6075@coredump.intra.peff.net> <alpine.LFD.2.00.1005140730030.3711@i5.linux-foundation.org> <AANLkTimfuINt0v_SETz9NsMGVXDL9d150B8En4TKqw3b@mail.gmail.com> <22729_1273851106_4BED6CE2_22729_6897_1_alpine.LFD.2.00.1005140827250.3711@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 15 00:39:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OD3Xo-0006dr-9v
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 00:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759558Ab0ENWjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 18:39:42 -0400
Received: from anumail8.anu.edu.au ([130.56.64.134]:47674 "EHLO
	anumail8.anu.edu.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958Ab0ENWjl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 18:39:41 -0400
Received: from mailout1.anu.edu.au (mailout1.anu.edu.au [130.56.64.232])
	by anumail8.anu.edu.au (8.14.3/8.14.3) with ESMTP id o4EMdbdr014653
	for <git@vger.kernel.org>; Sat, 15 May 2010 08:39:37 +1000 (EST)
Received: from mailout1.anu.edu.au (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id F02C814A09B5
	for <git@vger.kernel.org>; Sat, 15 May 2010 08:39:36 +1000 (EST)
Received: from smtphost.anu.edu.au (ds2.anu.edu.au [130.56.64.54])
	by mailout1.anu.edu.au (Postfix) with ESMTP id BAA1514A09AD
	for <git@vger.kernel.org>; Sat, 15 May 2010 08:39:36 +1000 (EST)
Received: from AlbertDesktop (burg237222.anu.edu.au [150.203.237.222])
	by smtphost.anu.edu.au (8.14.3/8.14.3) with SMTP id o4EMdaKJ011463
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Sat, 15 May 2010 08:39:36 +1000 (EST)
In-Reply-To: <22729_1273851106_4BED6CE2_22729_6897_1_alpine.LFD.2.00.1005140827250.3711@i5.linux-foundation.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQFu9H07c8Vi9oNqeeVf4wYXfLNCagEHG7fXAhCpKUACZkzwxwJ8X7PQksmuzIA=
Content-Language: en-au
X-PMX-Version: 5.5.9.395186, Antispam-Engine: 2.7.2.376379, Antispam-Data: 2010.5.14.222715 internal
X-PMX-Outbound: anu.edu.au
X-PMX-Info: from-anu
X-PerlMx-Spam: Gauge=X, Probability=10%, Report='
 TO_IN_SUBJECT 0.5, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1300_1399 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, FORGED_MUA_OUTLOOK 0, TO_NO_NAME 0, __BOUNCE_CHALLENGE_SUBJ 0, __BOUNCE_NDR_SUBJ_EXEMPT 0, __CP_URI_IN_BODY 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __OUTLOOK_MUA 0, __OUTLOOK_MUA_1 0, __SANE_MSGID 0, __TO_MALFORMED_2 0, __URI_NO_WWW 0, __URI_NS , __USER_AGENT_MS_GENERIC 0'
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147125>

Hi,

Thank you everybody for your replies.

I believe that this functionality would be useful; however, sadly my C
skills are non-existent so I don't even know how to start looking at this
problem.

I don't suppose there are other developers on here that would be interested
in having a look at this functionality?

Thanks again,
Albert 

-----Original Message-----
From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On Behalf
Of Linus Torvalds
Sent: Saturday, 15 May 2010 1:29 AM
To: Martin Langhoff
Cc: Jeff King; Albert Krawczyk; git@vger.kernel.org
Subject: Re: Git log follow question



On Fri, 14 May 2010, Martin Langhoff wrote:
> 
> The use case for this is: "Where the hell does this WTF-worthy 
> function come from, in this WTF-esque old codebase I just inherited?"

Umm. And git does that better than anything else. 

"git log --follow" works fine. As does "git blame -C".

It's just that gitk does not, because it wants to show the graph.

Anyway, if you feel strongly about it, and really want "gitk --follow", you
really need to do it yourself. I gave you some pointers. I personally don't
think it's worth it.

		Linus
--
To unsubscribe from this list: send the line "unsubscribe git" in the body
of a message to majordomo@vger.kernel.org More majordomo info at
http://vger.kernel.org/majordomo-info.html
