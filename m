From: Albert Dvornik <dvornik+git@gmail.com>
Subject: Re: [msysGit] Re: [PATCH] compat: Add another rudimentary poll() 
	emulation
Date: Thu, 27 May 2010 09:43:32 -0400
Message-ID: <AANLkTikU4ZzX4yYVSCOuLxjp56cmmolHk1u0U-fhfTtN@mail.gmail.com>
References: <1274948384-167-1-git-send-email-abcd@gentoo.org>
	<1274948384-167-2-git-send-email-abcd@gentoo.org>
	<20100527101043.GA4390@progeny.tock>
	<AANLkTikYa2vq4PrKrO2QIkHVxYqbhUZRw42kQq875FNT@mail.gmail.com>
	<AANLkTikfaWVEPkHBRF8WHNWmyXIH9f7wRju1wSRC_lwm@mail.gmail.com>
	<AANLkTinXwM1fem6E3RgnLW9vqLD1fV7JvaQnxzZVRakA@mail.gmail.com>
	<AANLkTinX8nK68rZtN5dwJ-fGQm4gR2G84xo9raxb4vLY@mail.gmail.com>
	<AANLkTiliJFXWKXnksQryvAivadrkTUeZ1Wu7FkUGm2YZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marko Kreen <markokr@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jonathan Callen <abcd@gentoo.org>, git@vger.kernel.org,
	mduft@gentoo.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Sixt <j6t@kdbg.org>,
	msysGit <msysgit@googlegroups.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu May 27 15:43:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHdN5-00083j-Kx
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 15:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753762Ab0E0Nnf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 May 2010 09:43:35 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:44204 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527Ab0E0Nne convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 May 2010 09:43:34 -0400
Received: by qyk13 with SMTP id 13so10954515qyk.1
        for <git@vger.kernel.org>; Thu, 27 May 2010 06:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=+YE/4EUnkkqAKUvdkXq7yhMM33S2o1CHO5Oz7k4iRGo=;
        b=rjjJwlBze1TVU/AdGyvrxu0p97jAY9lYiJXVocr5xRtAblsgMe4+bqCNzvkSt6+z7i
         KLtHuwIy5Z4uTtMEO2mBPsiIXkCGdfb05hgsfwgIUnznDdrmo4OGoX+SVYO+opr5iTEB
         NkBPIA+BAVBQ/my5eH1CmSo/gLSv8mv10ofdc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=DPgBw0v5l0DjTRNB/hNleRR7jLKN/tBkfpqJjZsK/rKVHgTpeBgR+f7eBOXr8BFbYL
         Uafidm8K3BPMQWl0bn+5tHCW7PUmPmhF46XNd81VNSmCx8vns+ILB+u+qBwII2iKv3/A
         CHpLxpaJ9ubqHfQ2o332tM0JsJh8G4axoQTog=
Received: by 10.224.79.102 with SMTP id o38mr5683206qak.358.1274967812756; 
	Thu, 27 May 2010 06:43:32 -0700 (PDT)
Received: by 10.229.74.193 with HTTP; Thu, 27 May 2010 06:43:32 -0700 (PDT)
In-Reply-To: <AANLkTiliJFXWKXnksQryvAivadrkTUeZ1Wu7FkUGm2YZ@mail.gmail.com>
X-Google-Sender-Auth: pNq1kO9ZQnY_EWVG9dKZuvDVqC8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147855>

On Thu, May 27, 2010 at 8:57 AM, Erik Faye-Lund
<kusmabite@googlemail.com> wrote:
> On Thu, May 27, 2010 at 2:36 PM, Marko Kreen <markokr@gmail.com> wrot=
e:
[...]
>> Hm, good catch. =A0Seems such compat poll() cannot be done without
>> OS-specific hacks.
>>
>
> Perhaps getrlimit() could overridden to return FD_SETSIZE for both th=
e
> soft and hard limit when asking about RLIMIT_NOFILE? In such cases,
> anyone who passes nfds above FD_SETSIZE hasn't consulted
> RLIMIT_NOFILE, and should be outside the standard. But your point
> might have been about a limitless poll()-implementation, like the cod=
e
> you linked tried to achieve. In that context, no. I doubt it's
> possible to do in a robust fashion.

This is getting far off-topic, but I do think it's possible to do in a
robust fashion if you are willing to sacrifice some performance [i.e.
we should not consider this for Git =3D) ], by creating multiple fd_set
structures and only shoving up to FD_SETSIZE descriptors into each.
Cycling between the structures would cause some extra latency and a
LOT more code complexity, but it should work.

--bert
