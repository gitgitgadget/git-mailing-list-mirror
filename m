From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Add warning when there are changes in the index and using -a with 
	git commit
Date: Wed, 21 Apr 2010 23:21:47 +0200
Message-ID: <q2pfabb9a1e1004211421q80d273ady11f4621284522c46@mail.gmail.com>
References: <v2m7fce93be1004211320r9adc0b14j11bd06c3b045e639@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Sylvain Rabot <sylvain@abstraction.fr>
X-From: git-owner@vger.kernel.org Wed Apr 21 23:22:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4hNC-0002Hv-CE
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 23:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755718Ab0DUVWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 17:22:12 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:53067 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755265Ab0DUVWK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 17:22:10 -0400
Received: by bwz1 with SMTP id 1so10705902bwz.2
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 14:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=Za0zXFxl29raFdEmx+5eqMgjknR2biWcdug/6kmVfv4=;
        b=PTdcuvNfNc/zYHbdE2ErbFB2xUA3/oi3CKX52GmzrK5IdEiR5WONATw+0s1hCgToeo
         gZ0mDGBse/N2Nxy7TKr9LTk1tjkQRUP/vRxPS9xYKSUVZ5RiU8v+7wIWSwlXR6B1H9mP
         g2SeOt4E2rQph1BEFIyCxLNcboktkwrL1/xKI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=cltJy1qXLjBNGZR1jsY3/gSMApH3/S6g+C2sON1A8nb7C9U+MaUeW/Fk0BAHSHsGh8
         z/S5JASboNbOk+g0mHLGTnnFOvu/AoMrtQkg89GE5RUAe1gZDve979Foj9VqnaLzzMkz
         l6rQ6naodMaN5fXI7k2vB3Zg3m2JO8bjwOFA4=
Received: by 10.103.168.14 with HTTP; Wed, 21 Apr 2010 14:21:47 -0700 (PDT)
In-Reply-To: <v2m7fce93be1004211320r9adc0b14j11bd06c3b045e639@mail.gmail.com>
Received: by 10.102.237.3 with SMTP id k3mr1716612muh.125.1271884927134; Wed, 
	21 Apr 2010 14:22:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145458>

Heya,

On Wed, Apr 21, 2010 at 22:20, Sylvain Rabot <sylvain@abstraction.fr> wrote:
> Many times I had the bad reflex of doing a git commit -as -m "blah
> blah" when I was willing to commit only things I had staged in the
> index.

Me too, and I think I brought it up in the past and it was dismissed
as being too annoying, but I'm not sure. Either way, you can work
around it by creating your own 'git-co' wrapper that does the check
and use that instead of 'git commit'.

-- 
Cheers,

Sverre Rabbelier
