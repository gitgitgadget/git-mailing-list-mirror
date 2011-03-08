From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: --max-count useless with git-rev-list's --reverse
Date: Tue, 8 Mar 2011 02:35:22 -0500
Message-ID: <AANLkTin19c8jP9D2iQbP8XVLo4O_4+Wf+exwB-inCBQV@mail.gmail.com>
References: <AANLkTikpK-r_kdqCEPwpqEgENtwgUrZDLwZnuS2QMdH=@mail.gmail.com> <AANLkTikTQfxK8B3fN6y5UZ=tRaM_iWXcfq=ukK4vPq2R@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 08:36:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwrSa-00063J-En
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 08:36:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753747Ab1CHHfx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Mar 2011 02:35:53 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49922 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923Ab1CHHfw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Mar 2011 02:35:52 -0500
Received: by iwn34 with SMTP id 34so4629293iwn.19
        for <git@vger.kernel.org>; Mon, 07 Mar 2011 23:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=FPo+m8kD71yXu2Ih5vdh8pQbvfYQZHyUwpr2uvLi+ro=;
        b=oa9LS4Ki9PZkVQ5PMxKMM+Izin3IP9QUmABs6Ra1iBHeKdvxwsF8BUfcJpOny0p8rm
         4MTNfOSSk7pyrLQW4BLSfuMUhiIXejOK44IaT10VstglkjREhtg6bG+Rs++5eszDHrcG
         4XbBkqkS68kGCi94Xje694nU3jbk2dCfZ6qHs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=gFkXrgfLVPI56aIAlvckOcTAKy1csempMJE+tJ3Ax1lmABdcL06WxcFdWosxTjxd1O
         DTFfmYEOazTfEZ3XxdCvoML0XYiF3QFbMHUWxcLZFD7X0Cqh3UCYsoBXb3lKXkHk2PYN
         Fsqh7EIoOvDUIpEYQb4/ZAkCgx9dcnctz8vt8=
Received: by 10.43.43.198 with SMTP id ud6mr6249835icb.127.1299569752081; Mon,
 07 Mar 2011 23:35:52 -0800 (PST)
Received: by 10.231.34.7 with HTTP; Mon, 7 Mar 2011 23:35:22 -0800 (PST)
In-Reply-To: <AANLkTikTQfxK8B3fN6y5UZ=tRaM_iWXcfq=ukK4vPq2R@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168637>

On Mon, Mar 7, 2011 at 2:40 PM, Shawn Pearce <spearce@spearce.org> wrot=
e:
> On Mon, Mar 7, 2011 at 11:17, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>> From the manpage:
>
> No. Its applied after, otherwise things like "git log -n 5 --reverse"

I think I was surprised the first time I tried to combine those
options as well, but in retrospect the reason is obvious. Nonetheless,
I think this has come up on the list a few time, so... =C3=86var, would=
 you
mind submitting a documentation patch?

j.
