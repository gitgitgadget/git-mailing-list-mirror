From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] send-email: allow sendmail binary to be used instead of SMTP
Date: Tue, 16 May 2006 10:07:16 +1200
Message-ID: <46a038f90605151507p313386efv7998b2376cd85b2c@mail.gmail.com>
References: <1147660345772-git-send-email-normalperson@yhbt.net>
	 <7vpsifx2b7.fsf@assigned-by-dhcp.cox.net>
	 <20060515092704.GB6855@localdomain>
	 <7vmzdjtya4.fsf@assigned-by-dhcp.cox.net>
	 <20060515210110.GR32076@h4x0r5.com>
	 <7vhd3rgfey.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Ryan Anderson" <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 16 00:07:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FflDs-0005LG-Jx
	for gcvg-git@gmane.org; Tue, 16 May 2006 00:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbWEOWHZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 18:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965273AbWEOWHT
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 18:07:19 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:35645 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965268AbWEOWHR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 18:07:17 -0400
Received: by wr-out-0506.google.com with SMTP id i22so1311078wra
        for <git@vger.kernel.org>; Mon, 15 May 2006 15:07:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CBFAZ3V1mjLOICzjNjj8TBifD7spnjClLdRwzW2U/EIhg1Jt63vpRG3D6MB1RBsKoZUeyAMQn31yFaohWGDh2wp+ye8FGQRzb1ek+oIhsVSsx8Svf8tVQ2ZhRLyYjh0IOgCmoExkMcvqYt2GB3bLFK+2lAVM3NKIXhfVA1WxlCM=
Received: by 10.54.69.7 with SMTP id r7mr6631597wra;
        Mon, 15 May 2006 15:07:16 -0700 (PDT)
Received: by 10.54.127.17 with HTTP; Mon, 15 May 2006 15:07:16 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vhd3rgfey.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20089>

On 5/16/06, Junio C Hamano <junkio@cox.net> wrote:
> Ryan Anderson <ryan@michonline.com> writes:
>
> > I think, in practice, that /usr/lib/sendmail will exist anywhere you hve
> > something running on port 25, at least on unixy machines.
...
> exim, postfix and friends?

/usr/sbin/sendmail is there for any current MTA, so if qmail, exim,
postfix, sendmail and all MTAs I can think of install a working
sendmail binary.

Newish desktop-targetted distros (and MacOSX) are leaning towards not
running an MTA on port 25 any more unless you ask them for it. They'll
do crontab-driven queue flushes, so the messages you feed to
/usr/sbin/sendmail will be sent a few minutes later.

That is why IMHO /usr/sbin/sendmail is a better default than
localhost:25, but I can live with either ;-)

> I used to know somebody who port-forwarded 25/tcp to central
> smtp server from smaller machines in her intranet installation,

I can understand that, but I think the changes in unixy distros
mentioned above make it unnecessary today.

cheers,


martin
