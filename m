From: Simon <turner25@gmail.com>
Subject: Re: git as backup and file sync system
Date: Fri, 2 Apr 2010 17:20:20 -0400
Message-ID: <v2l5f14cf5e1004021420mcd67bb5bh23730ae53f2aa8c6@mail.gmail.com>
References: <m2q5f14cf5e1004021216y60797d29j1f63092435998823@mail.gmail.com>
	 <k2mfabb9a1e1004021235xc75e25a8na941c1754fd543c@mail.gmail.com>
	 <j2v32541b131004021249s738a06cfq2804b97f798ac482@mail.gmail.com>
Reply-To: turner25@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 02 23:20:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxoI0-0002P1-W4
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 23:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754705Ab0DBVUY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Apr 2010 17:20:24 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:51436 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754546Ab0DBVUX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Apr 2010 17:20:23 -0400
Received: by gwb19 with SMTP id 19so348398gwb.19
        for <git@vger.kernel.org>; Fri, 02 Apr 2010 14:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oe3Rd/b/PwYWOI96/HqDACg5kr2fzZYGrXCjIhJrFE4=;
        b=kc39n8DUTPl91+HsG1DdrsVT72evVJ5UZV02NuEStFrAjZ7OVaqx9mdvXf+o9C6kEc
         4LoeBSc7YgTYy/m/RZ9VnSWlLNTWq8vQI0RSsmOa8L0am3AtXav/TdjVIrlMDklZpDPu
         4ahtlbMghF6z8SeQLuNNtsBhZn1Cr17A7s0F0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=HFMNf3asZJaTMhEnKszhYvt2GUxwNv2xbqqx/Lgv+1EnefgHasNj7DGbXmXcz5CK+s
         JkssAv5SOaXBdIrrfKJJd9fx7cDuRtooTha7Yfx1IzB3MyjiptddQRC3eLT97jKgEbzl
         gZkOCDekodIORUKtslEXvZYKUlFiZ3sHM50cM=
Received: by 10.100.143.5 with HTTP; Fri, 2 Apr 2010 14:20:20 -0700 (PDT)
In-Reply-To: <j2v32541b131004021249s738a06cfq2804b97f798ac482@mail.gmail.com>
Received: by 10.101.152.13 with SMTP id e13mr7046466ano.0.1270243220802; Fri, 
	02 Apr 2010 14:20:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143851>

Hey thanks guys!

This looks cool, I mean, I don't really care that it doesn't support
everything topshape, I'm sure I can manage something with this.  I'll
clearly look into it.  What I like most is that development on it is
alive now. =3D)

Simon

On Fri, Apr 2, 2010 at 3:49 PM, Avery Pennarun <apenwarr@gmail.com> wro=
te:
> On Fri, Apr 2, 2010 at 3:35 PM, Sverre Rabbelier <srabbelier@gmail.co=
m> wrote:
>> On Fri, Apr 2, 2010 at 13:16, Simon <turner25@gmail.com> wrote:
>>> =A0I'm not sure if this post will be very welcome, but I'd like you=
r
>>> feedback or suggestions. =A0I've been reading Jon Loeliger's book a=
bout
>>> git and I've understood many many things. =A0I'm interested in usin=
g git
>>> as a backup and sync system between computers.
>>
>> You might want to look into 'bup', [0] designed specifically for tha=
t
>> purpose. It seems like introduction post about it on apenwarr.ca is
>> down though [1].
>>
>> [0] http://github.com/apenwarr/bup
>> [1] http://apenwarr.ca/log/?m=3D201001#04
>
> Yeah, sorry, apenwarr.ca is flakey at the best of times. =A0It takes =
after me :)
>
> Disclaimer: bup does lots of neat backup-related stuff, but it doesn'=
t
> *yet* support detailed metadata. =A0We're working on it:
> http://groups.google.com/group/bup-list/browse_thread/thread/e899a579=
a6f7ae55
>
> If you're only storing a relatively small number of files (say /etc),
> then something like etckeeper might do what you want. =A0Or more
> generally, metastore (which etckeeper uses):
> http://david.hardeman.nu/software.php
>
> Unfortunately neither git nor metastore can handle the high data
> volumes that bup is aimed at (ie. your entire filesystem, including
> huge files), which is why bup exists. =A0Give it a few weeks and we
> should have some decent metadata handling in place though.
>
> Have fun,
>
> Avery
>
