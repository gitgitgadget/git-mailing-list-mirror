From: Aghiles <aghilesk@gmail.com>
Subject: Re: Useless error message?
Date: Thu, 22 Apr 2010 16:13:53 -0400
Message-ID: <l2x3abd05a91004221313s2cb89697i3bcbfbcd6ccf6820@mail.gmail.com>
References: <z2o3abd05a91004211417v263d5a0eg497341ddf7bd79a5@mail.gmail.com> 
	<20100421221953.GA25348@progeny.tock> <20100422115625.GJ3563@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	git list <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Apr 22 22:14:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O52nW-0008QM-Mj
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 22:14:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272Ab0DVUOV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Apr 2010 16:14:21 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41974 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758114Ab0DVUOO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Apr 2010 16:14:14 -0400
Received: by wyb39 with SMTP id 39so5123777wyb.19
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 13:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=uk2J0wV3X+ce/YAKDFdE1Ew4vtXBiInz+rA3ccvyrDo=;
        b=yBfKP6QYLhTVnTu/hxkQ48sY0mIoO959B40upmiTe+gEYCc4Y3VHBdbKmv9KcQAjHK
         4t5z3GKFj3TMmMDG6py3EFoHqeoxy4NyLyV/Xt3XIY+H6zx84bOGbz9+dkow/N7q6bNT
         z+qVumY/AG6ytnzoWT3cKw68UCQfzOkgy/EFI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=kTMh1GdQaSU8V5scWR0rbvKlZaYOONZn9qXdRX+M92BcMmRVc4EcFSHLDCw+4vKSxm
         n0GnGBkLGrr0rxV9MPBOU3TrfupaeSHjUtbX5jkO5y6NqPam1Vaw+RPxChrCMHCIVUlR
         10Ci4b2hZT2YBd9ccUtFeBGdDIbqGckvJhpaI=
Received: by 10.216.187.80 with HTTP; Thu, 22 Apr 2010 13:13:53 -0700 (PDT)
In-Reply-To: <20100422115625.GJ3563@machine.or.cz>
Received: by 10.216.90.145 with SMTP id e17mr935758wef.106.1271967253181; Thu, 
	22 Apr 2010 13:14:13 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145554>

Hello,

>
> I have seen a lot of users who plainly had a lot of trouble even
> _understanding_ the error message - it is phrased in super-dense
> networking jargon. I think something like
>
> =A0 =A0 =A0 =A0"fatal: Server terminated the connection for unknown r=
eason"
>
> might come a long way (though of course specific error messages would
> still be far more helpful).
>

I would say that:

  "fatal: Server terminated the connection."

Is best and actually says what it has to stay. "Unknown reason" sounds =
like a
godly intervention into the git protocol. Sometimes, the "hung up" mess=
age is
given as an extra information that actually causes more harm than good:

 % git pull hummus
 fatal: 'hummus' does not appear to be a git repository
 fatal: The remote end hung up unexpectedly

  -- aghiles
