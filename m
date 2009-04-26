From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Google Code: Support for Mercurial and Analysis of Git and Mercurial
Date: Sun, 26 Apr 2009 12:09:07 +0200
Message-ID: <200904261209.08108.jnareb@gmail.com>
References: <200904260703.31243.chriscool@tuxfamily.org> <m363grq13i.fsf@localhost.localdomain> <op.uszlmeoo1e62zd@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Christian Couder" <chriscool@tuxfamily.org>, git@vger.kernel.org
To: "Matthias Andree" <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Sun Apr 26 14:13:57 2009
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ly1K1-0002vb-A0
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 12:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbZDZKJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 06:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbZDZKJU
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 06:09:20 -0400
Received: from mail-bw0-f163.google.com ([209.85.218.163]:33686 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbZDZKJT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 06:09:19 -0400
Received: by bwz7 with SMTP id 7so1780210bwz.37
        for <git@vger.kernel.org>; Sun, 26 Apr 2009 03:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=NguSIASafDyvN7Z28i5zQs280xKx6pdlQD6y0FsXzOI=;
        b=E3JaTQwI9GkuYQ1VThvrC2+JXnIq9ooqzAIiK2QvTNmMA2ni+N9s2fmxciUeRIZSi9
         hrbt6qPBj+QXNQAiCMPj0/gvM4nDIBi+sslxLNwwJsehErHCMCeYBdLavj3tKarH0zlV
         PLmd2IClNIp21/dShpOpb/8xcnkW0XxWCv6Pg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=bgbADRg7/tAzlOqIIQ+lTS1dOZ/VsMiXrMNXaz42tjlRNY05QcF7M0haNi0Wt1kkcH
         SCelPxuuDCtg1L9RjzVMQ8SNA6zGSD119qUyOulHRST31BjRBsSPyLu441V+Bbd/Bqvz
         I9/AHglB5alHZwyw6F+wRwQEiLEaQrsPM1tz8=
Received: by 10.103.102.17 with SMTP id e17mr2457849mum.119.1240740557213;
        Sun, 26 Apr 2009 03:09:17 -0700 (PDT)
Received: from ?192.168.1.13? (abwp56.neoplus.adsl.tpnet.pl [83.8.239.56])
        by mx.google.com with ESMTPS id g1sm8731741muf.56.2009.04.26.03.09.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Apr 2009 03:09:16 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <op.uszlmeoo1e62zd@merlin.emma.line.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117589>

On Sun, 26 April 2009, Matthias Andree wrote:
> Am 26.04.2009, 10:16 Uhr, schrieb Jakub Narebski <jnareb@gmail.com>:
> 
> > I can't comment on MS Windows support, but AFAIK Mercurial has better
> > support here than Git.
> 
> I have some experience here, and with exception to the SVN 1.6 breaks  
> git-svn for https:// (probably due to misbehaviour of APR or SVN stuff on  
> Cygwin), it works flawless on Cygwin 1.5. (SVN 1.5 on Cygwin 1.5 or SVN  
> 1.6 on Cygwin 1.7 seem to work).
> 
> I wonder why people are always pissed at Cygwin - it's quite easy to setup  
> and works.

Well, but you have to install Cygwin (or use MsysGit, which isn't there
yet).  On the other hand you need to install Python for Mercurial...
but perhaps it is bundled in Windows install package for Mercurial.

Beside it isn't only about being easy to install and use (and have
decent enough performance) given SCM on MS Windows, but also about
tools such like TortoiseHg and VisualHg (as Windows users are usually
not used to using CLI alone).  Although also this improves for Git,
with TortoiseGit, Git Extensions and git-cheetah.  And I think it was
much worse (for Git vs Mercurial) at the time the analysis in question
was conducted.

[...]
> > The deciding feature (well, one of deciding features) was the fact
> > that Mercurial has better HTTP support... I guess (it was not obvious
> > from the analysis, but it was hinted at) that Mercurial uses its
> > custom protocol over HTTP, as opposed to "dumb" HTTP protocol support
> > in Git.
> >
> > Perhaps it is time to restart work on _"smart" HTTP protocol_?
> 
> That would certainly be useful, but the "packs" approach is something that  
> may make this more difficult than for Mercurial. Git+SSH works rather well  
> though.

As you can find in mailing list archives the design part of "tunelling"
pack protocol over HTTP, using git-aware server (for example some CGI
script, or simple HTTP server like Mercurial's hg-serve), is done.  Even
taking into account the fact that HTTP protocol by itself is stateless.
Unfortunately development itself of "smart" HTTP server for Git got
stalled... if it was present, the conclusion of mentioned analysis might
have been different.  OTOH perhaps it would be not, as it is my impression
that Google Code stuff is either Python or Java...


P.S. I wonder what happened to GMane interface... seems stalled.

-- 
Jakub Narebski
Poland
