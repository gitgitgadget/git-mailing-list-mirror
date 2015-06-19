From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: co-authoring commits
Date: Fri, 19 Jun 2015 20:18:38 +0200
Message-ID: <55845CFE.4070407@gmail.com>
References: <CAOvwQ4i_HL7XGnxZrVu3oSnsbnTyxbg8Vh6vzi4c1isSrrexYQ@mail.gmail.com> <xmqq4mm66r99.fsf@gitster.dls.corp.google.com> <CAOvwQ4j2bjR1jnLVyZbw1OCE=xQxbCEFGKcK1bpuv1K3s_Y2EQ@mail.gmail.com> <20150617225224.GF4076@thunk.org> <CAOvwQ4jb-w4+Ah3ZhVE0j1aXLx1=8tRN3Wo98tz+G-wEqLGAcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Josh Triplett <josh@joshtriplett.org>
To: Tuncer Ayaz <tuncer.ayaz@gmail.com>, Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Fri Jun 19 20:19:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z60si-00023V-GE
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 20:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755236AbbFSSTI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Jun 2015 14:19:08 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36341 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755200AbbFSSTA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 14:19:00 -0400
Received: by wicnd19 with SMTP id nd19so26347213wic.1
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 11:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=IScNzMaleduWRIDvuyNKFqKucBlWVUPRjQnLrCkpN1s=;
        b=ASyModFugpwyCmix6kPElmLUjK9YxwOuHvIDNZCc/uvo58klaZSb1D00PIof/7M3cy
         w9XskCuj3+4jlCwE4VXXmfSUAOQJw2H3bGyaB9KZusf8v4W93Ju3FvnJBvbny8O+jdC8
         wEDeDSmOX9G1RJUQL2A4SQFlZucKAi6gfYwjTgzc6CFEmnLLNxK88ffyANPlhmXV8i7j
         l71FgdybhiFOn5Nqdm1sd0sc4a9PC3fwqZYsQTU030ClVaeWiORfFT3M4a89oYOsYZ9z
         RScDbwtaNAU+EJKWXa1Zb0FkPhxiLvKoh9+hKaZABzkI0ENL/km7HqF1n/A/t0iavbVa
         hOrA==
X-Received: by 10.180.75.48 with SMTP id z16mr8745978wiv.49.1434737939590;
        Fri, 19 Jun 2015 11:18:59 -0700 (PDT)
Received: from [192.168.1.53] (abre142.neoplus.adsl.tpnet.pl. [83.8.98.142])
        by mx.google.com with ESMTPSA id gj7sm4807871wib.4.2015.06.19.11.18.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2015 11:18:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <CAOvwQ4jb-w4+Ah3ZhVE0j1aXLx1=8tRN3Wo98tz+G-wEqLGAcA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272177>

On 2015-06-18 at 23:25, Tuncer Ayaz wrote:
> On Thu, Jun 18, 2015 at 12:52 AM, Theodore Ts'o wrote:
>> On Wed, Jun 17, 2015 at 10:26:32PM +0200, Tuncer Ayaz wrote:
[...]
>> One could imagine some frankly, quite rare example where there is a
>> team of people who votes on each commit before it gets sent out and
>> where everyone is equal and there is no hierarchy. In that case,
>> perhaps you could set the from field to a mailing list address. But
>> honestly, how often is that *all* of the authors are completely
>> equal[1]?
>=20
> For that case something like patchwork, phabricator, or gerrit seems
> to be the logical tool to use, and should ideally leave a trace of
> approvals and such in the resulting commit message(s). If the patch
> management tool takes care of merging the commit(s), it can be harder
> to misattribute signed-off/reviewed-by/etc, which is a good thing.

Doesn't Gerrit (at least) use trailer-like structured *notes* in the
'reviews' category (i.e. refs/notes/reviews ref) to store information
about review process?

> You could of course use multiple (everybody makes their own) commits,
> where you risk breaking bisectability and avoid the need for equal
> co-authorship support. In pair programming such intermediate commits
> will quite often be fixups, and when you attempt to squash the fixups
> for bisectability's sake, you may get a desire for co-authorship of
> the resulting commit.

Hmmm... I didn't think about the problem of attributing authorship
for squashed commits.  Though here multiple 'author' headers, or
multiline 'author' header would be a better match than 'coauthor'
header (which itself doesn't need, I think, the date filed, or does it?=
)

[This is sent from Thunderbird news, so it should be all right]
--=20
Jakub Nar=C4=99bski
