From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 4/4] bundle v3: the beginning
Date: Tue, 7 Jun 2016 17:22:22 +0700
Message-ID: <CACsJy8DSvS6DxBM-RUknOEe5DquF-qcRr-MK5FUZcRXYDpSgXg@mail.gmail.com>
References: <xmqqfuw84uhb.fsf@gitster.mtv.corp.google.com> <1456950761-19759-1-git-send-email-gitster@pobox.com>
 <1456950761-19759-5-git-send-email-gitster@pobox.com> <CAP8UFD1xqRMFE2Wzntu=XevCyj+acGLEO-cTq1fqn+NMe3x0vg@mail.gmail.com>
 <CACsJy8Dr_Z886Jb-O8gbAv_vzBLicNH6bPPpKwb9HWZTKQ9muw@mail.gmail.com>
 <CAP8UFD3jPQFk2deSk5JXC3PTz5yWcvXJ4=Qjam5Qw6P9SrLzFQ@mail.gmail.com>
 <CACsJy8DB_17DZ7REBzicyA_GZCnvNkoYEzftjfyM72QVmEb_Vg@mail.gmail.com> <CAP8UFD2t=2wJ=1U1ctMYNuMSejBYLh2yeLU7ZfP5Q6KLxUApjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 12:23:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAE9y-0006Ut-DC
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 12:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347AbcFGKWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 06:22:54 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:35731 "EHLO
	mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbcFGKWw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 06:22:52 -0400
Received: by mail-it0-f46.google.com with SMTP id z189so77373940itg.0
        for <git@vger.kernel.org>; Tue, 07 Jun 2016 03:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=r4rIy9oHCAJ0zRAScXOmQ8S7IoyahuyPlek2v9/pAT8=;
        b=k6Tv0c9NPujdpjk9AV+Ym9zjKZM1OOMOz1PDYjMQfmH81DsB9T+iHHJlPc1gZHrjkn
         iOyLXpvzCsbQVp1cCN2V+T2KqqF9CGPJvoUlD0JdZ6MYXzDNpn2t/xtT/7wQnYLcJ9+u
         AEaVrB1XB6/6Mg1VPAvjC+pU7Lp4YHIR5l6pl/vBT27gkkezLhO1maLojbevyImD1NiR
         fIWGnVvL9XS9bUf7N3MtIpwiQPycpx0uWCix/klXLoGpfqjzknKVl6K1KB7P265QfWiC
         iOqOqub+kflua56n8wa40ByA3Af/zEP3jJzJEIwJ2Zs8UqM6j4zzh8N8HLabcAVP2eeh
         iB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=r4rIy9oHCAJ0zRAScXOmQ8S7IoyahuyPlek2v9/pAT8=;
        b=f7CR6PJGTv9LOAT6+9Pxo46ZX6HAL4ElRQ1WMuUqM3BJvbKBGs3YBqMNUgYx8ON4tQ
         jy7bKPJp0pR1Lip7Ddct2QyQ3Uh8I7kj+g1CCMA4gg4GOQV0VaVyY/RSnVySKTboeV4n
         CAra7urqGWql5ZslBiHI7I/zN6SOH6ft4vOr3xXyHelzhTRyKn4JB9oEOXGzuSbk4akK
         mXvcLiQL/v9ovl6OV29yFajahT4EmTaaAs+dyTQTAhvlSC75oxziEj2QMDrJn4ZjSYGj
         Gj87bLzlHPgVChlaXmRWq+PVMpqz+TA7pGAPNEYFMbKEYAbu3wpXyx42sOoBahtNuYLS
         CyCQ==
X-Gm-Message-State: ALyK8tKBn1VchWVMbYAFrXNhuoogt1TEAcGigEPuhq7iGZhzNN20WSBQ7hqPzMQb6NiHgzZbr1pyVsRnvJ9PWQ==
X-Received: by 10.36.239.197 with SMTP id i188mr2480703ith.57.1465294971899;
 Tue, 07 Jun 2016 03:22:51 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Tue, 7 Jun 2016 03:22:22 -0700 (PDT)
In-Reply-To: <CAP8UFD2t=2wJ=1U1ctMYNuMSejBYLh2yeLU7ZfP5Q6KLxUApjQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296623>

On Tue, Jun 7, 2016 at 3:46 PM, Christian Couder
<christian.couder@gmail.com> wrote:
>> Any thought on object streaming support?
>
> No I didn't think about this. In fact I am not sure what this means.
>
>> It could be a big deal (might
>> affect some design decisions).
>
> Could you elaborate on this?

Object streaming api is in streaming.h. Normally objects are small and
we can inflate the whole thing in memory before doing anything with
them. For really large objects (which I guess is one of the reasons
for remote odb) we don't want to do that. It takes lots of memory and
you could have objects larger than your physical memory. In some cases
when can ignore those objects (e.g. mark them binary and choose not to
diff). In some other cases (e.g. checkout), we use streaming interface
to process an object while we're inflating it to keep memory usage
down. It's easy to add a new streaming backend, once you settle on how
remote odb streams stuff.

>> I would also think about how pack v4
>> fits in this (e.g. how a tree walker can still walk fast, a big
>> promise of pack v4; I suppose if you still maintain "pack" concept
>> over external odb then it might work). Not that it really matters.
>> Pack v4 is the future, but the future can never be "today" :)
>
> Sorry I haven't really followed pack v4 and I forgot what it is about.

It's a new pack format (and practically vaporware at this point) that
promises much faster access when you need to walk through trees and
commits (think rev-list --objects --all, or git-blame). Because we are
(or I am) still not sure if pack v4 will ever get to the state where
it can be merged to git.git, I think it's ok for you to ignore it too
if you want. You can read more about the format here [1] and go even
further back to [2] when Nicolas teased us with the pack size
(smaller, which is a nice side effect). The potential issue with pack
v4 is, the tree walker (struct tree_desc and related funcs in
walk-tree.h) needs to know about pack v4 in order to walk fast.
Current tree walker does not care if an object is packed (using what
format) at all. Remote odb for pack v4 must have some way that allows
to read pack data directly, something close to "mmap", it's not just
about an api to "get me the canonical content of this object".

[1] http://article.gmane.org/gmane.comp.version-control.git/234012
[2] http://article.gmane.org/gmane.comp.version-control.git/233038
-- 
Duy
