From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFH] rpm packaging failure
Date: Sun, 31 Jan 2010 01:56:51 +0100
Message-ID: <fabb9a1e1001301656t4ca644f5lf35075ac0f2bed8e@mail.gmail.com>
References: <7v8wbgueqz.fsf@alter.siamese.dyndns.org> <20100130151921.GM29188@inocybe.localdomain> 
	<7vsk9nsemh.fsf@alter.siamese.dyndns.org> <201001310106.52303.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Todd Zullinger <tmz@pobox.com>,
	git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jan 31 01:57:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbO7r-00029w-Nw
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 01:57:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035Ab0AaA5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 19:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753701Ab0AaA5M
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 19:57:12 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:48959 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753339Ab0AaA5M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 19:57:12 -0500
Received: by pxi12 with SMTP id 12so2935504pxi.33
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 16:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=GY3fbOWhiaGUdcuv7S9RCa5+33CH+srx4rKVoho48t8=;
        b=Whyh82gxh8TjP55IJCrw9CHNq3bVzklSHOrqsB6B1kTbkRoWBOdIZMDQ/t3Iw6CT4w
         Dtvx/TO2GsR1mJRXcsTs+A4EUgIGFoZALur2GT29o1ola8FhgaNgCZtusYjSK483P3IH
         DThkAy+RIDdkIN8Y9AOP2UaKx/a1efBp2AbFw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=tC1cs7WuxbTJLkgFrgQccQIJCnTGQDkBCO6Yyv3RY7932M1UN/mSaz9ueIeoF/tozk
         EQWJIDtSfDyIZeHih6ubO4TYboZKHUWPQpdpLQTawP5E7OXWvbsEWB8RoamKv979vUq4
         z8+2H6LTE8zc08Ml4TLtRC6YDMyOheQh+5DZ8=
Received: by 10.142.8.6 with SMTP id 6mr1833054wfh.159.1264899431190; Sat, 30 
	Jan 2010 16:57:11 -0800 (PST)
In-Reply-To: <201001310106.52303.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138523>

Heya,

On Sun, Jan 31, 2010 at 01:06, Johan Herland <johan@herland.net> wrote:
> AFAICS, there's no reason why these should be installed without anything
> actually using them. Although I defer to Sverre, who did the last work in
> this area.

Agreed, no need to package the git_remote_helpers stuff yet in 1.7.0,
since it'll be 1.7.1 at the earliest that we'll include git-remote-hg
(and even that's assuming I'll find the time to work on it).

-- 
Cheers,

Sverre Rabbelier
