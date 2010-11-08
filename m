From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: history missing
Date: Mon, 8 Nov 2010 06:56:51 -0500
Message-ID: <AANLkTi=rT0S1H8pFt9d+FYVme4fjNNzY6O6evuBwo-ZB@mail.gmail.com>
References: <AANLkTikFB5HNOmg0iTdjHxtrhU9vdua5O8btgFzpg-2F@mail.gmail.com>
	<20101108090230.GC2430@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Vitaliy Semochkin <vitaliy.se@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 12:57:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFQLK-0002z0-PS
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 12:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303Ab0KHL4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 06:56:53 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48915 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222Ab0KHL4w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 06:56:52 -0500
Received: by vws13 with SMTP id 13so1659219vws.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 03:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=qqGFWSJz2WiefhFCMd0qBo++H0CbsJMorTe6w6Vu9/8=;
        b=ji35x8hMLEF2ZvdJTMpmQGt1Budok9GUKDrLVlwR6jd6m2TmayGk+Lc68QJfqA5/ru
         DA8pBpgNZX+Tzka00qJktZo8AM/tizJCY9kfiH4gVcKlzETZPWU1uzulBa/GESUSGAT1
         n8fOOrBn9mVfGLncWhiUI7REqqsWrijJmnrlo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=WEBtg3Fd7l12W412uQ1ZHMtWAUH2QMReGe+rX625fEkoYX+ttBifkyWY4ZYBQbpSt+
         wN38lFX/aYJVJFdxzsJaZiHpR1GgW6er2zVfLHY2XeOW9mvZy4UD44I6fz8V4eth0Z1O
         nq6kzDoRDifAhglNn0K/5RRKB2pLPX2v+/Mv0=
Received: by 10.224.76.85 with SMTP id b21mr3669750qak.340.1289217411541; Mon,
 08 Nov 2010 03:56:51 -0800 (PST)
Received: by 10.224.20.82 with HTTP; Mon, 8 Nov 2010 03:56:51 -0800 (PST)
In-Reply-To: <20101108090230.GC2430@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160929>

On Mon, Nov 8, 2010 at 4:02 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi Vitaliy,
>
> Vitaliy Semochkin wrote:
>
>> I cloned a remote repository
>> to check recent changes in origin/master I do:
>> git fetch origin master
>> git log origin master
>>
>> recently I found out that log doesn't show recent commits
>
> Yes, this can be confusing.

I agree and I believe this has come up a lot of times before. I talked
to Jeff and Junio about this at GitTogether and Jeff said he has a patch
for it that he would try to get up to date in a while. (Thanks, Jeff!)
