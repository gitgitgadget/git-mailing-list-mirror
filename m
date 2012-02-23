From: =?ISO-8859-1?Q?Nelson_Ben=EDtez_Le=F3n?= <nbenitezl@gmail.com>
Subject: Re: [PATCH] Improve http proxy support
Date: Thu, 23 Feb 2012 13:20:45 +0100
Message-ID: <CAAUd643RHOrhm+gfW5UeXfjcG0Xr+q0nxzAVqYsh8VxhhP_m1g@mail.gmail.com>
References: <CAAUd640GaLz4TGs_Lz6KbSFK0VcEVxGfO6PpSCdhch+fYwVovw@mail.gmail.com>
 <vpqd397x8fc.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Feb 23 13:21:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0Xfw-0000lJ-7t
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 13:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025Ab2BWMV1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Feb 2012 07:21:27 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:44458 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751676Ab2BWMV0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 07:21:26 -0500
Received: by lagu2 with SMTP id u2so1382210lag.19
        for <git@vger.kernel.org>; Thu, 23 Feb 2012 04:21:25 -0800 (PST)
Received-SPF: pass (google.com: domain of nbenitezl@gmail.com designates 10.112.29.6 as permitted sender) client-ip=10.112.29.6;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of nbenitezl@gmail.com designates 10.112.29.6 as permitted sender) smtp.mail=nbenitezl@gmail.com; dkim=pass header.i=nbenitezl@gmail.com
Received: from mr.google.com ([10.112.29.6])
        by 10.112.29.6 with SMTP id f6mr482852lbh.69.1329999685351 (num_hops = 1);
        Thu, 23 Feb 2012 04:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=uoGJ8EvPATBNdRy68Ve3zv7+VzMW7TKHbSbKbnh1Mfw=;
        b=gY/Fr1HZOpYOaXt23/fELGK/mdvMl7Gfp3UKH98sHR+IUUWlikjUuESlEjKeYFhmJV
         KvG0j/WzZRoKLQVu/y1U25gKFzygFvqYCnWgWu9fuOcriqwY6iLXDrL20ulptbzVB7cw
         iUftPt+q0eaNUwUEEP3QfhwgxpN7vwXKVdTtk=
Received: by 10.112.29.6 with SMTP id f6mr411538lbh.69.1329999685270; Thu, 23
 Feb 2012 04:21:25 -0800 (PST)
Received: by 10.152.114.74 with HTTP; Thu, 23 Feb 2012 04:20:45 -0800 (PST)
In-Reply-To: <vpqd397x8fc.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191358>

El d=EDa 22 de febrero de 2012 15:13, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> escribi=F3:
> Nelson Ben=EDtez Le=F3n <nbenitezl@gmail.com> writes:
>
>> Hi, my initial motivation for this patch was to add NTLM proxy
>> authentication [...]
>
> That sounds interesting, but please read Documentation/SubmittingPatc=
hes
> in Git's tree. The formatting of your email is wrong (giving more wor=
k
> for your maintainer) and you need to sign-off your patch to allow you=
r
> code to be legally included.

Thank you for the advice, I read README file (couldn't find a HACKING
one) and the git website, and neither of those had a reference to
SubmittingPatches..
