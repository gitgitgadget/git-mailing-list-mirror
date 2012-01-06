From: =?GB2312?B?0Oy1zw==?= <xudifsd@gmail.com>
Subject: Re: Why usage function exit with code 129?
Date: Fri, 6 Jan 2012 16:06:09 +0800
Message-ID: <CAMocUqSmes+x_tkP6V0OM5rQ5wDGmMm=Q2MFBPhz6Qvzz_SOTg@mail.gmail.com>
References: <CAMocUqSbiO2XC3PUEciyV3HxgqDPW_rTW-hYH4P=C=BFCSrQMQ@mail.gmail.com>
	<CACsJy8Amo_9-9oCgHbwOZvTaNOV3Jj6wLCTU7nZT5LeA55=NEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?GB2312?B?R2l0INPKvP7B0LHt?= <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 06 09:06:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rj4oa-00052U-9p
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 09:06:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754602Ab2AFIGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 03:06:12 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33025 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997Ab2AFIGL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 03:06:11 -0500
Received: by bkcjm19 with SMTP id jm19so255934bkc.19
        for <git@vger.kernel.org>; Fri, 06 Jan 2012 00:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Muk4KJRzwmXEVN6BPi9MqhW7PSMPV7VKRHl5LTXwJng=;
        b=xmBGiyrhvYjNYKvAj/vZeJogFtUt4+L3pjYyOP4D0+qr1y3Das4QNme8ueGGHmgX7z
         AdoH5jNrQ5acDRqB6iSXNNt8Ay5u8wIjQp7BygzI39pudFzg1VhCErWekDAx3oALUnkg
         Y13F9yXjF3f7L6qOMCHf3FcL9qIX/jSZjp17I=
Received: by 10.205.42.130 with SMTP id ty2mr2130145bkb.55.1325837169854; Fri,
 06 Jan 2012 00:06:09 -0800 (PST)
Received: by 10.204.200.74 with HTTP; Fri, 6 Jan 2012 00:06:09 -0800 (PST)
In-Reply-To: <CACsJy8Amo_9-9oCgHbwOZvTaNOV3Jj6wLCTU7nZT5LeA55=NEA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188016>

>> [1] http://tldp.org/LDP/abs/html/exitcodes.html
>
> No it does not mean terminated by signals.
> --
In that case, why not just use another code instead of the code that
leads misunderstanding? I mean, as far as I know, exit code between
129 and 255 are used to indicate the program terminated by signal. So
that usage function can only exit with code between 1 and 127. Am I
wrong?
