From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [RFC PATCH v2 1/3] Introduce git-unstage
Date: Fri, 24 Jul 2009 20:02:21 +0200
Message-ID: <36ca99e90907241102v1b261e43yf85ba52754edf869@mail.gmail.com>
References: <2d756f643fc7d1b50cf590c95467fa029b49ff46.1248426652.git.trast@student.ethz.ch>
	 <683ed99f389d643d21bda6750bd2ee9caf287625.1248452530.git.trast@student.ethz.ch>
	 <36ca99e90907241059l1d06681v1490a89fbbcaaf8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jul 24 20:10:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUPED-0001tN-21
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 20:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753798AbZGXSKh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Jul 2009 14:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753777AbZGXSKh
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 14:10:37 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:45010 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493AbZGXSKg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jul 2009 14:10:36 -0400
Received: by fxm18 with SMTP id 18so1584786fxm.37
        for <git@vger.kernel.org>; Fri, 24 Jul 2009 11:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MSEm7GuxLtqXN+FPWt1K9cPmz7bzMPsS54p30GmLzls=;
        b=PUjLpwt/946uvkcgvWUdYDyikTtq64OqJHr0BZ63crRwUE82O/4ww6S9n4Y6rLx1xg
         w4uomOtdvW48PcIRYGsF4o7Hn4W+si2/PV/YU5JplgHUbRFLM+WMHEq1OdfIuWRiUPa/
         kLue7e60or7C/kecTOlni6sb2SjC4jl/Wgnog=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MF1zaFYx5edC5+7X6GQ6kbU20TpkXzTGd9YzFsw4KmEIjEQr7nL2oh0QShDjwsto3o
         sTGSQM+yl7EmOS4r+0u3Ni9z4TFUt8ysy260NJtlPYsmcYh7750tKTOOmK+zyf5AOVS0
         HdfMx63CRHmSe40Phl91QADltdtPsMt9LshG4=
Received: by 10.223.119.198 with SMTP id a6mr1883216far.42.1248458541548; Fri, 
	24 Jul 2009 11:02:21 -0700 (PDT)
In-Reply-To: <36ca99e90907241059l1d06681v1490a89fbbcaaf8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123937>

On Fri, Jul 24, 2009 at 19:59, Bert Wesarg<bert.wesarg@googlemail.com> =
wrote:
> On Fri, Jul 24, 2009 at 18:24, Thomas Rast<trast@student.ethz.ch> wro=
te:
>> As such, it is the same as 'git reset --' ...
> Nope!
>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exec git reset "$@"
> See!
Sorry, it was not obvious clear to me, that you don't shift away '--'.
Does the option parsing add '--' if it is missing?

Bert
>
> Bert
>
