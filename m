From: Paul Campbell <pcampbell@kemitix.net>
Subject: Re: Questions/investigations on git-subtree and tags
Date: Tue, 12 Mar 2013 23:57:55 +0000
Message-ID: <CALeLG_=Q8zH1X=7GEeNoXBaa0NUS5uz7Tb9opSTY6+hvYN2DTg@mail.gmail.com>
References: <886271566.251606.1362763771332.JavaMail.root@openwide.fr>
	<2131964232.420820.1363082545306.JavaMail.root@openwide.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeremy Rosen <jeremy.rosen@openwide.fr>
X-From: git-owner@vger.kernel.org Wed Mar 13 00:58:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFZ5L-00061q-Hf
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 00:58:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755669Ab3CLX55 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Mar 2013 19:57:57 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:58066 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755365Ab3CLX54 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Mar 2013 19:57:56 -0400
Received: by mail-oa0-f53.google.com with SMTP id m1so488087oag.12
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 16:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=k7ovUuNNLNycOAq8UUhRMwm10pnCvJOLO9JcUI/Q1Ug=;
        b=YVX+t33YE7cok//mOcvKcjZrhMLOTYrXDlnSiGHBztTfDIdTlgeMKbQjgxavHBGim2
         G+XZmsr3ZucAzucnVO10yvRaXqaAQLV4Qk2oWLCrntkj+GWQf0lRgOwm6378USTXzTQo
         dvjbbuzNgzpNzi0w7GGeHCRRUsDV1mxpaJp3KbqUl0Cx4XL74c8UbJwrNxjySc4oV8f0
         vFMouu59wmp9Ms+4wnZXGULpiO2HCKi3UeGot+xzfIbmWUvey3uJWVtMZBzebC1ZfdFH
         jVlqUpc3twJf1e+Y3A6I2kWIloVmcvpQKss1JQ53hR122xVDe0/YvOSgzQb9x2WHfhSM
         JmWA==
X-Received: by 10.60.19.129 with SMTP id f1mr13552687oee.82.1363132675945;
 Tue, 12 Mar 2013 16:57:55 -0700 (PDT)
Received: by 10.76.169.225 with HTTP; Tue, 12 Mar 2013 16:57:55 -0700 (PDT)
X-Originating-IP: [2.102.86.4]
In-Reply-To: <2131964232.420820.1363082545306.JavaMail.root@openwide.fr>
X-Gm-Message-State: ALoCoQk0n3VKO0OKvUEKb3ShrqUiAIqD848ebaX09A3UJJVo+KQsSP6lECDXEs0I2ENy11Kz77Ix
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218012>

On Tue, Mar 12, 2013 at 10:02 AM, Jeremy Rosen <jeremy.rosen@openwide.f=
r> wrote:
> Paul, I'm not quite sure where I should go from here...
>
> should I send you a patch so you make it a V3 of your patch ? should =
I
> send a patch superseeding yours ?
>
> I have also found a similar problem in git-subtree pull, which needs
> the same fix.
>
> in the mean time, attached is the current version of my changes
>
>     Cordialement
>
>     J=E9r=E9my Rosen
>
> fight key loggers : write some perl using vim
>

Thanks J=E9r=E9my.

Nothing in your patches are dependant on anything I'm working on. I'll
gladly take them for my own tree but feel free to submit them (inline,
rather than as attachments) to the list and cc: David Greene
<greened@obbligato.org> the subtree area maintainer.

--=20
Paul [W] Campbell
