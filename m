From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Resetting working files
Date: Sun, 31 May 2009 23:30:10 +0200
Message-ID: <81b0412b0905311430v7874013cm6db84bd12d749134@mail.gmail.com>
References: <DA26600008CE404B831978F6EBB31C6B@HPLAPTOP>
	 <4A229B9A.6060807@dirk.my1.cc>
	 <20090531162515.GB8129@m62s10.vlinux.de>
	 <20090531163225.GE3674@debian.b2j>
	 <9719867c0905310950x153db8efw179a8a10ac3f4640@mail.gmail.com>
	 <20090531173932.GA13856@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Aaron Gray <aaronngray.lists@googlemail.com>,
	Peter Baumann <waste.manager@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Sun May 31 23:30:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAsbo-0001PD-MI
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 23:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300AbZEaVaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 17:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbZEaVaL
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 17:30:11 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:56742 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbZEaVaK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 17:30:10 -0400
Received: by bwz22 with SMTP id 22so7136846bwz.37
        for <git@vger.kernel.org>; Sun, 31 May 2009 14:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cix+sk/AbEMCrzyN6A3zZzA7CSsYD5tCIKU18q6PsT0=;
        b=L9khvCyYGTww7g4CTtlmYM20KF8yt07w/t3Y11j4oi6f/xYx63LRPV42EZXJ33hP1m
         ftpR9O/5fY6woeP9qPFLiTy3wDg8dFJlZYT4viizeSmtCobBMhYN2VzD29toBoagD4qk
         rhAr2TK/kTls/WPnLb9z9Xn8se3MmbUCzrp2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hC7tg82xA5Iq6SSP1p2DXzuTznULJxzt8kwUcJBFmxcP73QXPmd2d772dJgwegYyat
         yGN3mKaJvSvQS/MvmWKsfgfWpz7f+XPf4e9p6qzKCOPILwA2YCENvIFGhYkz9tr6B1FH
         /kKp3PPEN/9gvgEVGjbY7yJTEG3rVbvQoQu5k=
Received: by 10.204.117.141 with SMTP id r13mr4990070bkq.207.1243805411052; 
	Sun, 31 May 2009 14:30:11 -0700 (PDT)
In-Reply-To: <20090531173932.GA13856@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120432>

2009/5/31 Nicolas Sebrecht <nicolas.s.dev@gmx.fr>:
> The 31/05/09, Aaron Gray wrote:
>>
>> I think index is HEAD or a revision hash. Am I correct ?
>
> HEAD is a reference to a branch name:

Not really. Try "git checkout HEAD^" and run cat .git/HEAD

It is more a pointer to a commit. The pointers to a commit
in git are allowed to be indirect by referencing other pointers.
