From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 17/17] revert: Introduce --continue to continue the
 operation
Date: Mon, 18 Jul 2011 15:09:43 -0500
Message-ID: <20110718200943.GB6657@elie.gateway.2wire.net>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-18-git-send-email-artagnon@gmail.com>
 <20110712204650.GG14909@elie>
 <CALkWK0==A1a-kzqXuEkjS+FMR1CAzJox8MBdkQGMLukoU15L9w@mail.gmail.com>
 <20110717183219.GB27787@elie>
 <CALkWK0mfRR4M_VRQbpXzM97i4-fjF9=S+xPpCuwL-EQmaA9jfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 22:09:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qiu8Y-00053x-Nj
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 22:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472Ab1GRUJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 16:09:50 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:54079 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933Ab1GRUJt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 16:09:49 -0400
Received: by yia27 with SMTP id 27so1488606yia.19
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 13:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=1p6pFDRy5o1X0gnhHAD6TcC2RVrTIU29T+vfS79X7Xw=;
        b=x7f5p5wLcVw3812561yVd9hwDk+5j4m7xkyYBk9e9bSROtDbvZvKLl/PI5qw4G4WlE
         yBUtMqxc/6vh/+4SzUI8EgDfZMNUqOn4lbuAchmWmaqa66hNniqbLsheLkJPl1Hqe75/
         6dayttyDyxSYgMC7lLJpP82pciI5lKzPJbPXI=
Received: by 10.236.76.41 with SMTP id a29mr8732640yhe.39.1311019788325;
        Mon, 18 Jul 2011 13:09:48 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-74-225.dsl.chcgil.sbcglobal.net [69.209.74.225])
        by mx.google.com with ESMTPS id k8sm3406323yhm.17.2011.07.18.13.09.46
        (version=SSLv3 cipher=OTHER);
        Mon, 18 Jul 2011 13:09:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0mfRR4M_VRQbpXzM97i4-fjF9=S+xPpCuwL-EQmaA9jfw@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177403>

Ramkumar Ramachandra wrote:
> Jonathan Nieder writes:

>> Hmm, I thought I remembered this coming up previously and Junio
>> mentioning that it was intentional (maybe in the context of
>> CHERRY_HEAD?), but I haven't been able to find the relevant message.
>
> Hm, not automatically signing off on a commit resolution.  I'm not
> sure I understand why.

Well, "intentional" doesn't mean "good behavior".  I've already said I
don't like it. :)  If you remind me, I'll write a patch to make the
sign-off from cherry-pick -s persist.

[...]
> Wait.

Thanks for a nice explanation.  The detail that seems to be missing is
that the meaning of --signoff is intended to be per-project.  In some
projects, it might represent "I reviewed this" or something else
rather than the developer's certificate of origin.
