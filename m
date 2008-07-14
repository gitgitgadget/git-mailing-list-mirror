From: "Carlos Oliveira" <coliveira@gmail.com>
Subject: Re: RA layer request failed
Date: Mon, 14 Jul 2008 14:47:24 -0400
Message-ID: <3cfdbff10807141147t5189b10dw3a49414ff33d5baa@mail.gmail.com>
References: <3cfdbff10807141141h2a182dd5vc79a6b41bdbea748@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 20:48:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIT6E-0001xv-9t
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 20:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757261AbYGNSr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 14:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753028AbYGNSr3
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 14:47:29 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:34443 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013AbYGNSr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 14:47:28 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2963730fkq.5
        for <git@vger.kernel.org>; Mon, 14 Jul 2008 11:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=wdUhOkPUHzhk+st5rP2Ci5Sqi0076+VIQOlTtXqpmLw=;
        b=jyBxpBAbeGpmriDHIoW8B6ka+Fg76U4bYRfiOI86DA17hTQ/491IZiX4bw1IC6ol5F
         ftdr0eqizskrlsx4xkqMDb0VACGuVnSv3TjafZBfjXVaMLrUc27HcbCqF2gIdIiZTEju
         7L9kVtWa0MU0V4L6j7ox0KNpqa3BhbGxCnvR0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=yH6/8oDmuseIDRdKaZgDRF/HNO4b1nkYy+gu73y/GWj7OeTqOmABt3m8DVIDtZs3tC
         Uka0MRqs580HlwHovar+EmMoZAWEyCxlHvLgteDmWXy2N4bBWbeBN/LkhDihhVGmPB+h
         0dCmiEv1nQMGrIhXKROP6cKsQF4OtG+juOndA=
Received: by 10.86.70.11 with SMTP id s11mr14683670fga.71.1216061244325;
        Mon, 14 Jul 2008 11:47:24 -0700 (PDT)
Received: by 10.86.92.20 with HTTP; Mon, 14 Jul 2008 11:47:24 -0700 (PDT)
In-Reply-To: <3cfdbff10807141141h2a182dd5vc79a6b41bdbea748@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88446>

Just some additional information:
- it is not a connectivity problem: I can commit from a conventional svn client
- git version is 1.5.6 on cygwin

-Carlos

On Mon, Jul 14, 2008 at 2:41 PM, Carlos Oliveira <coliveira@gmail.com> wrote:
> Hi Everyone,
>
> I am using git svn dcommit, and I am receiving the following message:
>
> RA layer request failed: COPY of <file>: 40 Not Found ... at
> /usr/bin/git-svn line 461
>
> This is the first time I see this message after I started using git
> svn (I use it a lot).
> This all started when I had a interrupted dcommit, which I managed to
> rebase to a safe
> state.
>
> Does anyone know what this error means, and how I can fix it?
>
> Thanks,
> -Carlos
>
