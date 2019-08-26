Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 957521F461
	for <e@80x24.org>; Mon, 26 Aug 2019 14:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732485AbfHZO1u convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 26 Aug 2019 10:27:50 -0400
Received: from elephants.elehost.com ([216.66.27.132]:45726 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729131AbfHZO1u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 10:27:50 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x7QERaME030013
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 26 Aug 2019 10:27:37 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Albert Vaca Cintora'" <albertvaka@gmail.com>,
        "'Johannes Sixt'" <j6t@kdbg.org>
Cc:     <git@vger.kernel.org>
References: <CAAQViEsZW4PzHr5BrkDHU2kSd_e04n02McGPgrmXGZMpgaTePg@mail.gmail.com> <d31b871a-5c2d-99e7-5616-6f43759bb948@kdbg.org> <CAAQViEv1_YXPxLRN=eT7yQhro55K4audnouzAjjbHhJsU7pgQA@mail.gmail.com>
In-Reply-To: <CAAQViEv1_YXPxLRN=eT7yQhro55K4audnouzAjjbHhJsU7pgQA@mail.gmail.com>
Subject: RE: [Feature Request] Option to make .git not read-only in cloned repos
Date:   Mon, 26 Aug 2019 10:27:29 -0400
Message-ID: <006201d55c1a$68180f50$38482df0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQNp8WItsZHJ6oa15Vw/HazfT/RW8wGPs2THAhKp3vejxz3XUA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 25, 2019 3:59 PM, Albert Vaca Cintora wrote:
> To: Johannes Sixt <j6t@kdbg.org>
> On Sun, Aug 25, 2019 at 7:54 PM Johannes Sixt <j6t@kdbg.org> wrote:
> >
> > Am 23.08.19 um 22:43 schrieb Albert Vaca Cintora:
> > > However, I'm sure that a large percentage of developers out there
> > > will agree with me that having to use force (-f) to delete every
> > > cloned repo is annoying, and even worse, it creates the bad habit of
> > > always force-deleting everything.
> >
> > IMO, the bad habit is to delete cloned repositories all the time. If
> > your workflow necessitates this, then you are doing something wrong.
> > Maybe you have an X-Y-problem?
> >
> > -- Hannes
> 
> There are plenty of valid workflows where one would delete a repo.
> 
> What you suggest is like saying I shouldn't delete pictures from my camera,
> because in that case I shouldn't have taken them in the first place.
> 
> Sometimes I clone a repo just to grep for an error string and then I don't
> need it anymore, or I clone several repos until I find the one that contains
> what I want and delete the rest. Sometimes I want to write a patch for some
> software I don't develop regularly so I don't need to keep a clone of it.
> 
> In any case, it would be useful to know the reason those files are read-only in
> the first place. Do you guys know who might know?

Why don't you wrap your clone in a script that calls chmod -R u+w .git after the clone? This seems like a pretty trivial approach regardless of your workflow. This works in Linux, Mac, Windows (under cygwin-bash) and anything else POSIX-ish.

