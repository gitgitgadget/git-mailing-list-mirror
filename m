From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished summary continued
Date: Mon, 22 Oct 2007 23:33:21 +1000
Message-ID: <ee77f5c20710220633j37673651p5862b82d5a7b82e8@mail.gmail.com>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com>
	 <4719B655.90204@op5.se> <DE4FB702-24E8-421F-8447-04A5C7F7B5D2@zib.de>
	 <8fe92b430710201606i47e85b24k17abd819bf0d353b@mail.gmail.com>
	 <Pine.LNX.4.64.0710210031130.25221@racer.site>
	 <471AFD07.4040606@op5.se>
	 <Pine.LNX.4.64.0710212308540.25221@racer.site>
	 <471C586A.9030900@op5.se>
	 <Pine.LNX.4.64.0710221156540.25221@racer.site>
	 <ED965042-27DE-450B-96CB-00D27000FAF6@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Andreas Ericsson" <ae@op5.se>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Steffen Prohaska" <prohaska@zib.de>,
	"Federico Mena Quintero" <federico@novell.com>, git@vger.kernel.org
To: "Wincent Colaiuta" <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Oct 22 15:33:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjxPT-0008Sg-Bk
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 15:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349AbXJVNdY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Oct 2007 09:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752644AbXJVNdY
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 09:33:24 -0400
Received: from rv-out-0910.google.com ([209.85.198.186]:51393 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226AbXJVNdX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Oct 2007 09:33:23 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1160946rvb
        for <git@vger.kernel.org>; Mon, 22 Oct 2007 06:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Ca5ffdamRJVxFNdvU5iTq5U5UHzE5kbErbaZysXWJW8=;
        b=kFMzQjXYVS3BiQj4Bc4cvYEqM3hT0+2GddQ0/wuOSQPK7HAPEH+U8Fw8PutJ/Tl4oTi/iv6XQ9lp29jGxrB+M2Ns4g1Qz5kJA50Guokmhhl1vJdHas1oJKHZqDFmRsTWD6YwFleBAYtGkbPU3BAaXrNIzgcQUIrxYmvPh7+NkYM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A4daPxporSSTpHxQAfHv5LVjAq7M/6dO6reLkLkG1r8aXUHUKaHSIeC7siL2SGGYkxbhq8xKLiR3ezOxvGGHbO31jStLfrUsrOidMeGfjnJGFO+pSLqJVACFeWVKxHR1frG7E+IwmnptOkoI8RJZ7B6KSZJf7TOCOqXRBx3EGwI=
Received: by 10.141.167.5 with SMTP id u5mr2297267rvo.1193060001593;
        Mon, 22 Oct 2007 06:33:21 -0700 (PDT)
Received: by 10.141.153.4 with HTTP; Mon, 22 Oct 2007 06:33:21 -0700 (PDT)
In-Reply-To: <ED965042-27DE-450B-96CB-00D27000FAF6@wincent.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62001>

On 22/10/2007, Wincent Colaiuta <win@wincent.com> wrote:
> El 22/10/2007, a las 13:04, Johannes Schindelin escribi=F3:
>
> > So once again, what operations involving git do people use regularl=
y?
>
> Here are my top ten commands, sorted by the number of times they
> appear in my ~/.bash_history:

Sounds like a good idea. Here's mine (my .bash_history is limited to
500 commands, though):

$ cat ~/.bash_history | grep ^git | cut -c5- | cut -d' ' -f1 | sort |
uniq -c | sort -nr | head -10
  64 status
  37 diff
  23 push
  13 checkout
  12 add
   9 log
   9 commit
   8 rebase
   8 branch
   5 count-objects


Dave.
