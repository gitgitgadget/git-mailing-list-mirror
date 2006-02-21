From: "Ron Parker" <rdparker@gmail.com>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Tue, 21 Feb 2006 16:13:12 -0600
Message-ID: <1cf1c57a0602211413n22e77fd0l4e2846e7feb5429e@mail.gmail.com>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20060220191011.GA18085@hand.yhbt.net>
	 <7vr75xbs8w.fsf_-_@assigned-by-dhcp.cox.net>
	 <81b0412b0602210930w5c1a71aage12bad2079dd515a@mail.gmail.com>
	 <20060221205618.GA23920@localdomain>
	 <20060221220454.GB5948@steel.home>
	 <1cf1c57a0602211412r1988b14ao435edd29207dc0d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Feb 21 23:13:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBfl1-00043b-Ed
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 23:13:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbWBUWNQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 17:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWBUWNQ
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 17:13:16 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:20170 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932478AbWBUWNP convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2006 17:13:15 -0500
Received: by xproxy.gmail.com with SMTP id h27so949829wxd
        for <git@vger.kernel.org>; Tue, 21 Feb 2006 14:13:13 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dKgjZVulGzOB0ANCWoa6KTX62xW+opr9xPvUS6cKbekE3OxxfUY7OEBcP7V08KRj3YeSEnLTCVx1Ob6xuLWcjovvHVyvpjXgsw8qnGTB6t92EL5Kpe4mvkqAhEIoKxch2sw7zZAc/KLHcSEmPlCpXx4KgzMmWOHr22mF/8nPR7g=
Received: by 10.70.130.7 with SMTP id c7mr5213435wxd;
        Tue, 21 Feb 2006 14:13:12 -0800 (PST)
Received: by 10.70.88.3 with HTTP; Tue, 21 Feb 2006 14:13:12 -0800 (PST)
To: git@vger.kernel.org
In-Reply-To: <1cf1c57a0602211412r1988b14ao435edd29207dc0d0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16559>

On 2/21/06, Alex Riesen <raa.lkml@gmail.com> wrote:

> AFAICS, it does not exist. There is emulation of it in that active-perl,
> though so this works:
>
>     if ( !fork ) { something }
>
> but not "too well" (you have to be carefule not spawn too many (which
> is around 50) processes. Perl'll crash otherwise).

IIRC this has to do with some child-process thread limits in Windows.

--
Windows, the multi-thrashing OS.
