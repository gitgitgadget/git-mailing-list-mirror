From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 2/3] pull: trivial cleanups
Date: Thu, 16 May 2013 08:36:08 -0500
Message-ID: <CAMP44s01cySnctrLjbRO6gDkFvAeoHtcSjdp11Sa8CujAKUEwA@mail.gmail.com>
References: <1368675828-27418-1-git-send-email-felipe.contreras@gmail.com>
	<1368675828-27418-3-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0=tP=v=3Q4dzPc=W0=j_7iFYdGnzkaV6U_MFSg=NCE49w@mail.gmail.com>
	<CAMP44s0sg6zQc9=cD1X61joxSd=LK7qT1k-suej3dYDD826hgw@mail.gmail.com>
	<CALkWK0=RF4cjQ4Lz4Qi2iac_NgLdzBRw5Q9uf8KjYJju8swWDQ@mail.gmail.com>
	<CAMP44s1vMTfrSaU+0S8EOM5g4L0885780SvT_THBr7u==bJ06A@mail.gmail.com>
	<CALWbr2w120xDGHXB9b2UHgz5fAqX+VaSHMsaf3dhfx_5dYbruA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 15:36:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcyLv-0001c9-QE
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 15:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753504Ab3EPNgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 09:36:12 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:52301 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753425Ab3EPNgK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 09:36:10 -0400
Received: by mail-la0-f45.google.com with SMTP id ec20so2684808lab.4
        for <git@vger.kernel.org>; Thu, 16 May 2013 06:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=wUoiUro09f59dIdpYlENpnIMc5Rcx8BhhY44hJfzah4=;
        b=kUBwjjKDWXLfJuq9pnAOJ5/Srac9fTJlAp5IvHVjH00as1vJb1fAIYsMfHEZJNRAsg
         7BCkYWWcQ8XPMIVCeQPOaAQFM3jD4hgRMbHvMo8On0nhLYiPme7l4w7tt2xdfRgVpWuJ
         G/dnYmxSP6o33B+c/4w243dex7EDxJxj/m4yWInIBtiFGMlfW9d6v+g7iEymL1DVDYeB
         GnwKAqbGUFKOQMbTiLlqg7ZASfLctTZUBJafOwKddyXDVY+wHarQ7WmGBbZxGyUsWwm5
         fg4VeVAoBNL0XMX/zkETKh4BDlAbqpvjUxWXmhvybIMiIwR4PgOS+FiGVgreV9dgz8fS
         kdMQ==
X-Received: by 10.112.166.101 with SMTP id zf5mr19722482lbb.59.1368711368424;
 Thu, 16 May 2013 06:36:08 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 06:36:08 -0700 (PDT)
In-Reply-To: <CALWbr2w120xDGHXB9b2UHgz5fAqX+VaSHMsaf3dhfx_5dYbruA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224566>

On Thu, May 16, 2013 at 6:54 AM, Antoine Pelisse <apelisse@gmail.com> wrote:
> On Thu, May 16, 2013 at 11:36 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Actually trying that command:
>>
>> % git fetch origin 'refs/tags/*:refs/tags/*' 'refs/heads/*:refs/heads/*'
>> fatal: Refusing to fetch into current branch
>> refs/heads/fc/fast-export/cleanup of non-bare repository
>> fatal: The remote end hung up unexpectedly
>
> Can you try something like this instead ?
>
>     git fetch --update-head-ok # or -u

Nice! That does the trick.

-- 
Felipe Contreras
