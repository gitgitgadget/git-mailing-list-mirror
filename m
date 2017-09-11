Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C74E20286
	for <e@80x24.org>; Mon, 11 Sep 2017 04:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750810AbdIKE1p (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Sep 2017 00:27:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39528 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750748AbdIKE1o (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Sep 2017 00:27:44 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8B4OA2h039709
        for <git@vger.kernel.org>; Mon, 11 Sep 2017 00:27:44 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2cwc08747r-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <git@vger.kernel.org>; Mon, 11 Sep 2017 00:27:44 -0400
Received: from localhost
        by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <git@vger.kernel.org> from <sam.bobroff@au1.ibm.com>;
        Mon, 11 Sep 2017 14:27:41 +1000
Received: from d23relay09.au.ibm.com (202.81.31.228)
        by e23smtp03.au.ibm.com (202.81.31.209) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Mon, 11 Sep 2017 14:27:40 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
        by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v8B4RdrT39256220
        for <git@vger.kernel.org>; Mon, 11 Sep 2017 14:27:39 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
        by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v8B4ReYR016842
        for <git@vger.kernel.org>; Mon, 11 Sep 2017 14:27:40 +1000
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
        by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id v8B4Rd1m016836;
        Mon, 11 Sep 2017 14:27:39 +1000
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 2C6BEA0173;
        Mon, 11 Sep 2017 14:27:39 +1000 (AEST)
Date:   Mon, 11 Sep 2017 14:27:38 +1000
From:   Sam Bobroff <sam.bobroff@au1.ibm.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] format-patch: use raw format for notes
References: <334a7be4f61c02db24008181eb1d6c80c95772f7.1503894009.git.sam.bobroff@au1.ibm.com>
 <xmqqingw8ppj.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqingw8ppj.fsf@gitster.mtv.corp.google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-MML: disable
x-cbid: 17091104-0008-0000-0000-000001573917
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 17091104-0009-0000-0000-0000098B5D2F
Message-Id: <20170911042737.4h5b2jygdeu7cpmf@tungsten.ozlabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-09-11_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.0.1-1707230000
 definitions=main-1709110067
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 06, 2017 at 12:34:48PM +0900, Junio C Hamano wrote:
> Sam Bobroff <sam.bobroff@au1.ibm.com> writes:
> 
> > If "--notes=..." is used with "git format-patch", the notes are
> > prefixed with the ref's local name and indented, which looks odd and
> > exposes the path of the ref.
> >
> > Extend the test that suppresses this behaviour so that it also catches
> > this case, causing the notes to be included without additional
> > processing.
> >
> > Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> > ---
> >
> > Notes (foo):
> >     Hi,
> >     
> >     I've noticed what appears to be a small cosmetic bug in git format-patch, as
> >     I've described in the commit message.
> >     
> >     I'm not sure if this patch is the right way to fix it (or perhaps it's not even
> >     a bug), but it should at least help to explain what I'm talking about.
> >     
> >     I've used "git format-patch --notes=foo" to prepare this email so that it is an
> >     example of the issue :-)
> >     
> >     Cheers,
> >     Sam.
> 
> Is the above addition from your 'foo' notes with or without this
> patch?  I think the answer is "without", and the above "example"
> looks just fine to me.

Yes that's correct, it is without the patch.

>  - It is very much intended to allow The "(foo)" after the "Notes"
>    label to show which notes ref the note comes from, because there
>    can be more than one notes refs that annotate the same commit.

Right, that makes perfect sense to me when it's being output locally.

But the ref names are local to my git repo and there is no reaason why
they should be meaningful or even known to the recipients of the patch
email.

>  - And the contents are indented, just like the diffstat and other
>    stuff we place after "---" but before the first "diff", to ensure
>    no matter what text appears there it will not be mistaken as part
>    sure that the contents from the notes will not be mistaken as part
>    of the patch.

I don't quite agree here. I think it would be fine to indent the whole
block by one space, like the diffstat, but the main text is indented an
additional four which looks odd and breaks line wrapping. (Yes, the line
wrapping can be worked around, but still...)

> I do not think an unconditional change of the established format,
> like your patch does, is acceptable, as existing users have relied
> on, and expect to be able to continue relying on, the above two
> aspect of the current format.

Sure and I'm happy look at some kind of optional change but, just out of
curiousity, is there some specific use case that this might break? (Not
that there needs to be one, I agree with the general "don't break
things" approach.)

> But I am somewhat curious what your use case that wants to insert
> the raw contents there is.  We may be able to construct a valid
> argument to add such an output as an optional feature if there is a
> good use case for it.

Perhaps I'm misunderstanding something about it but I just want to
insert text into the comments section automatically, so that I don't
have to post-process the output of format-patch with some horrible sed
script :-)

(If only there were a way to set the coverletter text automatically as
well...)

> Thanks.

Thanks for the reply!
Cheers,
Sam.

> 
> >  log-tree.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/log-tree.c b/log-tree.c
> > index 410ab4f02..26bc21ad3 100644
> > --- a/log-tree.c
> > +++ b/log-tree.c
> > @@ -655,7 +655,8 @@ void show_log(struct rev_info *opt)
> >  		int raw;
> >  		struct strbuf notebuf = STRBUF_INIT;
> >  
> > -		raw = (opt->commit_format == CMIT_FMT_USERFORMAT);
> > +		raw = (opt->commit_format == CMIT_FMT_USERFORMAT) ||
> > +		      (opt->commit_format == CMIT_FMT_EMAIL);
> >  		format_display_notes(&commit->object.oid, &notebuf,
> >  				     get_log_output_encoding(), raw);
> >  		ctx.notes_message = notebuf.len

