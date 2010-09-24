From: Tor Arntsen <tor@spacetec.no>
Subject: Re: Let's bump the minimum Perl version to 5.8
Date: Fri, 24 Sep 2010 16:08:36 +0200
Message-ID: <AANLkTimNGZom6FfKivg=QNmovz=xf656XHbXCmsjfrxD@mail.gmail.com>
References: <AANLkTikp0mkFHYCdgqThfoFr3VkVECDmW6qE3+DSSHaq@mail.gmail.com>
	<AANLkTinRcGa3r_=D87G-4-qqdsFL9CKnawD=DCnRQ+7v@mail.gmail.com>
	<AANLkTim8aPoOkzzf4c0JHbBDVa4zJY2xM3v9fXQ-px=V@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tait <git.git@t41t.com>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 16:11:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz8zb-0008S6-IV
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 16:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211Ab0IXOIi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Sep 2010 10:08:38 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:35257 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932187Ab0IXOIi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 10:08:38 -0400
Received: by qwh6 with SMTP id 6so1848643qwh.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 07:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=J88nF7QYsw5GmJouPME/vhdDIuSUs5T0h28hpMUbq9I=;
        b=Zt6QuIjpOvlwJ6sSJ3Xg2T2JPG6NfFa1uliuJjVfTJC/5I29ZZDfnRbAdPBHcx6g/e
         bQGJ1cUSR7Fy7hdckH6CtNUrkDywY0E3N6KX7CPlo4ZrtaFwkranfEpjOb3ifdt7ZF7M
         NDCtujk26qwaFBcKvzX5YavVKCStMg3q7uv4M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=qMPWfsQEtxOwVfOxXjOcCMJIYBuT2wbmPPoZ4gV5c5ACqhdj90L8P0Iuak40ad7dpQ
         WXHyU2ZR8RJOLtOZnNntDZFSSXdK8sTNy4PCOVUXiQ43JIjci0K5PjK3V4f54aK6EWyR
         DqrAzavWTjNPq6GGQQqRrOd6FmPPHlsTs+Pu0=
Received: by 10.229.141.75 with SMTP id l11mr2576497qcu.154.1285337317237;
 Fri, 24 Sep 2010 07:08:37 -0700 (PDT)
Received: by 10.229.62.98 with HTTP; Fri, 24 Sep 2010 07:08:36 -0700 (PDT)
In-Reply-To: <AANLkTim8aPoOkzzf4c0JHbBDVa4zJY2xM3v9fXQ-px=V@mail.gmail.com>
X-Google-Sender-Auth: EgSs_Y51oGwVWRir70nHDsvoC48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156991>

On Fri, Sep 24, 2010 at 15:32, =C6var Arnfj=F6r=F0 Bjarmason <avarab@gm=
ail.com> wrote:
> On Fri, Sep 24, 2010 at 13:08, Tor Arntsen <tor@spacetec.no> wrote:
>> On Fri, Sep 24, 2010 at 14:56, =C6var Arnfj=F6r=F0 Bjarmason <avarab=
@gmail.com> wrote:
>>
>>> However, I'd like to shift the discussion a bit: Do we want to supp=
ort
>>> the 5.6 line *at all* anymore? I don't think so. As you point out
>>> yourself you can just compile 5.8 or later on these machines.
>>
>> 5.8 as minimum is probably for the best. It's not that just you can
>> compile a newer version (5.8), more importantly, Perl 5.8 is availab=
le
>> as a package from those semi-official 3party repositories for most
>> systems (at least the *nix systems I have access to)
>
> Do those repositories also have 5.10 and 5.12?

Anything later than 5.8 seems to very unusual except for Linux (and
presumably *bsd).

>> except for those like Irix 6.2 where it's hopeless anyway (perl
>> 5.0). But I only have access to irix/aix/solaris/tru64 in addition
>> to Linux.
>
> Hrm, 6.2 is old, but 5.12 is known to compile on 6.5 at least. What
> are the issues with 6.2? Perhaps they could be solved if someone with
> such a machine contributed a smoker for the perl core.

IRIX 6.2 is simply suffering for being old. Unless you have to
maintain a legacy system (as I do) you would probably have upgraded to
IRIX 6.5 anyway.
(Actually it turns out that I wasn't entirely correct in what I wrote
earlier - the SGI freeware version of Perl for IRIX 6.5 is still at
5.6.1, because they stopped updating that repository. There's another
3party semi-official repo for IRIX now, not hosted by SGI, but I'm not
familiar with it.

> Perl is very portable with people willing to port it, the main
> limitation is usually that porters don't have access to obscure
> systems, not that there isn't interest.

People interested in installing Git will probably first want to look
for a pre-made package, and, if not, build it themselves. At that
point, however, they would probably give up if it turns out they have
to start building the underlying stuff (e.g. Perl) themselves too, so
I tend to look for the lowest common denominator for 3party packages
(e.g. 5.8 if we can get away with it, not 5.10). IRIX 6.5 is a bit
unfortunate in this though. IRIX 6.2 can be considered an unlikely
corner case.

-Tor
