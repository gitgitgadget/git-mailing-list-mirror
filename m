From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH] diffcore-pickaxe doc: document -S and -G properly
Date: Tue, 14 May 2013 17:13:08 -0400
Message-ID: <CABURp0oJ96bYY=Wvn7ih1nPZWOea9O+tB6xTe0TViXf4rKDf2A@mail.gmail.com>
References: <1368540759-25598-1-git-send-email-artagnon@gmail.com>
 <7vwqr1jw67.fsf@alter.siamese.dyndns.org> <CALkWK0kJ7aksRbtjOesEPvsdx6wZyxxdVHUm_F-jS+Nb3WLSxg@mail.gmail.com>
 <7v8v3hjt57.fsf@alter.siamese.dyndns.org> <CALkWK0na1pDi5DnKUcWRnt0v9iQmeaLdrs7uQMDZzCKAazaNFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 14 23:13:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcMXO-0006FU-EL
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 23:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758533Ab3ENVNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 17:13:30 -0400
Received: from mail-ve0-f171.google.com ([209.85.128.171]:40034 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758451Ab3ENVN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 17:13:29 -0400
Received: by mail-ve0-f171.google.com with SMTP id m1so1253588ves.2
        for <git@vger.kernel.org>; Tue, 14 May 2013 14:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=yELpH8K6ef0bj/10z7k4in9ZGWtVW1viXyQ25H9ulrA=;
        b=j99I0Gr5dKm2OI2D+77Z7RB3G5DG3t72LPB/KDN6ct2tGAoDWjIYZMDs0Snu8uVrlM
         KNeVmgIG9G4UmGPzfZ4t29Ba+8sk6cYpbuHpadGN2QYFiP8TgImNGubJZ8pujoIqBRi+
         eDZH2umL5qesvPezmZ7IfIEHbsfkFCGPADKMk+JcwxSMdaV7YJJzxwl0XTKLwtguzNwY
         1VBKCRiJbA8LMXljHYvBGXMjnWJeueRMG87L7he32vu+rC6W1R5Y14FVAv77boyEcwjP
         MhxOUVox3DXdSuCjqIbKbSVJJ+UdQ4Jn/4hyukn2A3utvBVC2BFoSggT+Ew//WcJUA/3
         Nr1A==
X-Received: by 10.220.213.131 with SMTP id gw3mr8968896vcb.27.1368566008339;
 Tue, 14 May 2013 14:13:28 -0700 (PDT)
Received: by 10.58.135.1 with HTTP; Tue, 14 May 2013 14:13:08 -0700 (PDT)
In-Reply-To: <CALkWK0na1pDi5DnKUcWRnt0v9iQmeaLdrs7uQMDZzCKAazaNFg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224348>

On Tue, May 14, 2013 at 2:57 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Junio C Hamano wrote:
>> I do not use zsh but with bash+readline the old tradition lnext can
>> be used (see "stty -a" output and it typically is set to ^V), i.e.
>> \C-v followed by \C-i should give you a literal HT.
>
> Just looked it up: zsh has quoted-insert (^V) after which I can TAB.
> Still doesn't solve my problem though: I don't type out structs; I
> paste them the X clipboard (Emacs).  And that doesn't work either on
> bash or zsh.
>
> What can we do to improve the interface?

Don't use tabs in your code?

P
