From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Sun, 29 Nov 2009 14:13:17 +0200
Message-ID: <94a0d4530911290413vbd71849u62ef01ed76bad4c0@mail.gmail.com>
References: <20091125210034.GC18487@coredump.intra.peff.net>
	 <885649360911251412n3e566c8fu536b361b993f2ac6@mail.gmail.com>
	 <20091125222037.GA2861@coredump.intra.peff.net>
	 <885649360911260956p58c54a54rd887102c9adedcc9@mail.gmail.com>
	 <20091127062013.GA20844@coredump.intra.peff.net>
	 <alpine.DEB.1.00.0911271027510.4521@intel-tinevez-2-302>
	 <20091127095914.GA4865@sigill.intra.peff.net>
	 <alpine.DEB.1.00.0911271144230.4521@intel-tinevez-2-302>
	 <20091127180235.GA26633@coredump.intra.peff.net>
	 <alpine.DEB.1.00.0911272102430.4521@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, James Pickens <jepicken@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 29 13:13:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEiea-0002IM-MO
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 13:13:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753485AbZK2MNN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Nov 2009 07:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752500AbZK2MNN
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 07:13:13 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:64563 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937AbZK2MNL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Nov 2009 07:13:11 -0500
Received: by iwn1 with SMTP id 1so1654905iwn.33
        for <git@vger.kernel.org>; Sun, 29 Nov 2009 04:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3JriV/ehD7dH5BNetSPafkYziQig3N0sLLIouUmE5HE=;
        b=gFQK/C6fYe+E0A2ArT3wUmk87ok8QAXpdkBoUN0Pl4hC9O+wbDgqH4NAYy/pBGZfAb
         cq0T1o6YCX8GJ9BoMZvyzUCS/Z1at3dCGcOonxjheVM4p+qhrgb2i8iBRuF0PkACI3JG
         PSmLvvaYYIpioe7GrLxUtt8sdxpeZKdOa4X2E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xMIwfgQZk06lr5VLZrUIESdV2EGMYrdBRixSYJAICdQmfGFxhgMDADcNkt7e/eC3Vl
         BY+ETygBjA43X3+tkp2trT7lN2p/uKMjOG+MaNmzDkR+cpQYLsevxKVduPyaqtT10yTl
         QzC0O6xD3DhJhQ8AaYxjjaOB+D3bttt1oxedQ=
Received: by 10.231.42.150 with SMTP id s22mr1356103ibe.22.1259496797774; Sun, 
	29 Nov 2009 04:13:17 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0911272102430.4521@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134014>

On Fri, Nov 27, 2009 at 10:07 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Fri, 27 Nov 2009, Jeff King wrote:
>> Yes, as a matter of fact, I do work on 10 different computers. I'm s=
orry
>> that you find managing your configuration so challenging. But if you
>> don't use the configuration variable, then your own personal setup i=
s
>> totally irrelevant.
>
> As I just demonstrated, this is a false statement.

Yes, defaults are important in UI.

>> If your argument is that this lack of consistency will irritate user=
s,
>> you need to show that:
>>
>> =C2=A0 1. There are users who switch between a large number of setup=
s, but
>> =C2=A0 =C2=A0 =C2=A0will not apply config consistently.
>
> This is a strawman, and you should be ashamed to put it here. =C2=A0J=
ust
> because nobody does what you actively encourage does not mean that th=
e
> encouraged procedure is good, or for that matter, helps anybody but y=
ou.

Not to mention that it's completely irrelevant. The fact that all
users apply their configurations consistently through their setups, or
not, doesn't make a default preference better or worst.

If the argument is that default preferences are not relevant enough,
then step aside and let the people that care about default preferences
to discuss.

>> And the GitTogether had a "users complain about git, and we try to
>> listen" session.
>
> Oh, that makes me so happy. =C2=A0<sarcasm>Soooo happy</sarcasm>. =C2=
=A0So it was an
> ivory tower meeting, once again?

This is very typical on many open source projects. I think the
benevolent dictator model works pretty good on low-level stuff, but on
UI I think a democratic model works better.

I've been thinking on setting up a pseudo-project on SourceForge and
setup an IdeaTorrent, that way users can generate and organize ideas
so that developers can have meaningful conversations with users:
http://brainstorm.ubuntu.com/

What do you think?

--=20
=46elipe Contreras
