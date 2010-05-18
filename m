From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] WIP: begin to translate git with gettext
Date: Tue, 18 May 2010 16:47:09 +0000
Message-ID: <AANLkTilRMHuYFTaMv3p3XN2v2MVN-txOKKo7csvo9-iA@mail.gmail.com>
References: <20100517160208.GA20842@unpythonic.net>
	 <AANLkTikK9LAd_pwTwB56Vpq19i00X5apy6qT-ZOpnLEp@mail.gmail.com>
	 <20100518160708.GB20842@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff Epler <jepler@unpythonic.net>
X-From: git-owner@vger.kernel.org Tue May 18 18:47:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEPws-0000b7-4f
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 18:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755740Ab0ERQrM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 May 2010 12:47:12 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:65035 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755221Ab0ERQrL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 May 2010 12:47:11 -0400
Received: by gwaa20 with SMTP id a20so1244944gwa.19
        for <git@vger.kernel.org>; Tue, 18 May 2010 09:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Malebtm64EYMe1643wQoj/D9Vx2XNgbY++exO2Ko2LE=;
        b=h+2gk1gxMg2mhX94cPO575cFi8t6/h5i1WkOJLiLBERRecD9nPshyodA2ctV56+jlq
         EmzDodGfKcsYWNJEDNxxA7nMjDKwzaKBYwRp4ZH7X8eMCiqana8YBGzvZ1St5QO0XkDn
         QDzPUsHFffcm/mrwAzPF7+gF+hMYMs8RUXVAU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CcW4he45l+oA8habqrkh4cKYSrtly9MrmqItoJwc19CtlVKe+pDDHLsoKtOnNuaBcu
         cHDKud0Y6KbIxZBEqtu2fakNElBMeEvVBk2Jx2SwtQx8duQgoDnAivyoYbeVvf9uFQbV
         Q07EDKpE4QNECLjXkEZi4J5e7vWeEAYJs5jG4=
Received: by 10.231.178.132 with SMTP id bm4mr1924664ibb.62.1274201230041; 
	Tue, 18 May 2010 09:47:10 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Tue, 18 May 2010 09:47:09 -0700 (PDT)
In-Reply-To: <20100518160708.GB20842@unpythonic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147289>

On Tue, May 18, 2010 at 16:07, Jeff Epler <jepler@unpythonic.net> wrote=
:
> Is it possible that you don't have is_IS language support? =C2=A0On U=
buntu
> this comes from a package like language-pack-is-base.
>
> I tried your po entries in a file named po/is.po, and it didn't work.
> When I installed language-pack-is-base, it did.
>
> $ unset LANGUAGE LC_MESSAGES; export LANG=3Dis_IS.UTF-8
> $ /usr/local/jepler/git/bin/git status | head -1
> # A greininni master

Yes, my system's settings were broken. Thanks, it works now.
