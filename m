From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sun, 9 Jun 2013 13:01:30 -0500
Message-ID: <CAMP44s35w_ysvd5c8oANF8YpWvsquY50bUjSfjOxtujdpgBCPQ@mail.gmail.com>
References: <CAMP44s29GiGJq3wyXAzJNo0FJY+Vbgd18bpBJMYQ47h-3M6sWA@mail.gmail.com>
	<CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
	<20130608164902.GA3109@elie.Belkin>
	<CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
	<20130608173447.GA4381@elie.Belkin>
	<CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com>
	<20130609014049.GA10375@google.com>
	<CAMP44s3CGHVLnkUxo=PR_b+_dTuaz5rwems_pd9GE1_vcEaYRA@mail.gmail.com>
	<20130609052624.GB561@sigill.intra.peff.net>
	<CAMP44s3NhNUuCvW37UaMo9KbHHxZqBE8S15h845vtRi89Bu6WA@mail.gmail.com>
	<20130609174049.GA1039@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 09 20:01:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uljvu-0001zV-3D
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 20:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203Ab3FISBe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 14:01:34 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:40035 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002Ab3FISBd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jun 2013 14:01:33 -0400
Received: by mail-lb0-f181.google.com with SMTP id w10so2897621lbi.26
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 11:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=9mIP/hh4nZ9uxuSsz9uLwtbkLlIKfPs/7pTp7M4xn1w=;
        b=Kmny3xaoLE6a8NvtVDI4o1nV/laUxJRoNn/r1afm/pUIySTDdy7rSSLvv7nNFzy19M
         xCZ0/gCOEHCNxKwpU3Kjfsv8w9qAM1OmBTB2VTaCAIszEsHVMWXIRzYVX60I7xDBES95
         5RjzdJTLJ5neccgsTuFkKC/qIWFI9mTjf7Mo35L/m1MFy8se/Unpo1Ex7p14iE1MiStS
         D5UkABIfS+MXa2I63rqJlY+EilHwpSVpLbNL8B19wI8zfLwT75c7406+Lo8gKY8JtZGf
         5z6fdu103l8jwxXsPCtkZ82hEMYsjNJY7bE11htNKXABRBPeAUu50jPFAc313f32XdJT
         SzgQ==
X-Received: by 10.152.43.136 with SMTP id w8mr3322057lal.63.1370800890418;
 Sun, 09 Jun 2013 11:01:30 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 11:01:30 -0700 (PDT)
In-Reply-To: <20130609174049.GA1039@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227073>

On Sun, Jun 9, 2013 at 12:40 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Jun 09, 2013 at 07:15:45AM -0500, Felipe Contreras wrote:
>
>> > Sorry, but I don't agree, and I want to publicly state my opinion =
so
>> > that Jonathan (and other bystanders on the list) knows that he is =
not
>> > alone in his opinions.
>>
>> You don't agree that 1) a collegial work environment is overrated, 2=
)
>> that the Linux kernel doesn't put an emphasis on being collegial, or
>> 3) that it's the most successful software project in history?
>
> Point 1.

Good, so we agree that a project doesn't need a collegial work
environment to be extremely and amazingly successful. In fact, any
rational person would keep an open mind to the fact that perhaps it
actually _helps_ to not have such environment, based on the evidence.

>> Go back to my 261 commits, show me one that is "unmindful of technic=
al details".
>
> I do not have an interest in cataloguing past conflicts I and others
> have had with you; the list archive has done so.

No. There is no such catalog. You made a claim, it's not backed by
evidence, merely by your subjective experience. And memory is a pretty
bad indicator of reality.

"The first principle is that you must not fool yourself=E2=80=94and you=
 are
the easiest person to fool" -- Richard Feynman

--=20
=46elipe Contreras
