From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 2/2] t/README: Document the Smoke testing
Date: Mon, 2 Aug 2010 22:28:57 +0000
Message-ID: <AANLkTinLSdp5TLjrisbX27UrRGGZq+D1-84kwOpHCR3p@mail.gmail.com>
References: <1280780684-26344-1-git-send-email-avarab@gmail.com>
	<1280780684-26344-3-git-send-email-avarab@gmail.com>
	<AANLkTim2EY7AACe=UzbG-k7oteV6UMmfPAQMEOFn0iZ7@mail.gmail.com>
	<4C5732CE.10906@gmail.com>
	<AANLkTi=EuTD0M3eNo+PXW7Z2Ra2yzf-i+L4DFQVg8JZ7@mail.gmail.com>
	<AANLkTinNwUsYuB0Wb3aT5ZpnzT24YpmphCEE_TwTPgsG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "John 'Warthog9' Hawley" <warthog9@kernel.org>, gitzilla@gmail.com,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 00:29:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og3VL-0008Is-Ap
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 00:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753787Ab0HBW27 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 18:28:59 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62608 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727Ab0HBW26 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Aug 2010 18:28:58 -0400
Received: by iwn7 with SMTP id 7so4472299iwn.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 15:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JSg+ioJ6QXjFJ51a1m3jXdTyyQZVtaZ58SKmP9YyuQQ=;
        b=DZ3BpvQh57maNSa7PgsaHfSefe+DpP/wcFsbBWph+oifskKcPzlfvE1HUO7qgpOso6
         JpNUutYjIKHUuHsC+BoKa5muCMFIcanVwSNIyelxZLE2sZu8HnSw7ADbRKSbj9OBJnDh
         r12Ky3FDFEZpVhycpZJ89uhFbfK0NtVB+OgMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hwxlmN939gAmvjdQNZNGAB1BqdK0PcWpr+XYSqwAGwxW9IzbSifUZfJF4OYyv/pKtW
         KJe5Qqqg36VPE45YF1a5xTdjVo69MBSGGE1fBwXCilVvxkYwU71whabsoJiw0FD7Xm6c
         o/V714GHEVEbd6AK7sqfyb4QeKMLgG23M0KMQ=
Received: by 10.231.184.1 with SMTP id ci1mr7815346ibb.39.1280788137576; Mon, 
	02 Aug 2010 15:28:57 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Mon, 2 Aug 2010 15:28:57 -0700 (PDT)
In-Reply-To: <AANLkTinNwUsYuB0Wb3aT5ZpnzT24YpmphCEE_TwTPgsG@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152475>

On Mon, Aug 2, 2010 at 22:05, Sverre Rabbelier <srabbelier@gmail.com> w=
rote:
> On Mon, Aug 2, 2010 at 17:00, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>> Do you not like the domain, that the domain's A record points to a
>> Linode box, or both?
>
> The former.
>
>> I don't mind where a smoke server gets hosted, I just want it to be
>> there. But someone's going to have to host it and maintain it.
>
> Agreed.
>
>> Of course just changing the domain would be trivial, just a matter o=
f
>> someone setting up an A record somewhere, or delegating a zone to me=
=2E
>
> John, is it possible to have smoke.git.kernel.org (or such a domain)
> either point at a server =C3=86var controls, or to give him a shell a=
ccount
> there? The point is to have http://smoke.git.nix.is/ hosted on a more
> "Gitty" domain.

Note that that may be a bit premature, since Junio hasn't commented on
whether he wants this at all yet.

>> An alternative would be to change how this works, e.g. making
>> submissions go by E-Mail to a public list, or having smokers push th=
em
>> to public Git repositories which would be registered somewhere.
>
> I like the idea of having it be a public Git repo since that would
> probably make it easier to do maintenance on the repo (e.g., revert
> "vandalism"), but there still needs to be a frontend of sorts
> somewhere :).

Note that all the data is already in Git[1] it just isn't used as the
submission mechanism.

1. http://github.com/gitsmoke
