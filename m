From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: Re: What's cooking in git.git (Feb 2012, #09; Sun, 26)
Date: Thu, 1 Mar 2012 01:11:50 +0100
Message-ID: <CAA787rkZKxYk_+WGD7_EhqxouzT=nhUEG0nn8KpZLSJskKiJdA@mail.gmail.com>
References: <7vd390btrf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 01:11:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2tcj-0006Uv-DG
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 01:11:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035Ab2CAALw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Feb 2012 19:11:52 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61788 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753839Ab2CAALw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Feb 2012 19:11:52 -0500
Received: by qaeb19 with SMTP id b19so2352448qae.19
        for <git@vger.kernel.org>; Wed, 29 Feb 2012 16:11:51 -0800 (PST)
Received-SPF: pass (google.com: domain of sunny256@gmail.com designates 10.224.196.66 as permitted sender) client-ip=10.224.196.66;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of sunny256@gmail.com designates 10.224.196.66 as permitted sender) smtp.mail=sunny256@gmail.com; dkim=pass header.i=sunny256@gmail.com
Received: from mr.google.com ([10.224.196.66])
        by 10.224.196.66 with SMTP id ef2mr4497520qab.64.1330560711642 (num_hops = 1);
        Wed, 29 Feb 2012 16:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Q6fXJ0EWUINuDFilXxohECpYnUKm0ylQgkYdgZfvi9s=;
        b=NSc45JAYKHy3dPSdtJrIGrubKmhYeyV4qzllXnMEuD81MnCZayMOoHhUMFzX1l3atD
         Gk1Ip8RFoiW4byT7CuW6b9ZHf1d8ronb9Rxn4l4fosAHcbLGMjDgrdQYZP/6/m/mZGdu
         MNk+kiigf90/enUgcYyawEy1G/O5qti9/cS6Q=
Received: by 10.224.196.66 with SMTP id ef2mr3754500qab.64.1330560711049; Wed,
 29 Feb 2012 16:11:51 -0800 (PST)
Received: by 10.229.240.134 with HTTP; Wed, 29 Feb 2012 16:11:50 -0800 (PST)
In-Reply-To: <7vd390btrf.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: JlPBMjyMiBseHawGsPZa_k-3GaE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191865>

On 27 February 2012 08:49, Junio C Hamano <gitster@pobox.com> wrote:
> * cb/fsck-squelch-dangling (2012-02-26) 1 commit
> =C2=A0- fsck: do not print dangling objects by default
>
> Introduces "fsck --dangling" and removes the output for dangling obje=
cts
> from the default output.
>
> I personally do not think it is worth risking backward compatibility =
in
> the way this patch implements the squelching of the output. =C2=A0An =
approach
> to add --no-dangling option without changing the default would be OK,
> though.

Agree. I use this functionality a lot, and this change would break a
script I use to restore dangling commits. There's probably some
(dirty) way around it, but I'd prefer if the backwards compatibility
is retained.

BTW, the script I use is located at
<https://github.com/sunny256/utils/blob/master/git-dangling> and I
find it quite useful. Do you think it could be a contrib/ candidate?

Cheers,
=C3=98yvind
