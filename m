From: Pedro Melo <melo@simplicidade.org>
Subject: Re: git-walkthrough-add script
Date: Sat, 5 Jan 2008 04:08:50 +0000
Message-ID: <0F790B89-2FFB-4C54-A109-E55E1FB57D3B@simplicidade.org>
References: <1199426431-sup-6092@south> <20080104072650.GA24685@coredump.intra.peff.net> <1199471454-sup-4786@south> <20080104210751.GB26248@coredump.intra.peff.net> <1199500441-sup-4067@south> <7vprwhf0kf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: William Morgan <wmorgan-git@masanjin.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 05:09:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JB0LX-0007jw-Vq
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 05:09:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbYAEEIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 23:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbYAEEIr
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 23:08:47 -0500
Received: from mail.sl.pt ([212.55.140.13]:34404 "EHLO sl.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751500AbYAEEIq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 23:08:46 -0500
Received: (qmail 9688 invoked from network); 5 Jan 2008 04:08:42 -0000
X-Virus-Status: Clean (0.01170 seconds) ; Version: 0.3-0.88.6
X-Spam-Flag: NO
X-Spam-Status: NO (0.0/5.0) (0.00007 seconds / 0.04719 sA)
	Checked: by PTMail-AS v0.1 on mail.sl.pt
Received: from unknown (HELO [192.168.1.65]) (melo@[85.241.127.244])
          (envelope-sender <melo@simplicidade.org>)
          by mail-sl (qmail-ldap-1.03) with SMTP
          for <wmorgan-git@masanjin.net>; 5 Jan 2008 04:08:42 -0000
Received-SPF: neutral (mail-sl: domain of (null) is neutral about designating 85.241.127.244 as permitted sender)
In-Reply-To: <7vprwhf0kf.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69639>


On Jan 5, 2008, at 2:50 AM, Junio C Hamano wrote:
> They are meant to be different.
>
>     $ git reset --hard
>     $ echo >>Makefile
>     $ echo >>psql/Makefile
>     $ git add -p
>     diff --git a/Makefile b/Makefile
>     index a2177bc..eb250b0 100644
>     --- a/Makefile
>     +++ b/Makefile
>     @@ -54,3 +54,4 @@ snapdiff ::
>             latest=`ls -1dr $(_snap)/release-????-??-?? | head -n  
> 1` &&
>             \
>             diff -X dontdiff -ru "$$latest" .
>
>     +
>     Stage this hunk [y/n/a/d/?]? ^C

BTW, I'm using 1.5.4rc2 and this prompt shows:

Stage this hunk [y/n/a/d/j/J/?]?

but the help (after you press ?) also mentions:

k - leave this hunk undecided, see previous undecided hunk
K - leave this hunk undecided, see previous hunk
s - split the current hunk into smaller hunks

but those three options don't seem to work.

Best regards,
-- 
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!
