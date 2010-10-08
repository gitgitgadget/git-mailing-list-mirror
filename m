From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/6] Fix odd markup in --diff-filter documentation
Date: Fri, 8 Oct 2010 12:39:41 -0500
Message-ID: <20101008173941.GA13738@burratino>
References: <87fwwhszsf.fsf@gmail.com>
 <1286559080-27257-3-git-send-email-stepnem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepan.nemec@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 08 19:43:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4GyE-0003SQ-K9
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 19:43:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758498Ab0JHRmz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Oct 2010 13:42:55 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58094 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757471Ab0JHRmy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Oct 2010 13:42:54 -0400
Received: by qwf7 with SMTP id 7so786059qwf.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 10:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=I1AfpAAgW349rF2CSu0O4Xy3Rl3Lr2nr5/dijiSL1bg=;
        b=Zii3on0Id2BWTrVJ3D4K2Dn6woqSakHjReEAWa2aLyr+2cPIqVb7whxPZG4YRsOSQm
         iWElQ1bkR6POciOGjHFE7jBJMRsS4BaPQD5DuHYDvoJ5JpGmGKUAPb3To2HkYUgMV+Pa
         gv2ZOuuKewoef4vsPLNdsLTGUothHY0/SiAFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=WqOMOhlXixnYNt6DxJegQAIMkzOXiI5MsDQ3NpC5/W04Rzy8yNlhAAaZrkJSp+Lq20
         6KxpTLj2buNPoINm95CpYdW4HZWNOugt6zoUFtiFYY2v2lluCtKCqrS16ECnsyRDhZEx
         CoT+2ZSbwRKKTH0J0OGntHX/99QtlPK6kQxXk=
Received: by 10.229.212.1 with SMTP id gq1mr2292288qcb.28.1286559774118;
        Fri, 08 Oct 2010 10:42:54 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id x34sm2728520qci.6.2010.10.08.10.42.51
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 10:42:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286559080-27257-3-git-send-email-stepnem@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158515>

=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec wrote:

> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -248,13 +248,13 @@ endif::git-log[]
>  	If `n` is specified, it has the same meaning as for `-M<n>`.
> =20
>  ifndef::git-format-patch[]
> ---diff-filter=3D[ACDMRTUXB*]::
> +--diff-filter=3D<spec>::

Maybe something like

--diff-filter=3D((A|C|D|M|R|T|U|X|B)...[*])

to keep the overview while following the conventions you've set out?

Strictly speaking, --diff-filter=3D (with empty argument) is allowed, t=
oo,
but I don't know if it's worth fitting that in.
