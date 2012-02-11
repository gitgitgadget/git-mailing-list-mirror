From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Undo last commit?
Date: Sat, 11 Feb 2012 23:07:09 +0100
Message-ID: <201202112307.10528.jnareb@gmail.com>
References: <BANLkTinWujKYvx_fh2iBDOdMbywqzfgwUA@mail.gmail.com> <4F36B147.3070501@gmail.com> <CAHK-92oMc62O0S8Bxt6+uxobE+kg5wOeRDoOsHWvvenXaXmZGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>,
	Holger Hellmuth <hellmuth@ira.uka.de>,
	Massimo Manca <massimo.manca@micronengineering.it>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	=?utf-8?q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Mike <xandrani@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 23:07:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwL6i-00080u-My
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 23:07:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754263Ab2BKWHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 17:07:14 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52370 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753627Ab2BKWHM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 17:07:12 -0500
Received: by eaah12 with SMTP id h12so1326792eaa.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 14:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:date:content-type:content-transfer-encoding
         :message-id;
        bh=8UBWkdoZ5xAPEM6sBj+3A/mA7oz3BioSMmBr+k5gC8g=;
        b=ukwmlmrYiXx/nKzxDBHtvsd3j84XST6mhZg5oq4QG7pULGxdncmgGISBS3e0uWpa4X
         xzvEk7l7nhZKWFWD3RhIiwDYm+V0K+A7yzQG5tAXcWaLokNVE9dI/nmrXyvi+nim5Lh3
         2E3Et8NYaBYj5JV59AiNl0PNPvn/8YmrF764k=
Received: by 10.14.28.140 with SMTP id g12mr3465866eea.85.1328998031263;
        Sat, 11 Feb 2012 14:07:11 -0800 (PST)
Received: from [192.168.1.13] (abwi47.neoplus.adsl.tpnet.pl. [83.8.232.47])
        by mx.google.com with ESMTPS id e12sm40535601eea.5.2012.02.11.14.07.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 11 Feb 2012 14:07:10 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <CAHK-92oMc62O0S8Bxt6+uxobE+kg5wOeRDoOsHWvvenXaXmZGQ@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190535>

Please do not top-post, and do not remove git mailing list from Cc.
Sorry for double posting; forgot to re-add git@vger.kernel.org

On Sat, 11 Feb 2012, Mike ??? wrote:
> 2012/2/11 Neal Kreitzinger <nkreitzinger@gmail.com>
> > On 6/28/2011 8:57 AM, Holger Hellmuth wrote:
> > >
> > > It would be a nice companion to the not-yet-realized "git unadd" ;-)
> >
> > or perhaps "git unstage"...
>
> If lot's of people have the same problem then it IS a design flaw. If
> something is designed well and genuinely intuitive then they just work.
> Think iPhone, iPod, some DVD players and other well designed user
> interfaces. The same goes for command line tools... the options should have
> names that don't have any ambiguity.
> 
Many of problems with git user interface have their source from the fact
that git, including its interface, was evolved rather than created using
big-design-upfront workflow.  And it _had_ to be evolved, as there was not
much of prior art (well, not good prior art) in the area of DVCS.

Besides, as they say:

  The only "intuitive" interface is the nipple. After that it's all learned.

                                                             -- Bruce Ediger

> Techie guys almost always blame the users, this is a very bad attitude. For
> example I've met so many techies that THINK they can design websites...
> err... they can't. They CAN program sure, but they CAN'T design the user
> experience properly as that is not their expertise. Just as we wouldn't
> expect a graphic designer or user interface specialist to do the coding.
> 
There is also problem in that you need to know git well to _code_ interface;
and when you know git well you don't notice no longer the problems that you
had as a newbie.

On the other hand new git users sometimes have problems distinguishing
between accidental complexity of bad UI design, and essential complexity
of a powerfull and flexible tool.

[...]

So, Mike, will you bitch or will you try to help?

-- 
Jakub Narebski
Poland
