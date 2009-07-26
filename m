From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2009, #02; Sun, 26)
Date: Sun, 26 Jul 2009 02:08:19 -0700 (PDT)
Message-ID: <m3ljmb3j7k.fsf@localhost.localdomain>
References: <7viqhfrfu5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 11:08:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUzid-0000BM-K9
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 11:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbZGZJIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 05:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752105AbZGZJIV
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 05:08:21 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:48737 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089AbZGZJIU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2009 05:08:20 -0400
Received: by fxm18 with SMTP id 18so2104040fxm.37
        for <git@vger.kernel.org>; Sun, 26 Jul 2009 02:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=VGc/IxmQ/8bW2ID3Qk+ZxBuXwRNdGY7kpr6DGu9eneE=;
        b=fpObCc4ZwMqdPoPWN4zr59Q1zZr94nZ4ZPXLIF+uGDW6eJ6yvdfYxDRZdlE8GqbYhL
         IWeegx7c7Jgyvh6KyrR610QjwZnNHUJD6SyIs0uBnKP5emuGE+bw304u/xYzNIy2w9F9
         6Ss5416NY/N7w/JIkhHN71fKJFTuOrOVOCKmk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Fkt3mQSaU7F0U2Hw+C1t4siLkuEtX0cLsSHMWjZyFEy7FhyUStXndWC8RdILGy3ref
         L2p1iAbw1n3teTdejpydBV00WDnPH+XM6XSLQgqeNs95qqPeBcdBgn02q7JpiRPk1aG+
         OAtQUgBzeUFv/7eX1DrxtCv8YzUbQXljOj8lI=
Received: by 10.86.65.18 with SMTP id n18mr1204426fga.7.1248599299606;
        Sun, 26 Jul 2009 02:08:19 -0700 (PDT)
Received: from localhost.localdomain (abvh124.neoplus.adsl.tpnet.pl [83.8.205.124])
        by mx.google.com with ESMTPS id e11sm8080506fga.26.2009.07.26.02.08.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Jul 2009 02:08:19 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n6Q98HJH029127;
	Sun, 26 Jul 2009 11:08:17 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n6Q98FEr029123;
	Sun, 26 Jul 2009 11:08:15 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7viqhfrfu5.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124112>

Junio C Hamano <gitster@pobox.com> writes:

> ----------------------------------------------------------------
> [New Topics]
> 
> * jk/show-tag (Sat Jul 18 06:14:37 2009 -0400) 2 commits
>  + show: add space between multiple items
>  + show: suppress extra newline when showing annotated tag
> 
> Didn't look bad at all, but is not pressing either.

I like the output of "git show <tag>" much better than current one
(where I sometimes fall back on "git cat-file -p <tag>").
 
> * jn/gitweb-blame (Sat Jul 25 00:44:10 2009 +0200) 10 commits
>  - gitweb: Create links leading to 'blame_incremental' using
>    JavaScript
>  - gitweb: Incremental blame (proof of concept)
>  - gitweb: Add optional "time to generate page" info in footer
>  - gitweb: Add -partial_query option to href() subroutine

This part (above) is RFC, especially the 'incremental blame' patch,
which is in flux.

Well, perhaps except 'time to generate page' (aka. 'timed' feature),
but even this still have some things (like name of feature enabling
this behavior: currently 'named', or unconditional requiring
Time::HiRes if it exists even if it is not needed).

>  - gitweb: Use light/dark for class names also in 'blame' view
>  - gitweb: Add author initials in 'blame' view, a la "git gui blame"
>  - gitweb: Mark commits with no "previous" in 'blame' view
>  - gitweb: Use "previous" header of git-blame -p in 'blame' view
>  - gitweb: Mark boundary commits in 'blame' view
>  - gitweb: Make .error style generic
> 
> Still in flux/rfc.

This part is, I think, good now (after fixing embarassing but harmless
unquote_maybe() incident ;-)).  Junio had some questions about style
used, but it can be very easily fiddled with later, IMVHO.

> 
> * ns/init-mkdir (Sat Jul 25 06:59:28 2009 +0900) 1 commit
>  + git init: optionally allow a directory argument
> 
> Didn't look bad, but is not pressing either.

This is I think good UI improvement.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
