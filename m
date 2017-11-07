Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF45F20A10
	for <e@80x24.org>; Tue,  7 Nov 2017 02:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756297AbdKGCdt convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 6 Nov 2017 21:33:49 -0500
Received: from marcos.anarc.at ([206.248.172.91]:53610 "EHLO marcos.anarc.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756293AbdKGCds (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 21:33:48 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])      (Authenticated sender: anarcat) with ESMTPSA id C34121A00AA
From:   =?utf-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthieu Moy <git@matthieu-moy.fr>, git@vger.kernel.org
Subject: Re: future of the mediawiki extension?
In-Reply-To: <xmqq7ev2j4to.fsf@gitster.mtv.corp.google.com>
Organization: Debian
References: <87vaix731f.fsf@curie.anarc.at> <q7h9o9opyllo.fsf@orange.lip.ens-lyon.fr> <xmqqh8ug3xnq.fsf@gitster.mtv.corp.google.com> <874lqg83u9.fsf@curie.anarc.at> <xmqq7ev2j4to.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 06 Nov 2017 21:33:44 -0500
Message-ID: <87vaim3jhz.fsf@curie.anarc.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-11-07 09:44:03, Junio C Hamano wrote:
> Antoine Beaupré <anarcat@debian.org> writes:
>
>> On 2017-10-31 10:37:29, Junio C Hamano wrote:
>>>> There's also a hybrid solution used by git-multimail: have a copy of the
>>>> code in git.git, but do the development separately. I'm not sure it'd be
>>>> a good idea for Git-Mediawiki, but I'm mentionning it for completeness.
>>>
>>> I think the plan was to make code drop from time to time at major
>>> release points of git-multimail, but I do not think we've seen many
>>> updates recently.
>>
>> I'd be okay with a hybrid as well. It would require minimal work on
>> Git's side at this stage: things can just stay as is until there's a new
>> "release" of the mediawiki extension and at that point you can decide if
>> you merge it all in or if you drop it in favor of the contrib.
>>
>> I think it's also fine to punt it completely out to the community.
>>
>> Either way, I may have time to do some of that work in the coming month,
>> so let me know what you prefer, I guess you two have the last word
>> here. The community, on Mediawiki's side, seem to mostly favor GitHub.
>
> I guess I shouldn't leave this thread hanging.
>
> As contrib/README says, the "owners" of an area in contrib/ has the
> ultimate say and control over the area, and for contrib/mw-to-git,
> the "owners" have always been Matthieu, at least to me.
>
> As he made it clear earlier in this thread that (1) he sees you as a
> steady hand that can help guide the tool forward as its new "owner",
> and (2) he thinks Git-Mediawiki will be helped by being an
> independent project hosted at GitHub, now you have the say ;-)
>
> A few topics from you that are already on list may want to go
> through to 'master' as any other topics, but from there on, I am
> fine with the development of Git-Mediawiki primarily done as a
> separate project, optionally giving contrib/mw-to-git/ occasional
> update dumps.  You could even choose to remove contrib/mw-to-git/*
> except for git-remote-mediawiki.txt that says that the tool's main
> development effort happens at GitHub to redirect people, if you
> think that would reduce potential confusion.
>
> I am also OK to serve as a patch monkey and keep going; I won't be
> picking up patches to contrib/mw-to-git/ unless you (and others)
> review them, though.

Makes sense. I think that, for now, I'll keep some sort of status quo
and "copy" (as opposed to "move") development over to GitHub. We can
then make dumps when new releases are done over there. If that proves
impractical because of changes in the build system or some other reason,
I'll send patches to clear the code from core and replace it with the
suggested .txt file.

Thanks!

A.

-- 
Like slavery and apartheid, poverty is not natural. It is man-made and
it can be overcome and eradicated by the actions of human
beings. Overcoming poverty is not a gesture of charity. It is an act
of justice.             - Nelson Mandela
