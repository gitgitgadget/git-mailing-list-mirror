From: bill lam <cbill.lam@gmail.com>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Sat, 14 Feb 2009 11:31:39 +0800
Message-ID: <20090214033139.GA7563@b2j>
References: <20090205204436.GA6072@diku.dk> <op.uo9di902a8ed4e@dellschleppa> <2c6b72b30902121424o5d4ac0d7u67a7afb3b861aa19@mail.gmail.com> <20090213023120.GA7322@b2j> <2c6b72b30902131557w1bfe9e43l34b28a22d202e881@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 04:33:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYBHH-0003wr-1v
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 04:33:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630AbZBNDbr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Feb 2009 22:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752465AbZBNDbq
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 22:31:46 -0500
Received: from ti-out-0910.google.com ([209.85.142.190]:55802 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbZBNDbp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 22:31:45 -0500
Received: by ti-out-0910.google.com with SMTP id d10so1096964tib.23
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 19:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ohdnuy1Qtvw8Of85Cg0J++py3gbgErBw3oUkaqpa4iY=;
        b=H3EedmqJSNydILTwpsH8/AH3/qBaYMRA14B75yOj19SPi2f8NFls2xAojL6QWwDm3Z
         TwXenheTThYXyRqez4+cetzR9Rvs6hMTZsATODwTqnKF16WbQ5zOAV11WRS3dEentwv6
         AnMkCYdz4hflPaCguVDqkv4aHNwrpxtoL/kXM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=bQSm+yGNWGsd/o8ekXg7Nt4nB63NG1iYq7xk5PyeU5HVS04/rUNfXRdkyutntSAicJ
         QhRW//cHA2VptQTypiH1LAhgRZfshptJnZ8aeMsbPwtQsZR/Zg32XCjTVHdxarruHj5s
         afZbkuDsnZC3nDguFszAcBJOsk3Jpb374+SsQ=
Received: by 10.110.47.17 with SMTP id u17mr3804695tiu.4.1234582302978;
        Fri, 13 Feb 2009 19:31:42 -0800 (PST)
Received: from localhost (n219079100105.netvigator.com [219.79.100.105])
        by mx.google.com with ESMTPS id b7sm2848426tic.15.2009.02.13.19.31.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Feb 2009 19:31:42 -0800 (PST)
Mail-Followup-To: Jonas Fonseca <jonas.fonseca@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <2c6b72b30902131557w1bfe9e43l34b28a22d202e881@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109812>

On Sat, 14 Feb 2009, Jonas Fonseca wrote:
> Certainly, the one column thing was good for testing but agreeable no=
t
> very usable so I have made the behavior of horizontal scrolling
> configurable. You can either set the 'horizontal-scroll' variable to
> the number of columns or the percentage of the view width you want to
> scroll. Defaults to scrolling 50% of the view width.

Thanks.  I tested and found that there might be a bug.  For some lines
(>100 columns) it stoped scrolling even there are text there, instead
it displayed a ~ sign at the edge.  Even I set in the .tigrc

set horizontal-scroll =3D 1

It still did not works.

Also, when editing in the command mode, the back-space and left arrow
keys do not move cursor.  It can only use ctrl-h to delete the last
character.  Apparently it did not use readline and was impossible to
recall history using up-arrow key.  It should be perfect if it use
readline and can also work in vi keybinding mode.

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9209 =E6=9D=8E=E5=95=86=E9=9A=B1  =E9=8C=A6=E7=91=9F
    =E9=8C=A6=E7=91=9F=E7=84=A1=E7=AB=AF=E4=BA=94=E5=8D=81=E7=B5=83  =E4=
=B8=80=E7=B5=83=E4=B8=80=E6=9F=B1=E6=80=9D=E8=8F=AF=E5=B9=B4  =E8=8E=8A=
=E7=94=9F=E6=9B=89=E5=A4=A2=E8=BF=B7=E8=9D=B4=E8=9D=B6  =E6=9C=9B=E5=B8=
=9D=E6=98=A5=E5=BF=83=E8=A8=97=E6=9D=9C=E9=B5=91
    =E6=BB=84=E6=B5=B7=E6=9C=88=E6=98=8E=E7=8F=A0=E6=9C=89=E6=B7=9A  =E8=
=97=8D=E7=94=B0=E6=97=A5=E6=9A=96=E7=8E=89=E7=94=9F=E7=85=99  =E6=AD=A4=
=E6=83=85=E5=8F=AF=E5=BE=85=E6=88=90=E8=BF=BD=E6=86=B6  =E5=8F=AA=E6=98=
=AF=E7=95=B6=E6=99=82=E5=B7=B2=E6=83=98=E7=84=B6
