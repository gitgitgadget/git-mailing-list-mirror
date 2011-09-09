From: John Szakmeister <john@szakmeister.net>
Subject: Re: The imporantance of including http credential caching in 1.7.7
Date: Fri, 9 Sep 2011 06:54:15 -0400
Message-ID: <CAEBDL5UymsgsQnE9t121omGkR3Zw9BsFqOinTshxEN4WDcOdeA@mail.gmail.com>
References: <CAFcyEthzW1AY4uXgpsVxjyWCDXAJ6=GdWGqLFO6Acm1ovJJVaw@mail.gmail.com>
	<4E6769E3.4070003@drmicha.warpmail.net>
	<20110908191053.GA16064@sigill.intra.peff.net>
	<4E69C8F0.9070204@drmicha.warpmail.net>
	<87pqjaxbrm.fsf@lifelogs.com>
	<CAEBDL5VtVZcmQnj2CH7XzZ0YV_X61gO69-dXriGiYsAqk=NLPg@mail.gmail.com>
	<CABPQNSbrjNR73GxE4xXFPqaVSUOaa5Drt4Je+zGY82rzajQxuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Kyle Neath <kneath@gmail.com>,
	Jeff King <peff@peff.net>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Sep 09 12:54:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1yj0-0005vO-I2
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 12:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758743Ab1IIKyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 06:54:16 -0400
Received: from mail-vw0-f43.google.com ([209.85.212.43]:48133 "EHLO
	mail-vw0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758740Ab1IIKyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 06:54:16 -0400
Received: by vws10 with SMTP id 10so1237691vws.2
        for <git@vger.kernel.org>; Fri, 09 Sep 2011 03:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=G56+ba9i2vBaJoSO4taIzNB+N0HMLbsYmC0B2UNZUEg=;
        b=LiMmGH+Wkikk4YfWDum3yK759h+RQJdTDXXQft9sNGekjdIxtiON1T3MacAdfMflCr
         5DJ86C5Qywr1rAS/PSvxgGAKzMKLteMA9AJsO6kO4hMHEPMiT3uBDGjyVL8txBRjMgkL
         q05rmgSCE0EN0sunKzU/nKwvdziQ47gQf+0eE=
Received: by 10.52.38.99 with SMTP id f3mr217471vdk.392.1315565655480; Fri, 09
 Sep 2011 03:54:15 -0700 (PDT)
Received: by 10.52.160.196 with HTTP; Fri, 9 Sep 2011 03:54:15 -0700 (PDT)
In-Reply-To: <CABPQNSbrjNR73GxE4xXFPqaVSUOaa5Drt4Je+zGY82rzajQxuw@mail.gmail.com>
X-Google-Sender-Auth: K5f_KMu4JvkUBRpXpSiyJKkkus8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181048>

On Fri, Sep 9, 2011 at 6:48 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
[snip]
> Actually, it seems recent Windows versions does have a credential
> manager, including an API:
>
> http://www.yanzzee.com/2009/09/windows-keychain.html
> http://msdn.microsoft.com/en-us/library/aa374731(v=VS.85).aspx#credentials_management_functions

Yay!  It's about time they grew that feature. :-)

-John
