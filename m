From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Query] Can we ignore case for commiters name in shortlog?
Date: Fri, 30 Nov 2012 09:02:15 +0530
Message-ID: <CAKohpom6PBbC+vp9X4o3ioo1PS9kRbHKiWuMxuR1WeGOeA7L5Q@mail.gmail.com>
References: <CAOh2x==NBeeoE2=PhaDC143ZF_xHKD5m=Po+-DS2X43CEeGiEQ@mail.gmail.com>
	<CAJDDKr7yr2JSutcEy1mz-SfMq8ZdNzR3+s++ooenn5+wD-LDAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 04:32:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeHL5-0006FB-FH
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 04:32:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156Ab2K3DcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 22:32:16 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:55656 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab2K3DcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 22:32:16 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so27259iay.19
        for <git@vger.kernel.org>; Thu, 29 Nov 2012 19:32:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-gm-message-state;
        bh=HeOyNmRlNeI0NglbV1m9jtMj28z9mmwm3mpFpj1x3Oc=;
        b=hToYJhTOm2IzkaD2tuXlp2VWr1BwiE+DvrhOev5WNC9Ms1ufnW7dNPPureCB5v6k5n
         VVeUhtAoNSvZpRykYY0Nqx42adjliK3x+2pRigjmN52GzueVdGVvXT7KOXaAM9Ro9zgw
         k3LEEqhA1bXQ2FcuGm2Po/G4lt1hRmkMAbpz2yDxdPcWZ7kO9QmcpqUobSbS43vmOic1
         tC8aIZIlMdOZqIRQxx2sMSPSSYRqdzaYxlF/GR/nWQviD+5Be7t1ypzfQc9grzyp2N2p
         MvwxvY01SjKXVWy2pclSiltRK/gPD1kBtnsN2GmhCU/nhVrA0CSG8c8D8ENwGGCRHpOd
         Ccow==
Received: by 10.43.4.70 with SMTP id ob6mr6456568icb.56.1354246335582; Thu, 29
 Nov 2012 19:32:15 -0800 (PST)
Received: by 10.64.51.134 with HTTP; Thu, 29 Nov 2012 19:32:15 -0800 (PST)
In-Reply-To: <CAJDDKr7yr2JSutcEy1mz-SfMq8ZdNzR3+s++ooenn5+wD-LDAw@mail.gmail.com>
X-Gm-Message-State: ALoCoQkw0uzzVXFF8TZPuYVWicrpx8v47AJqQnmu/N5cunoqbNXIbdzONUIDFgvNUlDZ2ofSGTeR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30 November 2012 08:54, David Aguilar <davvid@gmail.com> wrote:
> There's a feature that does exactly this.
>
> http://www.kernel.org/pub/software/scm/git/docs/git-shortlog.html
>
> See the section called "Mapping Authors".
> It discusses the .mailmap file.

I have my name there :)

I thought using names with different case is actually different then misspelling
it. And so, everybody must not be required to update their names in mailmap
with different case. So, with same email id and same name (that may be in
different case), we can show commits together in shortlog.

--
viresh
