From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH v4 06/45] Move sequencer to builtin
Date: Sun, 9 Jun 2013 19:02:23 +0200
Message-ID: <CALWbr2z_VArUi_4iKgdUgmUTA0hQ0EDF9ZuMs4RdEEZfnFOxMw@mail.gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
	<1370796057-25312-7-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:02:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulj0e-00020v-OC
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:02:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143Ab3FIRCY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 13:02:24 -0400
Received: from mail-qe0-f46.google.com ([209.85.128.46]:37873 "EHLO
	mail-qe0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043Ab3FIRCX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:02:23 -0400
Received: by mail-qe0-f46.google.com with SMTP id nd7so1114490qeb.19
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 10:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ERmoiPJjv/GZWHFhLMFTvnIG5J2g+sXHxLPDDvKN5ek=;
        b=rO1DOG9AUX5U/SKJnjJy+2BJUCUSeaOWrKKrfB81JBKpx79eWrTmPWfs2dLwYws4WS
         M1f42mAD7xqVH6xER02ooUfGsqk2Gj2KzMD+AZuPV26oyccZD9juTxAj+QcRGuBJWSlj
         dZful5zSuDwdmfiuP4hPd+2jPGFui4rDbEQcYXFerqTZQ45TjJM6w/TKaIKwJchFY0mK
         QrpvnsEfCPEYInwaxW94vMA5Tp13CxiEx8uq2fTY2JW2e+HTAsw9MhNjkr//GzffKEAP
         aW71F/G/dt8oH6WVZtYjrKC2v8CX+RXWdbvGy4ItfQEwQFsLwXqczpsNGjq08VMWV+6i
         OMTw==
X-Received: by 10.49.24.52 with SMTP id r20mr7337267qef.54.1370797343264; Sun,
 09 Jun 2013 10:02:23 -0700 (PDT)
Received: by 10.49.108.105 with HTTP; Sun, 9 Jun 2013 10:02:23 -0700 (PDT)
In-Reply-To: <1370796057-25312-7-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227020>

On Sun, Jun 9, 2013 at 6:40 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> This code is only useful for cherry-pick and revert built-ins, nothing
> else, so let's make it a builtin object.
>
> The first source file that doesn't generate a git-foo builtin, but does
> go into the builtin library. Hopefully the first of many to clean
> libgit.a.

Hey Felipe,
I don't understand why the code doesn't belong to libgit.a, and how
it's gonna make it more "clean". I can see that it is needed only by
revert and cherry-pick, but is that the only reason ?

Thanks for taking the time to enlighten me :)
