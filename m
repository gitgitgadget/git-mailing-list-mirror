From: Sergey Sharybin <sergey.vfx@gmail.com>
Subject: Re: Re: Git issues with submodules
Date: Mon, 25 Nov 2013 23:57:45 +0600
Message-ID: <CAErtv259jxCtvbJYZHgQZv-VJ9U+JwNzWo0tn007SDTCCBScrA@mail.gmail.com>
References: <CAErtv24Lv1JegCBQ=TXvOsgBNHp=Rphk5YVAq2qqRbNmqfNSkw@mail.gmail.com>
	<CAErtv24P+wyZKvvuuPJJ0oxzMif7XtOwJDtKcTKQdKHZaAUbig@mail.gmail.com>
	<CALkWK0muxsRUtO6KYk5G3=RVN0nqd=8gOZn=jsNbTc4B9KCATQ@mail.gmail.com>
	<528FC638.5060403@web.de>
	<20131122215454.GA4952@sandbox-ub>
	<20131122220953.GI4212@google.com>
	<52910BC4.1030800@web.de>
	<20131124005256.GA3500@sandbox-ub>
	<52922962.3090407@web.de>
	<CAErtv2729o-xf=49xY06aVL1ZJzJpeH+cc_Pd1cAP52r32Ss_g@mail.gmail.com>
	<20131125174945.GA3847@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Nov 25 18:57:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl0Pu-0005hF-7r
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 18:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756745Ab3KYR5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 12:57:46 -0500
Received: from mail-vb0-f48.google.com ([209.85.212.48]:33422 "EHLO
	mail-vb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754433Ab3KYR5q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 12:57:46 -0500
Received: by mail-vb0-f48.google.com with SMTP id x16so3060294vbf.35
        for <git@vger.kernel.org>; Mon, 25 Nov 2013 09:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MT01KBT+GbLIY2bTnCQIgzeq8bR4SFwjUZ0ddic0Lag=;
        b=LTCJSRfToQqbqD3oks2orxnuTsa4g03IgKCFEKrGF7h29Z8h1fEEHI0LEYmi0Wi13s
         ToYDbBeG6d/2gNxWKGltZTjgiNWGjfDVCVD6/mbMnCJwIeqMb5NqCMLBbImp15iGOsuc
         EhOyQVFdwpxZ1VYIqyfKiiLYQqaJE2IaAOr6RibqaIyrLa4xrLDCZ4bvnIAQctFwtacR
         bjZdAwvybupjCDmC9vhl31jW+Tf1PDu9bVr1mZcT4reYj1jknmSlPtMMXPqYGItjHB1P
         jKXsOHL2ADPWnRajbxfHyfeXPq9zte4KjrqsEcmCq6hniDcpX1gjk3NosL2gOsGm8QOz
         OHZw==
X-Received: by 10.58.100.244 with SMTP id fb20mr27070886veb.6.1385402265286;
 Mon, 25 Nov 2013 09:57:45 -0800 (PST)
Received: by 10.52.169.2 with HTTP; Mon, 25 Nov 2013 09:57:45 -0800 (PST)
In-Reply-To: <20131125174945.GA3847@sandbox-ub>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238325>

Heiko, yeah sure see what you mean. Changing existing behavior is pretty PITA.

Just one more question for now, are you referencing to the patch "[RFC
PATCH] disable complete ignorance of submodules for index <-> HEAD
diff"? Coz i tested it and seems it doesn't change behavior of
add/commit.

Also, i'm around to test the all patches which are related on submodules :)

On Mon, Nov 25, 2013 at 11:49 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> On Mon, Nov 25, 2013 at 03:02:51PM +0600, Sergey Sharybin wrote:
>> Am i right the intention is to make it so `git add .` and `git commit
>> .` doesn't include changes to submodule hash unless -f argument is
>> provided?
>
> Yes thats the goal. My patch currently only disables it when ignore is
> set to all. I will add another patch that implements the -f and
> --submodule-ignore option to both of them so the user has an easy way to
> bypass that. But having said that we changing existing behavior here so
> we have to investigate carefully whether we are not breaking peoples
> expectations (and script). That also applies to the other patch
> that enables showing them in diff and friends again.
>
> Cheers Heiko



-- 
With best regards, Sergey Sharybin
