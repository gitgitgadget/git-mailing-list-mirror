From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Linus and whitespace
Date: Sun, 01 Feb 2009 17:48:51 -0500
Message-ID: <498626D3.1020202@gmail.com>
References: <87fxix3hub.fsf@jidanni.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: torvalds@linux-foundation.org, git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Sun Feb 01 23:50:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTl8w-0001i3-8j
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 23:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970AbZBAWs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 17:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753202AbZBAWs4
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 17:48:56 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:40659 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753141AbZBAWsz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 17:48:55 -0500
Received: by yw-out-2324.google.com with SMTP id 9so452063ywe.1
        for <git@vger.kernel.org>; Sun, 01 Feb 2009 14:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=MDvQ7JhvfBPgdcguPyuIOA5zMaN7/B+T3kh/qaUhKh4=;
        b=c2X/H0EZXdF8HVh49d/HjPsBHAcwz6E9W4s0iLm7uC/F7pTBr41DEghvTyN5hNhR+i
         AqeKCl73oEceeyvbWmiDu9nSVLUjBjo5E8L5+0xNXlCqXVNVN4UOedgm8cF2WBZ+BlIY
         wahZiQw1oj+qqABTBBtS5oo6zgGMBxblBe0fA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=iXFzq3yrsIa7nQyaERdRBY4NeU1oJqk+pW/2lEoOWe5bC/kSp3wrYQDH1oyPMfx8eX
         76hjRufhAU4ROv7eDoAQJwiRzU64sOvu+P0npMiGG5mCkIeqTFmslh2t0bj4h1aawVfg
         HAFPHi0pRrfGZCKLH0w31Lzyxjj520L1YHdtc=
Received: by 10.100.142.4 with SMTP id p4mr909421and.23.1233528534268;
        Sun, 01 Feb 2009 14:48:54 -0800 (PST)
Received: from ?10.0.0.6? (c-66-177-19-100.hsd1.fl.comcast.net [66.177.19.100])
        by mx.google.com with ESMTPS id b14sm5588499ana.56.2009.02.01.14.48.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 01 Feb 2009 14:48:53 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <87fxix3hub.fsf@jidanni.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108021>

jidanni@jidanni.org wrote:
> Gentlemen, I couldn't help but notice a certain Linus B. Torvalds is
> producing mail with trailing whitespace.
> 
> I recall one should (linux-doc-*/Documentation/CodingStyle*:)
> "Get a decent editor and don't leave whitespace at the end of lines."
> 
> Indeed, with my GNU Emacs show-trailing-whitespace X-ray
> eyespecs on all day, whitespace becomes screaming purple space, so you
> can't blame me for noticing.
> 
> Anyway, I have analyzed his messages,
> (User-Agent: Alpine 2.00 (LFD 1167 2008-08-23))
> and discovered that the whitespace phenomenon almost always occurs if
> the lines are more than 60 characters long, the "danger zone", we might say.
> 
> $ perl -nwle 'print length if / $/' recent_linus_postings|
> sort|uniq -c|sort -k 2nr
>       1 77
>       1 76
>      17 75
>      17 74
>      11 73
>      18 72
>      12 71
>       6 70
>       8 69
>       6 68
>       2 67
>       1 66
>       2 64
>       1 63
>       1 40
>       9 2

CodingStyle applies to *patches* not to discussion. In how many of those 
emails you analyzed were there any trailing whitespace in a patch?
