From: =?GB2312?B?0Oy1zw==?= <xudifsd@gmail.com>
Subject: Re: Why usage function exit with code 129?
Date: Fri, 6 Jan 2012 16:18:23 +0800
Message-ID: <CAMocUqR5NtLJTzEDXN6Os=b0w1aP6BMb6uphNJgZWKFT0dJy-Q@mail.gmail.com>
References: <CAMocUqSbiO2XC3PUEciyV3HxgqDPW_rTW-hYH4P=C=BFCSrQMQ@mail.gmail.com>
	<CACsJy8Amo_9-9oCgHbwOZvTaNOV3Jj6wLCTU7nZT5LeA55=NEA@mail.gmail.com>
	<CAMocUqSmes+x_tkP6V0OM5rQ5wDGmMm=Q2MFBPhz6Qvzz_SOTg@mail.gmail.com>
	<CACsJy8D8uKGhtg4zjbHsJCGmqjTwodzFmAZ5w=aUx9CdadVAfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?GB2312?B?R2l0INPKvP7B0LHt?= <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 06 09:18:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rj50R-0000zn-9g
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 09:18:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445Ab2AFIS0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Jan 2012 03:18:26 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:37694 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752468Ab2AFISZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jan 2012 03:18:25 -0500
Received: by bkcjm19 with SMTP id jm19so258028bkc.19
        for <git@vger.kernel.org>; Fri, 06 Jan 2012 00:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=POgyw6m7KLa0EYga9pjvevfe4FlyLbHLWabslLPyHkk=;
        b=pwCaN3qQBs0dSWBdcmW1QfzynkScy9Em/SWHg3VbRzVPAKRmjDiJAeln6ya2dehxoK
         Fri3+LLhdd4Ro4nLmp/A+IXsHgENQ77gXNsdo4MSHDyoPauiWJOzbSnqwMDuXPltSBz9
         dTv6Wzm6lJvzrq7O5Wk7xsbjB+lBBjRYs134s=
Received: by 10.204.10.65 with SMTP id o1mr2161855bko.19.1325837903414; Fri,
 06 Jan 2012 00:18:23 -0800 (PST)
Received: by 10.204.200.74 with HTTP; Fri, 6 Jan 2012 00:18:23 -0800 (PST)
In-Reply-To: <CACsJy8D8uKGhtg4zjbHsJCGmqjTwodzFmAZ5w=aUx9CdadVAfw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188020>

=D4=DA 2012=C4=EA1=D4=C26=C8=D5 =CF=C2=CE=E74:11=A3=ACNguyen Thai Ngoc =
Duy <pclouds@gmail.com> =D0=B4=B5=C0=A3=BA
> 2012/1/6 =D0=EC=B5=CF <xudifsd@gmail.com>:
>>>> [1] http://tldp.org/LDP/abs/html/exitcodes.html
>>>
>>> No it does not mean terminated by signals.
>>> --
>> In that case, why not just use another code instead of the code that
>> leads misunderstanding? I mean, as far as I know, exit code between
>> 129 and 255 are used to indicate the program terminated by signal. S=
o
>> that usage function can only exit with code between 1 and 127. Am I
>> wrong?
>
> Because that code has been there too long (since 2005) any probably
> all git commands, including plumbing ones, rely on it. Changing it no=
w
> may break existing scripts.
> --
> Duy

Ok, that sounds logical.
