From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Translations [of Documentation] in Git release?
Date: Tue, 27 Jan 2009 12:16:58 +0100
Message-ID: <200901271216.59687.jnareb@gmail.com>
References: <60646ee10901250941s34f7accem1b74fc201e895a41@mail.gmail.com> <bd6139dc0901261130ic64f767gddc960ebe3dfecf2@mail.gmail.com> <Pine.LNX.4.64.0901270800100.26770@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Mike Hommey <mh@glandium.org>, Dill <sarpulhu@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Jan 27 12:18:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRlxs-0006Zj-RM
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 12:18:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753042AbZA0LRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 06:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752985AbZA0LRJ
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 06:17:09 -0500
Received: from ik-out-1112.google.com ([66.249.90.180]:24132 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbZA0LRG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 06:17:06 -0500
Received: by ik-out-1112.google.com with SMTP id c28so975187ika.5
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 03:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=kQshEJ+rjYjV8Ake+RYzIKWoNEx4Sa5iCl3TLn/ETGY=;
        b=sLC402CF3LnJn4BYd4SI9dZ/HZAEAYSR9lGRuWMVaREeuUjU8ML8I1TkLFiUNT/l7X
         eyfNo1dH1iszoPfykaKWN15JZDs601PXMAHD7SHnwxN18MK7dZCHUMgifnEr/b+YFLG+
         +I4UtPeG0IqDkvrLVzgEQcPkXUfh6ycbl+Mjg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=SiLV3Ca8Hc+nfmbXsCRXm0YC1PvdtppolA+KZS0K/v7AJisfJ3Zo9tSmSWTxmmqLu/
         apKxS1UX3GFGUvDdKzouKL7ulIppjPluTozm6gC3f/sEkzIPHRGWVdjlneTav3qfZ9pk
         7+eUNKtaSYpVhM1mv8lMHKmPh8kfs/lP0DlTY=
Received: by 10.86.36.17 with SMTP id j17mr806172fgj.0.1233055024918;
        Tue, 27 Jan 2009 03:17:04 -0800 (PST)
Received: from ?192.168.1.15? (abvx18.neoplus.adsl.tpnet.pl [83.8.221.18])
        by mx.google.com with ESMTPS id 4sm11821031fge.55.2009.01.27.03.17.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jan 2009 03:17:04 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0901270800100.26770@ds9.cixit.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107333>

On Tue, 27 Jan 2009, Peter Krefting wrote:
> Sverre Rabbelier:
> 
> > Perhaps the basics can be translated at least, the documents that do
> > not require much change because they represent stable concepts?
> 
> I usually start out translating the program output, then manual pages,
> and then, time permitting, documentation.

The problem with translating program output (program messages) in Git
is twofold: fundamental and technical.  Fundamental, that program
output is considered API (at least for plumbing commands) and used
when scripting (this might be ameliorated with "I am script" switch
or environmental variable).  Technical, because Git is mixture of
programs in C, shell scripts, and Perl scripts, and you have to come
with technical means of translating messages in all three of them.

> Git is a bit special in that regard since "--help" gets hardwired to
> display the manual page, so one can't just translate the help screen.

Not in all cases. Sometimes it shows "long usage". Perhaps that should
be made more consistent?

-- 
Jakub Narebski
Poland
