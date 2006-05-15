From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] send-email: allow sendmail binary to be used instead of SMTP
Date: Mon, 15 May 2006 22:37:18 +1200
Message-ID: <46a038f90605150337l3357ce3by22834823eee7b87c@mail.gmail.com>
References: <1147660345772-git-send-email-normalperson@yhbt.net>
	 <7vpsifx2b7.fsf@assigned-by-dhcp.cox.net>
	 <20060515092704.GB6855@localdomain>
	 <7vmzdjtya4.fsf@assigned-by-dhcp.cox.net>
	 <20060515101142.GD6855@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 12:37:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfaS7-00023W-3f
	for gcvg-git@gmane.org; Mon, 15 May 2006 12:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbWEOKhW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 06:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbWEOKhW
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 06:37:22 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:16338 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964872AbWEOKhV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 06:37:21 -0400
Received: by wr-out-0506.google.com with SMTP id i28so794288wra
        for <git@vger.kernel.org>; Mon, 15 May 2006 03:37:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PNiaiEjS6BOoplYtaAeY5TGSOpUSrehdfJqw277v2Km8iiG/FYVOyf1TOxs5/1Ce9wDIRdRfhuuNJmKBwo+ziEUAOBW4zOxY0KfbUEBDnPV3GM2powh93zIvFWWNJEknWhsbYrXQLV/pmwKyhfoAFBGyGSQOHDH/M/mCLtKad1U=
Received: by 10.54.117.5 with SMTP id p5mr5484622wrc;
        Mon, 15 May 2006 03:37:18 -0700 (PDT)
Received: by 10.54.127.17 with HTTP; Mon, 15 May 2006 03:37:18 -0700 (PDT)
To: "Eric Wong" <normalperson@yhbt.net>
In-Reply-To: <20060515101142.GD6855@localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20046>

On 5/15/06, Eric Wong <normalperson@yhbt.net> wrote:
> Junio C Hamano <junkio@cox.net> wrote:
> > I am not opposed to have an option to run a local submission
> > agent binary (I said I like that if(){}else{} there, didn't I?).
> > The ability to do so is a good thing.  I am not however sure
> > about changing the default when no option is specified on the
> > command line.
>
> By "I believe this is what Martin wanted", I meant changing the default to
> sendmail: <46a038f90604271804j195d62f3x93ae816e809f4ffd@mail.gmail.com>
>
>         > Oh, it should just work with sendmail if it's there and we don't

Thanks Eric! git-send-email used to default to using local binaries.
It was only with the switch to Net::SMTP that the default changed to
localhost:25.
IMHO the developer's machine is more likely to have a working
/usr/sbin/sendmail than an SMTP server (specially looking at current
linux desktop configurations).

OTOH, as long as I can override it to use sendmail, it's all good.


martin
