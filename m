From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/5] sequencer: Expose code that handles files in .git/sequencer
Date: Thu, 11 Aug 2011 11:57:14 +0530
Message-ID: <CALkWK0=X-cwH+v4sbikhcJ3LO6U7e3heWVPUhu0AtE-S9qxU_g@mail.gmail.com>
References: <1312970151-18906-1-git-send-email-artagnon@gmail.com>
 <1312970151-18906-5-git-send-email-artagnon@gmail.com> <20110810152126.GE31315@elie.gateway.2wire.net>
 <CALkWK0nJUTtNgCHF6CE2-w+3ZwdBrscBRw0e0L8wX86Za0G=DA@mail.gmail.com>
 <20110810155332.GB4076@elie.gateway.2wire.net> <CALkWK0kxtyPABBUOrXtKDxPCBKt3CynoP4Fm8f_+C1ymkLTo-w@mail.gmail.com>
 <20110811062236.GA27394@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 11 08:27:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrOk1-00064S-Ab
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 08:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272Ab1HKG1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 02:27:36 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49089 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799Ab1HKG1f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 02:27:35 -0400
Received: by wwf5 with SMTP id 5so1713229wwf.1
        for <git@vger.kernel.org>; Wed, 10 Aug 2011 23:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nc6FBFM4tSY6Uyt1yv0egloaFWpSWVqpxwibfaW2/Hw=;
        b=I4h0PSegWPqd81x7ZxGm4fpch+UY6R9MPXnYAIOZwWhj0DOwQqlqaU4h7uP5NgMNNU
         juId0sXFsbgJmmER4sxdFRQjVXkSM56ckmUQrQL8MT2/rj2qT4VwehTrl546nWyeN1PW
         gtBWMKLVKKRnmWqsF2jCAZdF6tA+NKqLkN2Hk=
Received: by 10.216.37.16 with SMTP id x16mr609565wea.93.1313044054187; Wed,
 10 Aug 2011 23:27:34 -0700 (PDT)
Received: by 10.216.139.31 with HTTP; Wed, 10 Aug 2011 23:27:14 -0700 (PDT)
In-Reply-To: <20110811062236.GA27394@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179084>

Hi Jonathan,

Jonathan Nieder writes:
> I'm a very pragmatic person: as long as the code and history are
> readable and behave reasonably well, I'm happy.

Thanks for clarifying; I'll get to work right away.

-- Ram
