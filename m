From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] help.c: Pull cmd_version out of this file.
Date: Thu, 28 Oct 2010 00:13:25 -0200
Message-ID: <AANLkTinGomS0OS-ZpOQun7E_KVRkL4A-w7MU1AG0bBAH@mail.gmail.com>
References: <20100830023812.GA4010@burratino>
	<20100830024020.GB4010@burratino>
	<AANLkTimDjRz=JmiVn+ybQ5ewaj=7N5tp48fUArD5vG_H@mail.gmail.com>
	<7v1v9e803a.fsf@alter.siamese.dyndns.org>
	<AANLkTinHJHzcoFFjv-TaQ+DYVyqn46fqA802m8Lq5anp@mail.gmail.com>
	<20100902043500.GF29713@burratino>
	<7vvd6o14zz.fsf@alter.siamese.dyndns.org>
	<AANLkTimX2NhXGdK0vVMaw-Fm6fpg4i5pbOZGA8Cc-+ui@mail.gmail.com>
	<20101027151832.GA10614@burratino>
	<AANLkTinxG-=EKeNH3--34Ya4w0E=i_bdmJ7iv2em8C+8@mail.gmail.com>
	<20101027164508.GB11069@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 04:13:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBHzk-0005cv-VG
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 04:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627Ab0J1CN2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 22:13:28 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39181 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757632Ab0J1CN0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Oct 2010 22:13:26 -0400
Received: by bwz11 with SMTP id 11so1181114bwz.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 19:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+unNOBJaJrYiYBLzb+zwRs9OY5EkryL9EbjSrgl2uBU=;
        b=LKdl/oAqLXzegstLOdkRED7tPYPleOve73FR/6LeiOelVAwXW+3eVWs2eqVGwLJuX7
         ap6+By9F04VU1Wl+I984r7yFqgPBa3pwzrFoX1hNYKMDZYTaECunx/q2FpWd5+GFBvQe
         lUN2lQqZ3o/JQTg9UauJBdVAOjgYjbz+gGPdo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Lyin9XbTXsVZHsK35emcdL8jl/qK5IQ/YyWT7i2jkNrkgICkQuPmM7NJN0R78HBZjk
         +R7XLl+RRlvGsUTzp9DTp3yvxo3nCIkJDjX+V5s6duncrgQdOfvJSmA3yt3ZWlGEDrEK
         QALXF4qN0zMEBx5c2TpQw3pMosUeznIBfdE7Q=
Received: by 10.204.119.136 with SMTP id z8mr7824375bkq.167.1288232005170;
 Wed, 27 Oct 2010 19:13:25 -0700 (PDT)
Received: by 10.204.69.206 with HTTP; Wed, 27 Oct 2010 19:13:25 -0700 (PDT)
In-Reply-To: <20101027164508.GB11069@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160152>

On Wed, Oct 27, 2010 at 2:45 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Ah, found it.[1]
>
> | At this point, adding the dashed-form "git-version" to the filesyst=
em is
> | going backwards. =C2=A0These files are only to help people who have=
 old scripts
> | from pre 1.6.0 days with "PATH=3D$(git --exec-path):$PATH" with the=
ir
> | environment.
> |
> | We should instead try to not adding them (which would probably need=
 tweak
> | in the command list generation code in "git help"), as nobody from =
pre
> | 1.6.0 era would have called "git-version" binary.
>
> Hope that helps.
>
Nope, sorry. I don't fully understand his explanation.

Also, Junio, thanks for the "I don't like
churning-for-the-sake-of-churning". This is very incentive.
