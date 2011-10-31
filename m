From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Mon, 31 Oct 2011 15:52:26 -0700
Message-ID: <CA+55aFwnVZ-mK3FChvFn778Z-cT107f4v-h0CDmwkP88=Z9aHA@mail.gmail.com>
References: <20111026202235.GA20928@havoc.gtf.org> <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <1320049150.8283.19.camel@dabdike> <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org> <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <4EAF1F40.3030907@zytor.com> <CA+55aFxprv9JR4gtt_UDXheHR5G8PrUA3-Mj0CPsU6E5EzNYeg@mail.gmail.com>
 <4EAF2245.90308@zytor.com> <7vzkggok6u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Mon Oct 31 23:52:58 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RL0iv-0002Xr-Pi
	for glk-linux-kernel-3@lo.gmane.org; Mon, 31 Oct 2011 23:52:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934766Ab1JaWwu (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 31 Oct 2011 18:52:50 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37240 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934723Ab1JaWws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2011 18:52:48 -0400
Received: by wwi36 with SMTP id 36so2245383wwi.1
        for <multiple recipients>; Mon, 31 Oct 2011 15:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=8VfQHEQhArMXcTcCmpi3AT0Lz66Ry6K4HSOt/u++kSM=;
        b=EqvcG1eB+56I1NJRR2imndNz3aFTmDmH4cF6960lduxsymses/mJ1voE75nRyXetz5
         hetCztLuwnYblbzQO9eVWEkUfv6YCkv1T6T5/b/i/hjBEiRPfC/Ie7/QMNzBDa8VgppE
         7Kvrunbj5SixFH3HePQ7td1Bpkg0JyeCYax6M=
Received: by 10.216.229.162 with SMTP id h34mr2880254weq.82.1320101567200;
 Mon, 31 Oct 2011 15:52:47 -0700 (PDT)
Received: by 10.216.166.3 with HTTP; Mon, 31 Oct 2011 15:52:26 -0700 (PDT)
In-Reply-To: <7vzkggok6u.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: oaiCNg1GKrSGGCYtI5s9YyRj-Fg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184539>

On Mon, Oct 31, 2011 at 3:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> So nobody is worried about this (quoting from my earlier message)?

No, because you haven't been reading what we write.

The tag is useless.

The information *in* the tag is not. But it shouldn't be saved in the
tag (or note, or whatever). Because that's just an annoying place for
it to be, with no upside.

Save it in the commit we generate. BAM! Useful, readable, permanent,
and independently verifiable.

And the advantage is that we can make that same mechanism add
"maintainer notes" to the merge message too. Right now some
maintainers write good notes about what the merge will bring in, but
they are basically lost, because git is so good at merging and doesn't
even stop to ask people to edit the merge message.

                    Linus
