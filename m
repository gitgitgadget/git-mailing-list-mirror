Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 017521F461
	for <e@80x24.org>; Mon, 26 Aug 2019 16:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732671AbfHZQTi (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 12:19:38 -0400
Received: from elephants.elehost.com ([216.66.27.132]:57844 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731762AbfHZQTi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 12:19:38 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x7QGJTIf035082
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 26 Aug 2019 12:19:29 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Albert Vaca Cintora'" <albertvaka@gmail.com>,
        "'Johannes Sixt'" <j6t@kdbg.org>, <git@vger.kernel.org>
References: <CAAQViEsZW4PzHr5BrkDHU2kSd_e04n02McGPgrmXGZMpgaTePg@mail.gmail.com>        <d31b871a-5c2d-99e7-5616-6f43759bb948@kdbg.org>        <CAAQViEv1_YXPxLRN=eT7yQhro55K4audnouzAjjbHhJsU7pgQA@mail.gmail.com>        <006201d55c1a$68180f50$38482df0$@nexbridge.com> <xmqqsgpoj6ad.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqsgpoj6ad.fsf@gitster-ct.c.googlers.com>
Subject: RE: [Feature Request] Option to make .git not read-only in cloned repos
Date:   Mon, 26 Aug 2019 12:19:22 -0400
Message-ID: <008e01d55c2a$08749ea0$195ddbe0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQNp8WItsZHJ6oa15Vw/HazfT/RW8wGPs2THAhKp3vcBxFpAjQH2sV7po6mFfNA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 26, 2019 11:28 AM, Junio C Hamano wrote:
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> 
> >> Sometimes I clone a repo just to grep for an error string and then I
> >> don't need it anymore, or I clone several repos until I find the one
> >> that contains what I want and delete the rest. Sometimes I want to
> >> write a patch for some software I don't develop regularly so I don't
need
> to keep a clone of it.
> >>
> >> In any case, it would be useful to know the reason those files are
> >> read-only in the first place. Do you guys know who might know?
> >
> > Why don't you wrap your clone in a script that calls chmod -R u+w .git
> > after the clone? This seems like a pretty trivial approach regardless
> > of your workflow. This works in Linux, Mac, Windows (under
> > cygwin-bash) and anything else POSIX-ish.
> 
> But on anything POSIX-ish, is it a problem for some files (but not any
> directory) in .git is made read-only?

Not for me or anyone I personally support. As I suggested to Albert,
wrapping a clone in a script with a chmod would solve the problem with
minimal work.

My own personal issue is convincing people not to clone for every topic
branch, but that's unrelated.

