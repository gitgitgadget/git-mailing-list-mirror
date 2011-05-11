From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: How do I push all remote branches to a new/different remote?
Date: Wed, 11 May 2011 19:33:10 +0100
Message-ID: <BANLkTi=JBMf8t=PQo13pVYd03wczsyjMtA@mail.gmail.com>
References: <BANLkTi=EtRPcjaeCRNgLQ39JsqzS=_69hA@mail.gmail.com>
	<7vy62df77q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 11 20:33:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKEDm-0001m1-BF
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 20:33:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927Ab1EKSdN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 May 2011 14:33:13 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54859 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890Ab1EKSdM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 May 2011 14:33:12 -0400
Received: by yxs7 with SMTP id 7so266882yxs.19
        for <git@vger.kernel.org>; Wed, 11 May 2011 11:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+uN6ts00ns6FNS8nzim4d++US5vZIinStw6P/fE0AKQ=;
        b=IYzah3N+AVqXFl889C+voACMZsVPJpvRAH8pfrC+m+lPhSf7jPw7nVjqvJ47i3Mpn5
         Hv5gdQVRUEry4AdEsPRcwoanJCRdglsf80mwLQdydSKzzvlIsb1JeWG6Sv1j+liBFpM1
         M6i1KpvDtS5OGzmMnsODk0irjD2Iz9VHzoToQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=a6+GqLPEPOwBOlR6niRnCLaO36Gm8UdERLYNYbrGbOvKPXx6pfaRol43DobmCA2SHB
         w9Givsa5uUXI4zWMO5Tie/w3V9q/Aw6yHr8EAnYW7996VYOvAMkwtWPDrOGHNtau95+U
         PBGUWprNVWc+f3QzzRjuPXOxaG5Cvr+HfZ1SM=
Received: by 10.91.136.15 with SMTP id o15mr7971411agn.155.1305138790421; Wed,
 11 May 2011 11:33:10 -0700 (PDT)
Received: by 10.90.242.2 with HTTP; Wed, 11 May 2011 11:33:10 -0700 (PDT)
In-Reply-To: <7vy62df77q.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: d6YcCSafhhfQy27Sua1MKtRVGvk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173419>

On 11 May 2011 19:00, Junio C Hamano <gitster@pobox.com> wrote:
> Howard Miller <howard@e-learndesign.co.uk> writes:
>
>> git push ...you tell me..
>
> You can say "please" here ;-) =A0Shouldn't this work?
>
> =A0 =A0 =A0 =A0git push $that_url 'refs/*:refs/*'
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

"please" very much meant and thank you very much. I was expecting some
option I had missed but I wouldn't have worked that out.

What I don't quite understand is what does --mirror do? I am assuming
it pushed all the data but none of the branches which, on the face of
it, doesn't seem very useful.
