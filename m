From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Relative ls-files
Date: Wed, 23 Mar 2011 23:10:23 +0700
Message-ID: <AANLkTin=7FzjrJ1q3_AgO9erWEsm=DSoHMUPDiwFAqr2@mail.gmail.com>
References: <AANLkTi=fP+jBpLuxst2rv02pYRmj4HOkv8Yenc-dR-N_@mail.gmail.com>
 <4D89D052.5030801@drmicha.warpmail.net> <AANLkTimc7gNKbh3C2hyMtFK6D1OWNALD+GvzmhG5cZrn@mail.gmail.com>
 <AANLkTimdLGgGXGRNVH5+X-cnhK2NWfWx9k0apt-6rr1Z@mail.gmail.com>
 <4D89DCBE.3060400@drmicha.warpmail.net> <7voc51g7xo.fsf@alter.siamese.dyndns.org>
 <4D8A1883.1030606@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, demerphq <demerphq@gmail.com>,
	John Tapsell <johnflux@gmail.com>,
	Git List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 23 17:11:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2QeL-00062S-4b
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 17:11:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933195Ab1CWQLD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 12:11:03 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54070 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933123Ab1CWQLB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 12:11:01 -0400
Received: by wya21 with SMTP id 21so7791939wya.19
        for <git@vger.kernel.org>; Wed, 23 Mar 2011 09:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=bUDGKOjq4wPUK/TaWs1XGYTvOhChtbXF0t9T90zqWgI=;
        b=W0EhYL0WZ4pYLdS07ehu6VDBrFLiibbqoA8hkxl9D/C5L35lpT15vIUzVrY1HWlpAu
         hYk/5D9y0zr+jF0ZSezhHHASIHW330iN88lmH4yb92IKkaw+5+6B1w7dj0dOZ5hWXcss
         GUaTW0YQotsNGkLrGsz8Kh2Ggva37gaQVaVns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=HNi9dTW1Uf8RLJjSKPNZ3KxJP5vHEXDNa5m9q3p2ReHuBgL0/6NJ2FqlUjSVQyiepC
         D2vxsSwCW0du+bRaT5zudriko14KJUpaB9xpVcnyrvI30p/kJ5w447aUAbzpmL7piNLV
         XCBrnDhzPH4SVHWmtKPUd41jLIRygaH0cx9YI=
Received: by 10.217.2.73 with SMTP id o51mr22272wes.66.1300896660249; Wed, 23
 Mar 2011 09:11:00 -0700 (PDT)
Received: by 10.216.163.202 with HTTP; Wed, 23 Mar 2011 09:10:23 -0700 (PDT)
In-Reply-To: <4D8A1883.1030606@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169849>

On Wed, Mar 23, 2011 at 10:57 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
>> ':/*.h' that have been suggested on the command line, so I am tempted to
>> suggest using '/' (the first slash in the example) as the magic introducer
>> and using '/' (the second) as the 'from-root' magic signature.
>
> I'm afraid (but not sure) that leading "/" would create problems for Git
> on Win! ":/" is fine according to the experts.

'/' is treated more or less just like '\' on Windows so it would not
be a big deal. The 'git add /foo/bar' issue is more interesting, imo.
-- 
Duy
