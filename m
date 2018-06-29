Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D5BE1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 14:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755153AbeF2OMe (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 10:12:34 -0400
Received: from mout.gmx.net ([212.227.15.19]:33869 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754021AbeF2OMd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 10:12:33 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MDyFr-1fMSst0POB-00HOfW; Fri, 29
 Jun 2018 16:12:20 +0200
Date:   Fri, 29 Jun 2018 16:12:00 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Aaron Schrab <aaron@schrab.com>, git@vger.kernel.org
Subject: Re: [PATCH] sequencer: use configured comment character
In-Reply-To: <xmqqh8lmwsso.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1806291607501.74@tvgsbejvaqbjf.bet>
References: <20180628020414.25036-1-aaron@schrab.com> <xmqqh8lmwsso.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:15RWzUTWNzswV35GcebUjZCiwxN7AFTPOgKQATq2jDD6z9c0eL+
 2had0AMbQGV++IPY+X6BKAEjrgtP/iNB2wUUpG8r5b4uPkH9CQMoDkXmsyIHCWxW8FoQvYY
 oWAeMYZ0fIc8zWl+zF8UBkm+hhO2EAXhwuG5qZVEioLy2GYX4crsnC8XeIxEwoYIHqXjsLT
 0H9dEBuvwEkeLlzdYIZiQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:w//7JDEOCSA=:4o18WN+JejUpskXzWu8jZn
 baI0upBLitHhfWy1HZ66aUnEjqGQFS1DS05HukGa4nH34HBxtxZajeP15SZmHEyytn8JMTeP/
 oEGX4KtI3i7VQe963uCiH8U4l51rWpn5gkKewQToXx8yJDgLPOewJt2+hFJzesV5tNmK9a9/s
 RFOKsivPo2fnvsczOV4woQZRYMeCCJprRqvzvLLcN4ivkNfIEf8zuY4QAJ2WYbJ1W8QVC7qTl
 a6DvYlLc/LhOSr2jSVoLkbrCNHbybqcKRPGamEbu+dki880LVcfTxFF3dcFKwyHT2SNUQ8FoF
 4PLG2U6MHAgqlrkyD/HyI9ju2Q2yvs09+TKJVjRYZYtb26+Wxix4Vu2mxt43pf0xou8OztoI/
 cf8aiBM9ftyPOfcDbHb/gz1wncNQURr1JeEVa3Wa8Ljim0hgsqWzMCvslLSfxlkWE+6dQnsYw
 6XxDNZ9BPqK+o+QLE6Xdw0kcn3yD04I2B0Yy5U7+WLrKyQqBDXQk7H11rs5rsXeoXuab0e+GY
 gRKtzUgRMARwRFhhb4NJT0SBbobfdne7fk7R8VDBgMYZQjzxhmw2GRaRqyzNrSQK4zLPUTGb3
 aN2BILs9yfoqQizcvOWLVDvd2oil8tv+hu9GcinatUbQ0vRSx3pZsRFD6xkS/51blx9mCpdvW
 HGzIkxeObak/+62/qQ9UCHC+9ADpAjlhPvcWkNcuUyqJMYQWynfPX7Bwoywu4Dy3Y0elbG7z+
 FzZ/zV3gw9QQi5XhyVps/psmJ1MKY9vgX7y16OvME+KHkuBm/lHTLiKck05Q0YrzzSequPce0
 eH4csXU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 28 Jun 2018, Junio C Hamano wrote:

> Aaron Schrab <aaron@schrab.com> writes:
> 
> > Use configured comment character when generating comments about branches
> > in an instruction sheet.  Failure to honor this configuration causes a
> > failure to parse the resulting instruction sheet.
> >
> > Signed-off-by: Aaron Schrab <aaron@schrab.com>
> > ---
> >  sequencer.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/sequencer.c b/sequencer.c
> > index 4034c0461b..caf91af29d 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -3991,7 +3991,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
> >  		entry = oidmap_get(&state.commit2label, &commit->object.oid);
> >  
> >  		if (entry)
> > -			fprintf(out, "\n# Branch %s\n", entry->string);
> > +			fprintf(out, "\n%c Branch %s\n", comment_line_char, entry->string);
> >  		else
> >  			fprintf(out, "\n");
> 
> Would this interact OK with core.commentchar set to "auto"?

The idea of "auto" is:

	If set to "auto", `git-commit` would select a character that is not
	the beginning character of any line in existing commit messages.

As there are no pre-existing lines in that script (apart from the ones we
are about to add with the todo_help), the setting "auto" is pretty moot
and we will fall back to the default comment char (or, if there was a
previous core.commentChar that was parsed, that one).

In short: the code is fine, but yes, I had to convince myself by looking
through the code. (Hinting at a possible improvement of the commit
message.)

Ciao,
Dscho
