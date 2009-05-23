From: Richard Quadling <rquadling@googlemail.com>
Subject: Re: Heap allocation error in git-1.6.2.4 on Cygwin. Problem not 
	present in git-1.6.1.2
Date: Sat, 23 May 2009 09:01:57 +0100
Message-ID: <10845a340905230101w677510ebje387b93fcdac2d87@mail.gmail.com>
References: <10845a340905220423x69eb1718n7a6f9dcd5c2df459@mail.gmail.com> 
	<be6fef0d0905220929p64f45f52ub8dd39feb063936b@mail.gmail.com>
Reply-To: RQuadling@googlemail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 23 10:08:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7mHn-0006yE-2B
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 10:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbZEWIIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 04:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbZEWIIp
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 04:08:45 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:50219 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbZEWIIo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 04:08:44 -0400
X-Greylist: delayed 388 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 May 2009 04:08:44 EDT
Received: by fxm12 with SMTP id 12so272497fxm.37
        for <git@vger.kernel.org>; Sat, 23 May 2009 01:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=lLmlsdQz35jaMrJJhZ5LyJX1aN/mza5ygE/0ioL+IhI=;
        b=m8oM6lVKk5+M4i7O3oJRGHnyPpS6vKN1cfkBxOYHqC8yyxPN9hCpBkpCmzj3uQNbjz
         z15ze0JWFpSlXfY/CP83Zk5idlPbP/uSSdUWda2aUXVTcFrLo0D6b9Uq+sfaAthzQXsu
         1HPYPjki2Gb4fVnoNYciJa32ZOIdehJ4RUu60=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=HItgKaGWYIAs++mKXgen+OTFyFD+okUEV6X9uKxL9mTiWT/SVGeEKw5Sj/fzi5g7n9
         nKdoRLRuqrsvJBGWOFxCI0A9zh4srAY259JRhvON04HbXOIajWMeCmOXr9D5aMyHjAZg
         yD1O3qraRvMSe19p9AkDTdovn0opEUfyh7kZM=
Received: by 10.223.108.210 with SMTP id g18mr2698154fap.38.1243065737172; 
	Sat, 23 May 2009 01:02:17 -0700 (PDT)
In-Reply-To: <be6fef0d0905220929p64f45f52ub8dd39feb063936b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119759>

2009/5/22 Tay Ray Chuan <rctay89@gmail.com>:
> Hi,
>
> On Fri, May 22, 2009 at 7:23 PM, Richard Quadling
> <rquadling@googlemail.com> wrote:
>> I've just upgraded GIT on Cygwin from git-1.6.1.2 to git-1.6.2.4.
>
> you would be better off posting this on the cygwin list; I've read of
> some git problems there.
>
> --
> Cheers,
> Ray Chuan
>

OK. Thank you,

-- 
-----
Richard Quadling
Zend Certified Engineer : http://zend.com/zce.php?c=ZEND002498&r=213474731
"Standing on the shoulders of some very clever giants!"
