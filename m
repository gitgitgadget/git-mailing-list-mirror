From: Perrin Meyer <perrinmeyer@yahoo.com>
Subject: Re: git svn dcommit seg fault
Date: Wed, 18 Jul 2007 11:33:45 -0700 (PDT)
Message-ID: <635722.69437.qm@web52806.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ascii
Cc: git@vger.kernel.org
To: Eric Wong <eric@petta-tech.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 20:34:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBELn-0003AY-Ep
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 20:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762247AbXGRSds (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 14:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761752AbXGRSds
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 14:33:48 -0400
Received: from web52806.mail.re2.yahoo.com ([206.190.48.249]:36765 "HELO
	web52806.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759464AbXGRSdr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jul 2007 14:33:47 -0400
Received: (qmail 69562 invoked by uid 60001); 18 Jul 2007 18:33:45 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Message-ID;
  b=uZFS8elx/7EmAKDQqw5G9GV2ib1qst5fCIZNjVaCN6MAz6YR31zTVyER8m3as5IxjWEhF8u5DQq0QuYyJ61m6+5Sju+XLtw0EOZneUn8T+tMsYWdimVBgeH3hIQpHI9aTmuJNncymwwV5nE0DQJ6g1qr1gQUVViuOWJRwxiMut8=;
X-YMail-OSG: VN63nH0VM1mECtye65LU8qmQiJHp3aM57VbhuefheIIoDllHS_JPSbUKxF9BwN8Htbo_ApCBzYXtv896GJbeM2Yh._ArtfEl.2yEEsjPG7nxb_INwhc-
Received: from [216.52.12.233] by web52806.mail.re2.yahoo.com via HTTP; Wed, 18 Jul 2007 11:33:45 PDT
X-Mailer: YahooMailRC/651.41 YahooMailWebService/0.7.41.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52890>


[perrin@whisper TESTGIT]$ git svn --version
git-svn version 1.5.3.rc2.4.g726f9 (svn 1.2.3)

I get the "post commit" email from our SVN central server, so it appears that on the SVN side the commit worked? 

I tried running git svn with --verbose, but that did not print out any more error messages (besides the seg fault).

Thanks,

Perrin



----- Original Message ----
From: Eric Wong <eric@petta-tech.com>
To: Perrin Meyer <perrinmeyer@yahoo.com>
Cc: git@vger.kernel.org
Sent: Wednesday, July 18, 2007 12:34:50 AM
Subject: Re: git svn dcommit seg fault

Perrin Meyer <perrinmeyer@yahoo.com> wrote:
> 
> I'm able to clone svn repo's fine with
> 
> $ git svn clone https://svn.eng.msli.com/perrin/trunk/TESTGIT/ .
> 
> and I'm then able to use git commit to commit local changes, but 
> when I try 
> 
> $ git svn dcommit
> 
> I get
> 
> [perrin@whisper TESTGIT]$ git svn dcommit
>         M       test.c
> Committed r717
> Segmentation fault


> As far as I can tell, the commit worked fine (verified by trying 'svn
> update' on another box).
> 
> I've tried git version 1.5.2.3, 1.5.3-rc2, and the latest build, and
> all give the seg fault.
> 
> I'm guessing it has something to do with using the https connection to
> svn?

I primarily work with https repositories using git-svn and I haven't
seen any segfaults in a while.  Which version of the SVN libraries do
you have?  (git-svn --version will tell you).

-- 
Eric Wong
