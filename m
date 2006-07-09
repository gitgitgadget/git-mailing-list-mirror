From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: Re: [Patch] Using 'perl' in *.sh
Date: Sun, 9 Jul 2006 10:09:30 +0000
Message-ID: <f36b08ee0607090309l3cc05b19t44781bbe26013a0b@mail.gmail.com>
References: <200607081732.04273.michal.rokos@nextsoft.cz>
	 <7v3bdcq7dy.fsf@assigned-by-dhcp.cox.net>
	 <20060709094630.GB5919@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Michal Rokos" <michal.rokos@nextsoft.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 09 12:09:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzWEI-0005WK-Oj
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 12:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbWGIKJc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 06:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbWGIKJc
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 06:09:32 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:11130 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964983AbWGIKJb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jul 2006 06:09:31 -0400
Received: by py-out-1112.google.com with SMTP id 57so628785pya
        for <git@vger.kernel.org>; Sun, 09 Jul 2006 03:09:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X2SEN5B8ONWNEJWfpxoy1KLqqTxwG2mkE/N/NYY64deWDbGRBtXoM9z5SSi8ikhLjwsvT5qbpPqvUQMoFQFEDz/U5N8TbprbiM+xou9v3KUJ/Bhbekdfdea9c1jamrLk2LIoGMdlHHVduE919C1wyrZKghPU12SRjoTTFktHKiQ=
Received: by 10.35.90.20 with SMTP id s20mr3993009pyl;
        Sun, 09 Jul 2006 03:09:31 -0700 (PDT)
Received: by 10.35.14.14 with HTTP; Sun, 9 Jul 2006 03:09:30 -0700 (PDT)
To: "Alex Riesen" <raa.lkml@gmail.com>
In-Reply-To: <20060709094630.GB5919@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23540>

On 7/9/06, Alex Riesen <fork0@t-online.de> wrote:
> Junio C Hamano, Sat, Jul 08, 2006 20:27:37 +0200:
> > >
> > > some GIT's shell script are using bare 'perl' for perl invocation. It's
> > > causing me problems... I compile git with PERL_PATH set and I'd suggest to
> > > use it everywhere.
> > >
> > > So @@PERL@@ would be replaced with PERL_PATH_SQ instead.
> > >
> > > What do you think?
> >
> > Absolutely.
>
> Now imagine a non-posix system where an upgrade was made. Amongst
> other things perl was moved, i.e. from /opt/perl-5.8.8 to
> /usr/local/{bin,lib}. Suddenly git breaks.

Building new perl for sources never removed,
by itself, older perls on the system. Did it ever for you ?
How would installing new perl into new location
break git ? It would only break if you *remove*
old perl, not if you install new perl into new
location, no ?

Yakov
