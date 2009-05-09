From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: [PATCH v3] To make GIT-VERSION-FILE, search for git more widely
Date: Sat, 09 May 2009 20:17:01 +0200
Message-ID: <op.utoc2njr1e62zd@merlin.emma.line.org>
References: <1241688129-31613-1-git-send-email-matthias.andree@gmx.de>
 <7v7i0scvcf.fsf@alter.siamese.dyndns.org>
 <op.utlq3vgx1e62zd@merlin.emma.line.org>
 <7vprek0ywq.fsf@alter.siamese.dyndns.org> <op.utlylkb61e62zd@balu>
 <7vskje6wsy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "git.vger.kernel.org" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 09 20:17:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2r6s-0000Kg-9o
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 20:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483AbZEISRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 14:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753406AbZEISRJ
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 14:17:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:39831 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753316AbZEISRI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 14:17:08 -0400
Received: (qmail invoked by alias); 09 May 2009 18:17:03 -0000
Received: from g225200165.adsl.alicedsl.de (EHLO mandree.no-ip.org) [92.225.200.165]
  by mail.gmx.net (mp070) with SMTP; 09 May 2009 20:17:03 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX18SJhYZSsQSsjGrJgKExk4o0YwareIkaWCjQ5g8gM
	OEzqbXo2rYHeVL
Received: from merlin.emma.line.org (localhost [127.0.0.1])
	by merlin.emma.line.org (Postfix) with ESMTP id D0EEB945CA;
	Sat,  9 May 2009 20:17:01 +0200 (CEST)
In-Reply-To: <7vskje6wsy.fsf@alter.siamese.dyndns.org>
User-Agent: Opera Mail/9.64 (Linux)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118678>

Am 09.05.2009, 18:55 Uhr, schrieb Junio C Hamano <gitster@pobox.com>:

> "Matthias Andree" <matthias.andree@gmx.de> writes:
>
>>> Fine then.  Or you could just append "." to the $PATH ;-)
>>
>> "." in the super user's PATH? Cool stuff, and so innovative.
>
> I didn't mean to suggest PATH=$PATH:. *in the user's environment* ;-).
> You do that inside GIT-VERSION-FILE, which is essentially the same thing
> as running ./git$X from there.
>
> What's innovative is whoever is running build as root.

Back to the real problem, and that is re-checking GIT-VERSION-FILE as part
of "make install". I wonder if we should just have GIT-VERSION-GEN exit if
git isn't in $PATH, and at most copy version there -- rather than stomp
the DEF_VER somewhere.

-- 
Matthias Andree
