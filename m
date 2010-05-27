From: Chris Packham <judge.packham@gmail.com>
Subject: Re: git fast-export/fast-import *facepalm*
Date: Thu, 27 May 2010 15:18:57 -0700
Message-ID: <AANLkTimQWW3WLqa0vWmKTYKsbVvnZiStEJI0N9N5tfng@mail.gmail.com>
References: <AANLkTinV5mEACphA-nW9URce0Mh9xyu3UjWmfBqL6cLN@mail.gmail.com>
	<20100527210328.GN16470@spearce.org>
	<AANLkTik9QxiAjZHigx0YS5ybZwj6U7l0fK-byUmBirnO@mail.gmail.com>
	<AANLkTinrUWtqx34U3-FFnyAXXYFkQiwrXc6USXJYR2xE@mail.gmail.com>
	<AANLkTin-SCsgxAUCCYILIHaq-sLDfCgTDfY_Kvc5UVSt@mail.gmail.com>
	<AANLkTinJd1hZE6LiJRHWYknS7e2YUHtKApTaKfpPPfKJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 28 00:19:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHlPw-0004dn-Cx
	for gcvg-git-2@lo.gmane.org; Fri, 28 May 2010 00:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932918Ab0E0WTA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 May 2010 18:19:00 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:60862 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759122Ab0E0WS7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 May 2010 18:18:59 -0400
Received: by qyk13 with SMTP id 13so716367qyk.1
        for <git@vger.kernel.org>; Thu, 27 May 2010 15:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xptxmNtHd7dws6jvpEVJqMqAjauMJfaSDOtlGYOGcM8=;
        b=Tts+ItIxPy1V/Glhcg6Zk7aSidvcqyIXd5fSxzfBWFKfjbBUXmhHPrXH0jsrpJr0JC
         sPkLxN6KN4I8GhCKELXNFjLj+ikGnnSUsrs4XVQ3G79ENjWb2jzWdhmyrtRJeyf4e+1H
         b8CWAgQKnopAH3KZBaKUArhSOVk3aImJ9tPkc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XKbFBGrIaE3WeAxQ/CBKhN+1N3WAllNlGxY9Y7//eEceMsRDXZYZesSEtLDH0mbFYa
         8sisoeUL2qfTnVpzxCq6SeV1kgRGi8JGU5xnY0HtpCDg+zwPZY3c3nBNAxNztKGtmI+B
         g1/ixJQEZaIkgGrLHyVlmUGlNvpWxpSc0XF6k=
Received: by 10.224.96.89 with SMTP id g25mr6371971qan.42.1274998737458; Thu, 
	27 May 2010 15:18:57 -0700 (PDT)
Received: by 10.229.26.74 with HTTP; Thu, 27 May 2010 15:18:57 -0700 (PDT)
In-Reply-To: <AANLkTinJd1hZE6LiJRHWYknS7e2YUHtKApTaKfpPPfKJ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147903>

On Thu, May 27, 2010 at 3:11 PM, Avery Pennarun <apenwarr@gmail.com> wr=
ote:
> On Thu, May 27, 2010 at 6:06 PM, Chris Packham <judge.packham@gmail.c=
om> wrote:
>> They're showing up with 'gitk --all'. I've made a backup so I can
>> expire the reflog and see if they go away.
>
> gitk --all shouldn't be showing stuff just because it's in the reflog=
=2E
> =C2=A0Does it have a branchname tag next to it? =C2=A0Have you exit/r=
estarted
> gitk or are you just using its refresh button? =C2=A0The latter doesn=
't
> work very well across branch deletion.
>
> Avery
>

The commits do have tags. I'll try deleting them and gc'ing again.
