From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Sat, 4 Aug 2007 15:51:29 +0300
Message-ID: <20070804155129.a20cdb9b.tihirvon@gmail.com>
References: <7vzm18jg7p.fsf@assigned-by-dhcp.cox.net>
	<200708040341.36147.ismail@pardus.org.tr>
	<7vsl70jdcr.fsf@assigned-by-dhcp.cox.net>
	<46B3F762.1050306@midwinter.com>
	<7vfy2zj4nj.fsf@assigned-by-dhcp.cox.net>
	<20070804133923.eb84a308.tihirvon@gmail.com>
	<Pine.LNX.4.64.0708041240500.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Steven Grimm <koreth@midwinter.com>,
	Ismail =?ISO-8859-1?B?RPZubWV6?= <ismail@pardus.org.tr>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 04 14:51:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHJ6o-0003cq-Ku
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 14:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764211AbXHDMvx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 08:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756104AbXHDMvw
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 08:51:52 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:14591 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762621AbXHDMvg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 08:51:36 -0400
Received: by fk-out-0910.google.com with SMTP id z23so941075fkz
        for <git@vger.kernel.org>; Sat, 04 Aug 2007 05:51:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=F/OImhzzrddHkAWz0AHiEMVETd4/A7qciJJISzb/DPCmxVDf41tIEcp3Ht3ac8I3ltXs+eYnz9Ey/GIgR0Qb+/KsFTkJv9dNaRFf/nzcCz5099098CHLCLJItfEpOcRgmVDw7RFxNZKkdlC6cbu5ebxUOFLjhXfsBV70XORh6oE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=XCDVUfhla9Tn5T7EHe5XeCPDHjAamgHbY3SWN3p7ItK4d3cunJFVfPmuwtlsLCLQFbVmxcSnoRZwqTGexzNGa48c3CKpzoyfHJ6XR4uUm4AIPcWFYLKsqN8YvSFpX4mRJZmJM6SEzeAHjlyHsRILLt8WXNEDS01EIuzzBnEW2bw=
Received: by 10.86.79.19 with SMTP id c19mr2967408fgb.1186231895080;
        Sat, 04 Aug 2007 05:51:35 -0700 (PDT)
Received: from garlic.home.net ( [85.23.17.126])
        by mx.google.com with ESMTPS id v23sm8446942fkd.2007.08.04.05.51.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 04 Aug 2007 05:51:33 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0708041240500.14781@racer.site>
X-Mailer: Sylpheed 2.4.4 (GTK+ 2.10.13; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54841>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> Hi,
> 
> On Sat, 4 Aug 2007, Timo Hirvonen wrote:
> 
> > I used asciidoc too but it was really PITA to install and use
> 
> I disagree.  Whenever I had the need, installing asciidoc was pretty 
> swift.  No problems at all.

Well asciidoc doesn't even have a Makefile. You have to copy the files
manually (maybe it's easier now, I don't know). Also getting it work
correctly with xsl-stylesheets etc. was really frustrating experience.
Now there's asciidoc, xmlto etc. in Arch Linux community repo but I
wouldn't be surprised if it couldn't build the GIT documentation.

> > so I wrote a small tool (ttman) in C which converts .txt files directly 
> > to man pages.
> 
> I was impressed!  Right until I saw that
> 
> 	- it rolls its own parser/lexer without using bison/flex, which 
> 	  makes it much longer than necessary,

I've never liked parser generators.

> 	- it looks like a perl script doing the same job would have been 
> 	  even smaller yet, and

Very likely but perl is incompatible with my brain :)

> 	- the syntax is nowhere near asciidoc syntax.

I needed something really simple.  asciidoc's syntax is full of
surprises and it's much harder to parse.

Of course having a perl script which could convert asciidoc files
directly to man and html would be really nice.  We just need some brave
perl hacker to write the script.

> For official releases, I'd still want to rely on asciidoc.

Agreed, rushing to change the documentation format wouldn't be wise.

-- 
http://onion.dynserv.net/~timo/
