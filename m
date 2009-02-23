From: bill lam <cbill.lam@gmail.com>
Subject: Re: how to reset to remote repo
Date: Tue, 24 Feb 2009 07:19:28 +0800
Message-ID: <20090223231928.GA7406@b2j>
References: <20090223105546.GA7425@b2j> <slrngq56ql.q4m.sitaramc@sitaramc.homelinux.net> <20090223145722.GB7422@b2j> <slrngq5her.6l3.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 00:21:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbk7B-00069P-8z
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 00:21:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754908AbZBWXUF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Feb 2009 18:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754526AbZBWXUE
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 18:20:04 -0500
Received: from rv-out-0506.google.com ([209.85.198.228]:49943 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbZBWXUD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 18:20:03 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2154104rvb.1
        for <git@vger.kernel.org>; Mon, 23 Feb 2009 15:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QWAEIyHHAV8suSTFJ7qmgCrLUUdr9MkWsufHCsp2S9A=;
        b=NT4JiuUsoRJLw+IcERCtfo1pqEk6rnroHLUVfw5YGcJFvgxXpxhRL514g1O5yfNmQF
         h0nsu/wKJGg8yWR9kvpcJLcvs6dBmqihFAEAMEnu+g2TSD5qIlkyJvTCIEyEaeovpTGP
         pfri1bqUz2G5RIG5F89mtst2Mgod0iTM6lOv8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=fx6CbCzziWAVyfaoKFN6l++IShIl8JqLFg5CAtaZrRBD+XdXWPGpvhJSb2To3IEfCm
         IqEdnxKxfFYZVGZXXbzYFoUaqRRSX2A48JRbSGNlS6CptQu16/xSrU6JCW3l/pz2XFlp
         JGex+XioReEBlP2y/i02o7qnq95nRqCPTvSMM=
Received: by 10.110.84.7 with SMTP id h7mr6693771tib.37.1235431200709;
        Mon, 23 Feb 2009 15:20:00 -0800 (PST)
Received: from localhost (n219078081066.netvigator.com [219.78.81.66])
        by mx.google.com with ESMTPS id d4sm106972tib.28.2009.02.23.15.19.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Feb 2009 15:20:00 -0800 (PST)
Mail-Followup-To: Sitaram Chamarty <sitaramc@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <slrngq5her.6l3.sitaramc@sitaramc.homelinux.net>
User-Agent: Mutt/1.5.19 (2009-01-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111181>

On Mon, 23 Feb 2009, Sitaram Chamarty wrote:
> I'm not sure why a rebase of any kind would remove a remote
> brancg but you can always do 'git fetch' first if you
> accidentally messed up origin/master.

Thanks. Incidentally I just found that I could git reset just before
my first patch and then git pull again.

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9226 =E7=8E=8B=E7=B6=AD  =E9=80=81=E5=88=A5
    =E5=B1=B1=E4=B8=AD=E7=9B=B8=E9=80=81=E7=BD=B7  =E6=97=A5=E6=9A=AE=E6=
=8E=A9=E6=9F=B4=E6=89=89  =E6=98=A5=E8=8D=89=E6=98=8E=E5=B9=B4=E7=B6=A0=
  =E7=8E=8B=E5=AD=AB=E6=AD=B8=E4=B8=8D=E6=AD=B8
