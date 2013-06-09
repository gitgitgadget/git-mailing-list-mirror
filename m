From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sat, 8 Jun 2013 22:34:14 -0500
Message-ID: <CAMP44s0n0=boPM0ZYtAHyvDfu45eyU9--_bR5JNobbT9AKM1=Q@mail.gmail.com>
References: <1370643409-3431-3-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8AMMCWSFC6EUHAgZdDA7E1kSPE3ZO6qGvS+WGji-di=Rw@mail.gmail.com>
	<CAMP44s29GiGJq3wyXAzJNo0FJY+Vbgd18bpBJMYQ47h-3M6sWA@mail.gmail.com>
	<CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
	<20130608164902.GA3109@elie.Belkin>
	<CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
	<20130608173447.GA4381@elie.Belkin>
	<CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com>
	<20130609014049.GA10375@google.com>
	<CAMP44s3CGHVLnkUxo=PR_b+_dTuaz5rwems_pd9GE1_vcEaYRA@mail.gmail.com>
	<20130609032143.GA18678@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 05:34:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlWOf-00054z-K7
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 05:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639Ab3FIDeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 23:34:17 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:34851 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432Ab3FIDeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 23:34:16 -0400
Received: by mail-la0-f42.google.com with SMTP id eb20so4801530lab.1
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 20:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=70xP0Cg2ybciFeZLV/u+Ce9SDEK9gTJcTpncW4/rOYU=;
        b=HHbq+kYCpmBwhc22YL6jodLwS18KwXmLWfV7ngm3CuEh5DvII+siWcg9W9K5aLNDBK
         6qzAE4hIFiR6vM3ANTuDu543a4JVwSzjsTpbp2kEdDLsvDyOaVxFhfM3uEMrcPnVeLhJ
         bLvrm59QED/IfVssH9/oJ9MAOJaWPAVcrLuxiQzOGN4CaJY+YcAs03lTN3KQ2MRBr1ST
         IVpuw1yBPAQJCuL8B7A03OMUAaHDiBOHio6yBhJqZqncybhY33mih/uWOCwqEBd5qysG
         y+zZ3HiiJVlE79AeoFpdvORFYMpIjbdOQ5qQXIcNUxw8veBtGUQcRgc8IzHOwUvN6L41
         wo9w==
X-Received: by 10.112.219.133 with SMTP id po5mr3894447lbc.80.1370748854535;
 Sat, 08 Jun 2013 20:34:14 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sat, 8 Jun 2013 20:34:14 -0700 (PDT)
In-Reply-To: <20130609032143.GA18678@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226878>

On Sat, Jun 8, 2013 at 10:21 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Felipe Contreras wrote:
>
>> A collegial work environment is overrated, and proof of that the Linux
>> kernel, where honest and straight talk is the bread and butter of the
>> mailing list.
>
> An aside, since it doesn't bear too much on the topic at hand:
>
> For what it's worth, in my experience the people working on the kernel
> are quite sensible and friendly on-list.

They are professional. When they need to be straight-forward, they
are, even if that hurts the feelings of the colleagues.

> Probably you are referring to some high-profile cases of flames,

No, I'm not. Heated discussions happen all the time, specially when
the issue at hand is important.

> I do not think the way the list works normally is a
> counterexample to common decency being useful.

Of course you wouldn't, but you are purposely ignoring the facts.

The Linux kernel mailing lists concentrates on *the code*; he who
writes the code has a voice, he who only has words doesn't. Personal
beefs are not relevant. When there's something horribly wrong with the
code, so are the responses.

> So no, I don't find "But they are mean, and look how well they are
> doing!" to be a compelling argument here.

Because you dismiss the premise a priori.

-- 
Felipe Contreras
