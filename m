From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [RFD] Deepen the git directory structure a bit.
Date: Thu, 18 Feb 2010 16:50:14 -0500
Message-ID: <32541b131002181350p245b7fbdw4398501b65835cac@mail.gmail.com>
References: <alpine.LFD.2.00.1002181010590.4141@localhost.localdomain> 
	<7vbpfm9tst.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 22:50:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiEGe-0000pX-U3
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 22:50:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758573Ab0BRVuf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Feb 2010 16:50:35 -0500
Received: from mail-yx0-f180.google.com ([209.85.210.180]:64944 "EHLO
	mail-yx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950Ab0BRVuf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Feb 2010 16:50:35 -0500
Received: by yxe10 with SMTP id 10so1556219yxe.33
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 13:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=iWPfTaqyqSxUax8LOm7BDzq26haD3d0kVOHC/Pp8k3M=;
        b=ZvxKzG1p1InN6Dg5eoK/GQ8A5YGLyvI7oUHJZyC7J1CToZyq3SAyTTT0hi6iljpC86
         QvMRqPplk+MR2iv/9VXcXAvnRZqwBc9DvQDU2zIP8I0BY1tEJqgeT18PDg15rWinrypC
         Avjm+QW/9clTvMuAPECC0v+ycSDGlh79IkpRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=de8l/3HfxHuqnhst9S2ftN4xrkaX89WUfb9Aci1FuzU/tNK8qbrNDeZ9ZNIEzqaKlx
         8/McTsZkbZsy3Hlro76i6oPbPQQUKb0wUZ9vjTNVCPTFy6ftZy6o3PCAeizxXG/n/oIc
         djLJs5vh0DUR1YlmTMkigmkTiR1YEZXi7e2Xo=
Received: by 10.150.55.17 with SMTP id d17mr373726yba.155.1266529834172; Thu, 
	18 Feb 2010 13:50:34 -0800 (PST)
In-Reply-To: <7vbpfm9tst.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140383>

On Thu, Feb 18, 2010 at 3:24 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>> I think this coul probably be done differently (I'm not proud of tha=
t ugly
>> '-I. -Ibuiltin' addition to the CFLAGS, for example), and I think th=
ere
>> are _other_ things we could also try to do to move files into
>> subdirectories, but this was a fairly easy thing to basically script=
=2E
>>
>> What do people think?
>
> I personally like the general direction you are going. =A0One minor d=
etail I
> do not know about is whether to move "builtin.h" with others, or leav=
e it
> at the top.

If you don't move it, then it'll continue to interfere with
autocompletion.  Though maybe that's not a good enough reason :)

Have fun,

Avery
