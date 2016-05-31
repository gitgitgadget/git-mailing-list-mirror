From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 4/4] bundle v3: the beginning
Date: Tue, 31 May 2016 19:43:27 +0700
Message-ID: <CACsJy8Dr_Z886Jb-O8gbAv_vzBLicNH6bPPpKwb9HWZTKQ9muw@mail.gmail.com>
References: <xmqqfuw84uhb.fsf@gitster.mtv.corp.google.com> <1456950761-19759-1-git-send-email-gitster@pobox.com>
 <1456950761-19759-5-git-send-email-gitster@pobox.com> <CAP8UFD1xqRMFE2Wzntu=XevCyj+acGLEO-cTq1fqn+NMe3x0vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 31 14:44:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7j1j-0000uc-Kj
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 14:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561AbcEaMn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 08:43:58 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:34486 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929AbcEaMn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 08:43:57 -0400
Received: by mail-io0-f182.google.com with SMTP id p194so38342666iod.1
        for <git@vger.kernel.org>; Tue, 31 May 2016 05:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=R49eGuvc7bCU852HnqTjcFWu903feg4Rg0KeoJZB+QU=;
        b=OWYfc6TtRWRTVp2Kb0wlYUjte6TJJ7D81c6JyewJCds7eMwKZh4klmr568qhJC7olE
         7p6xzCT3eChfMaUp+MrfzoeMowbn4A1MzJgETlKL82VFtFlsl+ah24PwpmTBBNQ34k0u
         jvQfHkWozvG9GP9HpGFZZqvWT1YJsNp6d5xkMhAVP/ogTMAQ7V3czshuDbPeF44ZjH6F
         lvd/IudNZQcZ4Yfz294JVBJ5aSilJu2F2y9kaiwOHAdv36ueHYaB0HGUGz7jzuP2pCy4
         f1clO00yZppVOlVsvaKDcNqBPPX4yd46pBY4qzp0mkUMBFUNXd2JcHAcHBl+g2nyltqk
         mPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=R49eGuvc7bCU852HnqTjcFWu903feg4Rg0KeoJZB+QU=;
        b=HcvkaGoPkEky+X5CG1OT3GcePlrMN2DAS7vHCVB5HJaWiV0UMmW4wUNAUZEPxeS95u
         fHEsI28pb9uvpn9XgM+7LYA7sH1mn7e6bp2NMx4Ka2VgyATK9gq55KwkZIFsfKQeWsw+
         4PgtCQHfsoBGSB2/DyTeNBM7pzGwNh22VQypCf2+peYKk30fHFvmkLMzuJL4tG1iYGi5
         T9rjxmSJBe6x9+klmlXTntiZaoPM8RtDHUV8TKHIncoV0eT2gYaoNyWQ5thsj+hg1/10
         iDXCH4q8tqbU7UQGD4OA+nP3ZHsxftJRQ6VweDdfNobbgK66bxADyhVRsgngZzmjzeqZ
         fDtw==
X-Gm-Message-State: ALyK8tKVfNIJ+gf9oks865Wbo+0YD318M0knZvDSer294xcK0pSvcbW4NU6Q3ofP8/5VYo/96iBaX7txR+UARA==
X-Received: by 10.107.159.84 with SMTP id i81mr25773540ioe.29.1464698636708;
 Tue, 31 May 2016 05:43:56 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Tue, 31 May 2016 05:43:27 -0700 (PDT)
In-Reply-To: <CAP8UFD1xqRMFE2Wzntu=XevCyj+acGLEO-cTq1fqn+NMe3x0vg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295974>

On Fri, May 20, 2016 at 7:39 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> I am responding to this 2+ month old email because I am investigating
> adding an alternate object store at the same level as loose and packed
> objects. This alternate object store could be used for large files. I
> am working on this for GitLab. (Yeah, I am working, as a freelance,
> for both Booking.com and GitLab these days.)

I'm also interested in this from a different angle, narrow clone that
potentially allows to skip download some large blobs (likely old ones
from the past that nobody will bother).

> On Wed, Mar 2, 2016 at 9:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> The bundle v3 format introduces an ability to have the bundle header
>> (which describes what references in the bundled history can be
>> fetched, and what objects the receiving repository must have in
>> order to unbundle it successfully) in one file, and the bundled pack
>> stream data in a separate file.
>>
>> A v3 bundle file begins with a line with "# v3 git bundle", followed
>> by zero or more "extended header" lines, and an empty line, finally
>> followed by the list of prerequisites and references in the same
>> format as v2 bundle.  If it uses the "split bundle" feature, there
>> is a "data: $URL" extended header line, and nothing follows the list
>> of prerequisites and references.  Also, "sha1: " extended header
>> line may exist to help validating that the pack stream data matches
>> the bundle header.
>>
>> A typical expected use of a split bundle is to help initial clone
>> that involves a huge data transfer, and would go like this:
>>
>>  - Any repository people would clone and fetch from would regularly
>>    be repacked, and it is expected that there would be a packfile
>>    without prerequisites that holds all (or at least most) of the
>>    history of it (call it pack-$name.pack).
>>
>>  - After arranging that packfile to be downloadable over popular
>>    transfer methods used for serving static files (such as HTTP or
>>    HTTPS) that are easily resumable as $URL/pack-$name.pack, a v3
>>    bundle file (call it $name.bndl) can be prepared with an extended
>>    header "data: $URL/pack-$name.pack" to point at the download
>>    location for the packfile, and be served at "$URL/$name.bndl".
>>
>>  - An updated Git client, when trying to "git clone" from such a
>>    repository, may be redirected to $URL/$name.bndl", which would be
>>    a tiny text file (when split bundle feature is used).
>>
>>  - The client would then inspect the downloaded $name.bndl, learn
>>    that the corresponding packfile exists at $URL/pack-$name.pack,
>>    and downloads it as pack-$name.pack, until the download succeeds.
>>    This can easily be done with "wget --continue" equivalent over an
>>    unreliable link.  The checksum recorded on the "sha1: " header
>>    line is expected to be used by this downloader (not written yet).
>
> I wonder if this mechanism could also be used or extended to clone and
> fetch an alternate object database.
>
> In [1], [2] and [3], and this was also discussed during the
> Contributor Summit last month, Peff says that he started working on
> alternate object database support a long time ago, and that the hard
> part is a protocol extension to tell remotes that you can access some
> objects in a different way.
>
> If a Git client would download a "$name.bndl" v3 bundle file that
> would have a "data: $URL/alt-odb-$name.odb" extended header, the Git
> client would just need to download "$URL/alt-odb-$name.odb" and use
> the alternate object database support on this file.

What does this file contain exactly? A list of SHA-1 that can be
retrieved from this remote/alternate odb? I wonder if we could just
git-replace for this marking. The replaced content could contain the
uri pointing to the alt odb. We could optionally contact alt odb to
retrieve real content, or just show the replaced/fake data when alt
odb is out of reach. Transferring git-replace is basically ref
exchange, which may be fine if you don't have a lot of objects in this
alt odb. If you do, well, we need to deal with lots of refs anyway.
This may benefit from it too.

> [3] http://thread.gmane.org/gmane.comp.version-control.git/202902/focus=203020

This points to  https://github.com/peff/git/commits/jk/external-odb
which is dead. Jeff, do you still have it somewhere, or is it not
worth looking at anymore?
-- 
Duy
