From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: non-monotonic index error
Date: Tue, 2 Sep 2008 17:37:21 -0400
Message-ID: <9e4733910809021437w40eb1e2cv6379e5d199e234a5@mail.gmail.com>
References: <9e4733910809021257v3012ec89l64b2bb412ac1ebbd@mail.gmail.com>
	 <alpine.LFD.1.10.0809021625230.23787@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Sep 02 23:38:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kada2-0003tZ-MO
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 23:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbYIBVhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 17:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751664AbYIBVhX
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 17:37:23 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:62362 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607AbYIBVhX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 17:37:23 -0400
Received: by py-out-1112.google.com with SMTP id p76so1350936pyb.10
        for <git@vger.kernel.org>; Tue, 02 Sep 2008 14:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=B7rALX9kv9ZK5gmN+E7qKa5Ef1MRkhiPuh91/K3oPNg=;
        b=tgoNYBwpQ7nfpoLRj5CKEgZ914i+2D16k2kfmBktDjw2HqEQzW1Apw8lPBcqrnv7zb
         ASIbdz4E1JsF7U2ZfcAyZtxWe6R4DsAwry6nl9ypdX4vkBU+9MXz1hXNXCGBDaVO4fuq
         9CTQZ7hhgZmLCm2nKdJotw2TSK+wwugbXVl1A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=aLKlJHCyQJgjwFgdKisC3huitryJKGC0HONaarBylSG+BTFG2b+yLId+BYS20yjJgW
         HCmQF9v5W0nASgowo8AQijBpUMVwexQyPanKdfkQ4cYViccoLpfSRm9PmKur8bxIu+D5
         iZ118I8vY9DOuV3EAIcjrOz9ZHJv9qcypVIC0=
Received: by 10.65.112.18 with SMTP id p18mr16449894qbm.38.1220391441780;
        Tue, 02 Sep 2008 14:37:21 -0700 (PDT)
Received: by 10.64.178.13 with HTTP; Tue, 2 Sep 2008 14:37:21 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0809021625230.23787@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94717>

On 9/2/08, Nicolas Pitre <nico@cam.org> wrote:
> On Tue, 2 Sep 2008, Jon Smirl wrote:
>
>  > I pulled from linus, did stg rebase linus/master, git push digispeaker
>  > and got these errors.
>  >
>  > Where's the problem, at my local machine or the digispeaker one? How
>  > do I fix this?
>  >
>  > jonsmirl@terra:~/fs$ stg --version
>  > Stacked GIT 0.14.3.195.g36a0
>  > git version 1.5.6.GIT
>  > Python version 2.5.2 (r252:60911, Jul 31 2008, 17:31:22)
>  > [GCC 4.2.3 (Ubuntu 4.2.3-2ubuntu7)]
>  > jonsmirl@terra:~/fs$
>  >
>  > [digispeaker]$ git --version
>  > git version 1.4.4.4
>
>
> This should be upgraded to at least version 1.4.4.5.  If this is a
>  Debian distro and they didn't provide an updated package for git then
>  please fill a bug with Debian.
>

I just built the current version in my local directory, I'm still
getting the monotonic error on push. Do I need to repack or something?

[digispeaker]$ git --version
git version 1.6.0.1.g7f314.dirty



>
>
>  Nicolas
>


-- 
Jon Smirl
jonsmirl@gmail.com
