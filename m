From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Reconstructing git-svn metadata after a git clone
Date: Tue, 11 May 2010 13:04:17 +0000
Message-ID: <AANLkTinZWtMUFtL-Z9gZQQ2pDrPpMooO95l_ylNuD2A9@mail.gmail.com>
References: <AANLkTikR5EpZhwFXmRfmE9jSNtiuFoGwTgGbpcwUBxnq@mail.gmail.com>
	 <t2l86ecb3c71005081120lf87fc99bh1566c82a4d21904e@mail.gmail.com>
	 <AANLkTin_hVhyrhjwoM_on_sd1RIZrk6YIFVsYXKm5UKg@mail.gmail.com>
	 <AANLkTinMZvBUPPmChwrA1dHr47HXpFldnKH9GO60oIkU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>
To: Dmitrijs Ledkovs <dmitrij.ledkov@ubuntu.com>
X-From: git-owner@vger.kernel.org Tue May 11 15:04:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBp8L-00044q-5u
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 15:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756724Ab0EKNEU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 May 2010 09:04:20 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38830 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756662Ab0EKNET convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 May 2010 09:04:19 -0400
Received: by fxm19 with SMTP id 19so391260fxm.19
        for <git@vger.kernel.org>; Tue, 11 May 2010 06:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=EQEG05avKqa6OMtaNzdXK4YXGVW4gIn3KY3ubYn0oqI=;
        b=kJZnjjTarqlZlSY98Jz1nABo1SJcqjJuRUNJJ/lt/YQGQz8OHfNNPVTshaTfxuCNgn
         4IWhDVdyqba8Lnc2uG0fxo92YmTA1onBxC+J4zKgZt85Kn+ov2+DyNxsegCGhrdfe2f5
         +zz2Fu8OpbnYBeVMgC+/sS1cLhBixsaRMSvZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=F+2ygjWsq2mL2AZ9DexxxUjfzOrckeaFGuSoPGK3EJoF50Voqt2qCEHgIVTjbWvR92
         5onVyJs7oclWWmnwfvEOPONZk/rr2qkzYODpR7HMgNAwJycFLC5HLYYdj0Y4Ga/8Be4Z
         ZEg89AL2GPEXJCNYyuaSYWTXT34Gd/ie809l8=
Received: by 10.223.29.156 with SMTP id q28mr6237947fac.77.1273583057746; Tue, 
	11 May 2010 06:04:17 -0700 (PDT)
Received: by 10.223.109.78 with HTTP; Tue, 11 May 2010 06:04:17 -0700 (PDT)
In-Reply-To: <AANLkTinMZvBUPPmChwrA1dHr47HXpFldnKH9GO60oIkU@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146893>

On Tue, May 11, 2010 at 04:27, Dmitrijs Ledkovs
<dmitrij.ledkov@ubuntu.com> wrote:
> On 10 May 2010 22:43, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@=
gmail.com> wrote:
>> Why isn't that the case? What info is in .git/svn that can't be
>> inferred from the above?
>>
>
> Is there a git versions mismatch between machine where the first
> import was made and the machine where you are testing bootstrapping b=
y
> any chance?
>
> on my machine I sometimes see "upgrading metadata" when I'm updating
> some of my acient git-svn clones.

No, they were both running 1.7.1 from Debian.
