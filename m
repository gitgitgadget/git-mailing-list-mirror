From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Sat, 4 Aug 2007 13:39:23 +0300
Message-ID: <20070804133923.eb84a308.tihirvon@gmail.com>
References: <7vzm18jg7p.fsf@assigned-by-dhcp.cox.net>
	<200708040341.36147.ismail@pardus.org.tr>
	<7vsl70jdcr.fsf@assigned-by-dhcp.cox.net>
	<46B3F762.1050306@midwinter.com>
	<7vfy2zj4nj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Steven Grimm <koreth@midwinter.com>,
	Ismail =?ISO-8859-1?B?RPZubWV6?= <ismail@pardus.org.tr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 12:39:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHH2k-0006XY-DX
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 12:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756686AbXHDKjc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 06:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755873AbXHDKjb
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 06:39:31 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:53639 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396AbXHDKja (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 06:39:30 -0400
Received: by fk-out-0910.google.com with SMTP id z23so919074fkz
        for <git@vger.kernel.org>; Sat, 04 Aug 2007 03:39:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=nYjbwSAl6uwYeyHg00lFpYrGGmry1/sc50zPAf4/ioYJilIPUl8doM1MPWHwbFpiu7ceeAWnZCY/nEQ/7wZypVCDNqylIr3rPWSAOyB+R1fUtFr1b/zGjZIKwfk0sb6aZe8tnI2lGAcmWtwxCGAU2imvKYDuWwb9aEBZC3KFUuY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=c814FMwicO+bwpPL6qBbV90EpdrKKa/PfJ+WdnnGCC1zUUrKdWuC68+Mtmt4Mc0crnK8Ox+zwl4cTDRDC+SQPthHph1Us5ISJJ4KlYE+tZyqcVu0BprmR0NOSjMT3Jk60UDIqlpPi65tC2xpwtHkjg4gUI/G6RqNPrsM08MWVLs=
Received: by 10.86.4.2 with SMTP id 2mr2893979fgd.1186223968746;
        Sat, 04 Aug 2007 03:39:28 -0700 (PDT)
Received: from garlic.home.net ( [85.23.17.126])
        by mx.google.com with ESMTPS id k29sm8234156fkk.2007.08.04.03.39.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 04 Aug 2007 03:39:28 -0700 (PDT)
In-Reply-To: <7vfy2zj4nj.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed 2.4.4 (GTK+ 2.10.13; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54820>

Junio C Hamano <gitster@pobox.com> wrote:

> It might be more worthwhile to research what other "Text-ish
> lightweight mark-up" systems are availble, and if there is one
> that is more efficient and can go to at least html and man,
> one-time convert our documentation source to that format using
> your Perl magic.  The minimum requirements are:
> 
>  * The source is readable without too much mark-up distraction;
> 
>  * Can go to roff -man;
> 
>  * Can go to html.

I used asciidoc too but it was really PITA to install and use so I wrote
a small tool (ttman) in C which converts .txt files directly to man
pages. It doesn't have html support but you could use man2html for that.
Unfortunately it does not format as pretty html as asciidoc.

http://onion.dynserv.net/git/?p=cmus.git;a=tree;f=Doc;h=8ab4e92a6356d9cca0d738130fe54026da8c690b;hb=54b6ddacd9d1387c256ce5e7d7d8bb3324799c04

It might be quite easy to extend ttman to output html too...

-- 
http://onion.dynserv.net/~timo/
