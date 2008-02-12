From: Bill Priest <priestwilliaml@yahoo.com>
Subject: Re: git 1.5.4.1 svn fetch stops fetching w/ "Last fetch revision ..."
Date: Tue, 12 Feb 2008 06:34:41 -0800 (PST)
Message-ID: <167999.8397.qm@web55008.mail.re4.yahoo.com>
References: <883188.51167.qm@web55015.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: Bill Priest <priestwilliaml@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 15:35:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOwEA-0005i3-MF
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 15:35:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761118AbYBLOen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 09:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761143AbYBLOen
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 09:34:43 -0500
Received: from web55008.mail.re4.yahoo.com ([206.190.58.142]:44388 "HELO
	web55008.mail.re4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1761118AbYBLOem (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Feb 2008 09:34:42 -0500
Received: (qmail 8783 invoked by uid 60001); 12 Feb 2008 14:34:41 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=F6xT51Prthwos1rg0dzCPRjpgmMmZmD0ljunvQJh90oB31GgkrX2GaiZCDPHilbyNazqxiouEvTO2SBH23CZIeN1JJdZQpa0WUBkLvNd+zPtnFnnM/lEQRG8+1vPpjTdtOqylu9wXvWGqtvJfThwCP4vPkhj2GziVzUrxCfZvOM=;
X-YMail-OSG: m3fgAYIVM1krebvo.pGircMkaMRYIZ9f4vR1Oz6O0176RkHhmrmF7v1CAxwHIHKZGajSJbYxXmFb_2D5.fuL_aePPeMWS1Jn.7M24IKvgSfu2moPmg--
Received: from [12.44.137.148] by web55008.mail.re4.yahoo.com via HTTP; Tue, 12 Feb 2008 06:34:41 PST
In-Reply-To: <883188.51167.qm@web55015.mail.re4.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73664>


--- Bill Priest <priestwilliaml@yahoo.com> wrote:

> All,
>     I upgraded from git 1.5.3.4.452.g09149 to git
> 1.5.4.1 and upon a subsequent git svn fetch I
> started
> receiving the following:
> Index mismatch:
> d1437ce54ff0e90f4023ee653761c28626a8295a !=
> f567f1f12e7d7ddf1d18e3889061aa9a783dfbba
> rereading 1c3d0737f3eb78241eb508e7da6b80e3f3b7fa85
>         M       src/foo.c
>         M       src/bar.c
> Last fetched revision of refs/remotes/release was
> r2990, but we are about to fetch: r2985!
> 
> git svn fetch w/ 1.5.3 worked correctly and
> subsequent
> fetches "do nothing" as expected.
> 
> Is this a known issue?  Is there a work-around? I
> can
> try to track down which change caused the breakage
> if
> needed.
> 
> Thanks,
> 
> Bill

Here is an update.  The problem first occurs in
1.5.4.rc0 and isn't present in 1.5.3.7

FYI,

Bill


      ____________________________________________________________________________________
Never miss a thing.  Make Yahoo your home page. 
http://www.yahoo.com/r/hs
