From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Git Pack: Improving cache performance (maybe a good GSoC practice)
Date: Wed, 30 Mar 2011 14:07:22 +0200
Message-ID: <AANLkTikD9OrboQ_0Qi+6vsJz3Bxe5g5GazTCP4LUFynN@mail.gmail.com>
References: <4D925B63.9040405@googlemail.com> <AANLkTin6z3hM7nyMqOUPdHrY9TmRVAzpchM+4O=S7KKj@mail.gmail.com>
 <4D92EDA0.8030309@googlemail.com> <AANLkTim+Ge2c-i_jUi8YN8g+cQmXuyKYrdHC+jYukjQy@mail.gmail.com>
 <4D92FD9D.8040707@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Vicent Marti <vicent@github.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Sebastian Thiel <byronimo@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 14:07:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4uBi-00056z-IP
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 14:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755868Ab1C3MHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 08:07:45 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51739 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754285Ab1C3MHo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 08:07:44 -0400
Received: by fxm17 with SMTP id 17so979265fxm.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 05:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=JzhdG4EX4XAxFdXy/NomgaFiy8x8ajVTD4zYWeI1T3U=;
        b=slTTuWqbBo8XAtlFnTJ7n2vFZCVcGbuSESO26q8IVSovdcib/NmL33jvpmCkNzmndo
         igOOlrFnGFXEZryv2iHxetyNXPKg0vKNwhtHkTLsrd+YXfzjesy6/jr37QaT4BaUrsgo
         IL2gyeGNSs7uzkiVjDY4th+Duz35nYApCQ77s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=JKTgN1QY9Jm5m3Mq0OG+t0HLnz8Ap368yDKBD/FVWjqyefUZ4dtlMLZB6qxLftk3uV
         y76x8G/87dkHP1RcPS73Ts9aMhyRNwi6/6maY5M9ZcT3etydUVN5KlbBxIOn5sYr9C5e
         hF051N+xiWa8x0vAQBJ6NhynY/AIUGB82+MxI=
Received: by 10.223.35.147 with SMTP id p19mr1208530fad.13.1301486863053; Wed,
 30 Mar 2011 05:07:43 -0700 (PDT)
Received: by 10.223.126.145 with HTTP; Wed, 30 Mar 2011 05:07:22 -0700 (PDT)
In-Reply-To: <4D92FD9D.8040707@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170377>

On Wed, Mar 30, 2011 at 11:53 AM, Sebastian Thiel
<byronimo@googlemail.com> wrote:
> Thank you very much for the heads-up - I was using old mirrors it appears:
>
> git://repo.or.cz/libgit2.git
> git://repo.or.cz/libgit2/raj.git
>
> Its quite terrible that I was left thinking that the project stalled for
> so long, and it was hard for me to understand why people would continue
> to bring it up :).
> Now it all makes sense !
>

I was also confused by this at first. Shawn, would you mind updating
the readme-field in the repo.or.cz-mirror to reflect that the project
has moved to GitHub?
