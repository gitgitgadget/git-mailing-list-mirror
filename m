From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: git status: small difference between stating whole repository and
 small subdirectory
Date: Tue, 10 Apr 2012 17:16:34 +0200
Message-ID: <CAA01Cso0bjN5d40p0jRKdWt_vJ06C+X+Q1PJqtEsAheYfHBiSw@mail.gmail.com>
References: <20120215190318.GA5992@sigill.intra.peff.net>
	<CAA01Cso5y23UMguEe0vwOc6kR3-DjuC8-LTMDsMeeOKU4rVGvg@mail.gmail.com>
	<20120216192001.GB4348@sigill.intra.peff.net>
	<CAA01Csq6vSekW=Fa236bB0H3LVtN43Gb2aLMVE+A1wVyUqYJ7A@mail.gmail.com>
	<20120217203755.GA30114@sigill.intra.peff.net>
	<7vaa4hrtbe.fsf@alter.siamese.dyndns.org>
	<20120217222912.GC31830@sigill.intra.peff.net>
	<CAA01CsozANwtox06iihKBL8iii175FHAhChmNhG1B0ofGKWcEA@mail.gmail.com>
	<20120220140653.GC5131@sigill.intra.peff.net>
	<87ty2l38ay.fsf@thomas.inf.ethz.ch>
	<20120220143644.GA13938@do>
	<CACsJy8DE86qzA1=GiKZFRCt5aH8X4iMyDvfrhnqwmbq52szhHg@mail.gmail.com>
	<7vvcmzczku.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 17:17:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHcoW-0002B9-4r
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 17:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759362Ab2DJPQh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Apr 2012 11:16:37 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36983 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759356Ab2DJPQf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Apr 2012 11:16:35 -0400
Received: by iagz16 with SMTP id z16so7469793iag.19
        for <git@vger.kernel.org>; Tue, 10 Apr 2012 08:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=zlBHcaR8hy7CONbuOfQ0A+a9J5tqva55DPdxUEPDTxM=;
        b=UATDJ2xuJQMuEeeRF75vAygTViD68gbMcQOwjQAPv8geBEoaql7J5cZCFZuW46OV+1
         Lq5gK/o3gYbfvLtB5j2Hb1xzkimGGzbrLIllM4IGliVC4f4cb7Kx06NBmtMHUGMQ+Yj5
         oiwZMQAawSqWTe2aQUrk9hExM5wPm3H1jrBlrSDsKSC6RLWmxJkqmKmmzvtYo/nkeZb+
         knbP1ZkiF9y3o8n0zAR6hT/s00xLIajCpivFfFNdSnDAIUpd7ZE9/nXcS4YyAvsyu102
         A1rL0U1goi3I/rBejcVJhLBf2gmWiGgyuCKqNQIQK0BJjgFCg8LGAwZds0TtH4TT1Crm
         rXuQ==
Received: by 10.43.68.132 with SMTP id xy4mr7109103icb.54.1334070994623; Tue,
 10 Apr 2012 08:16:34 -0700 (PDT)
Received: by 10.50.128.198 with HTTP; Tue, 10 Apr 2012 08:16:34 -0700 (PDT)
In-Reply-To: <7vvcmzczku.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195093>

On Wed, Feb 22, 2012 at 4:32 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>>> diff --git a/builtin/checkout.c b/builtin/checkout.c
>>> index 5bf96ba..c06287a 100644
>>> --- a/builtin/checkout.c
>>> +++ b/builtin/checkout.c
>>> @@ -319,6 +319,10 @@ static void show_local_changes(struct object *=
head, struct diff_options *opts)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die(_("diff_setup_done failed"));
>>> =A0 =A0 =A0 =A0add_pending_object(&rev, head, NULL);
>>> =A0 =A0 =A0 =A0run_diff_index(&rev, 0);
>>> + =A0 =A0 =A0 if (!DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct tree *tree =3D parse_tree_indi=
rect(head->sha1);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prime_cache_tree(&active_cache_tree, =
tree);
>>> + =A0 =A0 =A0 }
>>> =A0}
>
> I think this patch is wrong on at least two counts.
>
> =A0* The run_diff_index(&rev, 0) you reused is doing "diff HEAD" and =
not
> =A0 "diff --cached HEAD". =A0The added check does not say anything ab=
out the
> =A0 comparison between the index and the tree at the HEAD.
>
> =A0* Even if we added an extra run_diff_index(&rev, 1) there, or adde=
d a
> =A0 call to index_differs_from() to run "diff --cached HEAD" to check=
 what
> =A0 needs to be checked, it is still not quite right.
>
> On the latter point, imagine what happens in the two invocations of
> checkout in the following sequence:
>
> =A0 $ git reset --hard master
> =A0 $ git checkout master
> =A0 $ git checkout master
>
> The second one should notice that the cache tree is fully valid, so t=
he
> internal "diff --cached" it runs should only open the top-level tree
> and scan entries in it, without recursing into any of the subtrees, a=
nd
> realize that the index is in sync with "HEAD", which should be a very
> cheap operation (that is the whole point of the current topic of our
> discussion looking at the cache-tree). =A0Then the new code calls
> prime_cache_tree() to read _everything_?
>
> Probably cache_tree_fully_valid() should be called before deciding th=
at we
> need to re-populate the cache tree from "HEAD".

Hi,

could I ask what is the status of this? There were some patches
posted, but I think nothing final?

Thanks,

--=20
Piotr Krukowiecki
