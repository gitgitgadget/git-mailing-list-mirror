From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 4/4] bundle v3: the beginning
Date: Tue, 31 May 2016 15:18:42 +0200
Message-ID: <CAP8UFD3jPQFk2deSk5JXC3PTz5yWcvXJ4=Qjam5Qw6P9SrLzFQ@mail.gmail.com>
References: <xmqqfuw84uhb.fsf@gitster.mtv.corp.google.com>
	<1456950761-19759-1-git-send-email-gitster@pobox.com>
	<1456950761-19759-5-git-send-email-gitster@pobox.com>
	<CAP8UFD1xqRMFE2Wzntu=XevCyj+acGLEO-cTq1fqn+NMe3x0vg@mail.gmail.com>
	<CACsJy8Dr_Z886Jb-O8gbAv_vzBLicNH6bPPpKwb9HWZTKQ9muw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 31 15:18:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7jZJ-00058f-28
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 15:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822AbcEaNSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 09:18:45 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35176 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935AbcEaNSo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 09:18:44 -0400
Received: by mail-wm0-f46.google.com with SMTP id a136so131601261wme.0
        for <git@vger.kernel.org>; Tue, 31 May 2016 06:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=5zktuVeLua4PEki0LnsmNuR632F49wh1KiCALadtK54=;
        b=ORdPwPX4pcC2lFbRu1fLfsaOll1Y9BhctXpDNwCIZA/Nh2eukeSMEh+eX8gf4u+sSd
         5NMxZbOAeJgQ9Oc+qQ1qxLMmRsG/fTkzljfHTBvKeJVHOdtNMOw49od57uugKe5/oI4X
         ghpf6sFJHsaBT4DABDntviACqaQh3XRl9wRuWWAeHn/OJgGeFE4q8e8Xn9wdwGZi6L4U
         9WV7ES3QYoSApckJsuXWr8ePP2AWIAtgMx08vmtRAGe6L5FjiTuUStqsC45rrKhFbz+d
         ijX4s3rAx9DApLKmePCJ5vcZpmvWt0a54n2VsspUupII7xS6Nkq65PsoP7XV+5HCfGrG
         +9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=5zktuVeLua4PEki0LnsmNuR632F49wh1KiCALadtK54=;
        b=FNETbQF0exXnEN4WJ8AtW78SmOzwci8qnhfJKTbEwYeWxYOlezflgU5DAsy56o/0wp
         i6durp/rzkT2DtUG9hP15Ew5nbkL40eTOEBNlhPccXmf3MEtm/eBd6RG/R1K9dQl3lqS
         me5AB9ueYSQ+zjxoaHGlqXZLGpRXLo0S0wOElrLKFeW9peds0HIGdJGvFlHS3piu3jl0
         kz12/tVXKfWSr4C3jY5Tzwlo5VOqWYG3mZFTYMsdoo7lL+sfdBh2EdFahtsFMXlMSCX4
         VXqmOkJaDRZfyUrKaZ4SnfqlbS2LoQDvnsmRQ86aqKK05IehHuI0S3jF2E9Nsn+H5RU8
         VDBQ==
X-Gm-Message-State: ALyK8tKIIVfQEP7/R7lgOgMxV2oRZYlFxOF4EQbmOi0BF3PGT0aDZVgAylB5iLQVOTRUcoNEd96z83qCvuEGHw==
X-Received: by 10.195.17.166 with SMTP id gf6mr31436576wjd.124.1464700722488;
 Tue, 31 May 2016 06:18:42 -0700 (PDT)
Received: by 10.194.148.146 with HTTP; Tue, 31 May 2016 06:18:42 -0700 (PDT)
In-Reply-To: <CACsJy8Dr_Z886Jb-O8gbAv_vzBLicNH6bPPpKwb9HWZTKQ9muw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295975>

On Tue, May 31, 2016 at 2:43 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, May 20, 2016 at 7:39 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> I am responding to this 2+ month old email because I am investigating
>> adding an alternate object store at the same level as loose and packed
>> objects. This alternate object store could be used for large files. I
>> am working on this for GitLab. (Yeah, I am working, as a freelance,
>> for both Booking.com and GitLab these days.)
>
> I'm also interested in this from a different angle, narrow clone that
> potentially allows to skip download some large blobs (likely old ones
> from the past that nobody will bother).

Interesting!

[...]

>> I wonder if this mechanism could also be used or extended to clone and
>> fetch an alternate object database.
>>
>> In [1], [2] and [3], and this was also discussed during the
>> Contributor Summit last month, Peff says that he started working on
>> alternate object database support a long time ago, and that the hard
>> part is a protocol extension to tell remotes that you can access some
>> objects in a different way.
>>
>> If a Git client would download a "$name.bndl" v3 bundle file that
>> would have a "data: $URL/alt-odb-$name.odb" extended header, the Git
>> client would just need to download "$URL/alt-odb-$name.odb" and use
>> the alternate object database support on this file.
>
> What does this file contain exactly? A list of SHA-1 that can be
> retrieved from this remote/alternate odb?

It would depend on the external odb. Git could support different
external odb that have different trade-offs.

> I wonder if we could just
> git-replace for this marking. The replaced content could contain the
> uri pointing to the alt odb.

Yeah, interesting!
That's indeed another possibility that might not need the transfer of
any external odb.

But in this case it might be cleaner to just have a separate ref hierarchy like:

refs/external-odbs/my-ext-odb/<sha1>

instead of using the replace one.

Or maybe:

refs/replace/external-odbs/my-ext-odb/<sha1>

if we really want to use the replace hierarchy.

> We could optionally contact alt odb to
> retrieve real content, or just show the replaced/fake data when alt
> odb is out of reach.

Yeah, I wonder if that really needs the replace mechanism.

> Transferring git-replace is basically ref
> exchange, which may be fine if you don't have a lot of objects in this
> alt odb.

Yeah sure, great idea!

By the way this makes me wonder if we could implement resumable clone
using some kind of replace ref.

The client while cloning nearly as usual would download one or more
special replace refs that would points to objects with links to
download bundles using standard protocols.
Just after the clone, the client would read these objects and download
the bundles from these objects.
And then it would clone from these bundles.

> If you do, well, we need to deal with lots of refs anyway.
> This may benefit from it too.
>
>> [3] http://thread.gmane.org/gmane.comp.version-control.git/202902/focus=203020
>
> This points to  https://github.com/peff/git/commits/jk/external-odb
> which is dead. Jeff, do you still have it somewhere, or is it not
> worth looking at anymore?

I have rebased, fixed and improved it a bit. I added write support for
blobs. But the result is not very clean right now.
I was going to send a RFC patch series after cleaning the result, but
as you ask, here are some links to some branches:

- https://github.com/chriscool/git/commits/gl-external-odb3 (the
updated patches from Peff, plus 2 small patches from me)
- https://github.com/chriscool/git/commits/gl-external-odb7 (the same
as above, plus a number of WIP patches to add blob write support)

Thanks,
Christian.
