From: Chris Patti <cpatti@gmail.com>
Subject: Re: Example git hooks (Re: Odd results writing a Git pre-receive hook
 to syntax check PHP files.)
Date: Tue, 31 Aug 2010 09:11:10 -0400
Message-ID: <AANLkTin8ZB8phz9J0TQwNoC4t4TZYz5PKW=yrhiV7i+1@mail.gmail.com>
References: <AANLkTikktdPoZN8MwJD+Gxus16xBGtScCAqT9W0eiWAb@mail.gmail.com>
	<4C7B8E1E.6050708@drmicha.warpmail.net>
	<AANLkTimqzDO49h40b16gQ_=X42NXN-wZNV7d7f3KYygt@mail.gmail.com>
	<20100830141602.GF2315@burratino>
	<AANLkTi=GUrnH87faWH8G0tD7_KAynVf_ig0KpQRwnsaE@mail.gmail.com>
	<20100830143411.GH2315@burratino>
	<20100831015712.GT4925@inocybe.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 15:11:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqQcZ-0001sF-FD
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 15:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754002Ab0HaNLN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 09:11:13 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:65414 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752587Ab0HaNLM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 09:11:12 -0400
Received: by bwz11 with SMTP id 11so4430121bwz.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 06:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rb47mU1kAAjKX065o9FY1gVhqJsDhb9rVXfgVQ5Zrqw=;
        b=doFVUUCLw1cV7oC/km0gTqfpH5C9CcpozagKkluEANbzNtH+uKKYR7MMIOS/aGxzi0
         lRjSXYgQCmgqxp5mBgfdCv5ueggv0j0yQ0ieryAAaUyyWzFRbuJUxE31q18m/6OT7SUz
         eS1dyWW4iSkK/Z2wFJcqW38QxPr87qqVGUeUo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RM6kfYIyCiV1bg4j5CO4lzRNk/jFgzX714eRIYalwxKjwXiXjAVlflJuK6/+FVTECa
         g7df0ZMNhqcaa+kdcXea8Ffelb0YY1tVePGWt8jEWpkkgJKWsLoond1wozJYh1zj1hi5
         5c79dTLBBN4gtR68fvvoXvCMuxoQxwbwT4Hf8=
Received: by 10.204.60.133 with SMTP id p5mr4464922bkh.71.1283260270562; Tue,
 31 Aug 2010 06:11:10 -0700 (PDT)
Received: by 10.204.66.196 with HTTP; Tue, 31 Aug 2010 06:11:10 -0700 (PDT)
In-Reply-To: <20100831015712.GT4925@inocybe.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154898>

On Mon, Aug 30, 2010 at 9:57 PM, Todd Zullinger <tmz@pobox.com> wrote:
> Jonathan Nieder wrote:
>> Chris Patti wrote:
>>
>>> (P.S. Is there a canonical 'example Git hooks' location I could
>>> publish this to when it's working? I think there's a dearth of this
>>> kind of example for people out there right now)
>>
>> Try the git wiki (git.wiki.kernel.org). =C2=A0There is a page for al=
iases
>> but no page for example hooks yet (though there are some examples
>> under InterfacesFrontendsAndTools). =C2=A0You could be the trailblaz=
er.
>>
>> There are also a few examples in git templates/ and contrib/hooks,
>> of course.
>
> This reminds me a little of a discussion that came up a while back
> regarding syntax checking of puppet manifests. =C2=A0The resulting ho=
ok is
> here:
>
> http://projects.puppetlabs.com/projects/puppet/wiki/Puppet_Version_Co=
ntrol#Git+Update+Hook
>
> The git list discussion:
>
> http://thread.gmane.org/gmane.comp.version-control.git/118626
>
> Dunno if that'll help you at all or not Chris. =C2=A0Hopefully it doe=
sn't
> hurt at least. :)
>
> --
> Todd =C2=A0 =C2=A0 =C2=A0 =C2=A0OpenPGP -> KeyID: 0xBEAF0CE3 | URL: w=
ww.pobox.com/~tmz/pgp
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
> Every side I get up on is the wrong side of bed.
> If it weren't so expensive, I'd wish I were dead.
> =C2=A0 =C2=A0-- signed Unhappy
>
>

An interesting example, thanks for that!

What's interesting is that it also evidences another characteristic I
saw in a hook someone wrote here - they treat old_sha1 being 000000000
as a deletion, but I'm also seeing that when the hook is invoked on
the first push in a new branch (Which makes sense since there is no
old_sha1) but it makes me wonder if people are unaware of an implicit
bug - in this case, all such pushes are skipped and not checked, so
this means that someone can check in broken Puppet code if they are
the first ones to do so on a new branch.

-Chris


--=20
Christopher Patti - Geek At Large | GTalk: cpatti@gmail.com | AIM:
chrisfeohpatti | P: (260) 54PATTI
"Technology challenges art, art inspires technology." - John Lasseter, =
Pixar
