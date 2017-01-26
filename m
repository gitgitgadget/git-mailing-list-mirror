Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72B981F6DC
	for <e@80x24.org>; Thu, 26 Jan 2017 00:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751815AbdAZAbl (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 19:31:41 -0500
Received: from resqmta-po-03v.sys.comcast.net ([96.114.154.162]:35242 "EHLO
        resqmta-po-03v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751718AbdAZAbk (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Jan 2017 19:31:40 -0500
Received: from resomta-po-15v.sys.comcast.net ([96.114.154.239])
        by resqmta-po-03v.sys.comcast.net with SMTP
        id WXy7cYIlLIMkuWXyVcGesf; Thu, 26 Jan 2017 00:31:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20161114; t=1485390699;
        bh=VUTQmH1k8Xhg0qL6sBzLPtrEtw4kqLj446uR8W1HhuE=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=m9V+rRnBPVn4fAYzmx9nmkLxUPn8s0EXneVdhlLSSiaDpOb+zbtTUVYvEdC+hJayj
         PTYeRd9+LuWyqqtKXWk/e1N02riwz+NuCChv+ZkHQm60TJaAn1nF43PE5MmU11HZLG
         DzsTQ4Y1d2TzhS4ADKS8JHiOVyuAnF6PuA3SP7RZCzTPQdEq3qnouX4hEKfq4nwh5q
         8vtiPhPwlZfnXARSrPepvI+WWN1ullqRWLQM/XuFXeyH0mLJ9l7UcMnpi97auYpOba
         q7e3GfY4FeM9CKdAP0T7iHuLXo2mYHwIzWrqZhfUSswHFgqocO5EEUyxa7Z36pBHSC
         tAVw+P59W4Kbg==
Received: from localhost.localdomain ([73.35.250.55])
        by resomta-po-15v.sys.comcast.net with SMTP
        id WXyUcnWsNz1pFWXyUctN1Q; Thu, 26 Jan 2017 00:31:39 +0000
Subject: Re: merge maintaining history
To:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <58798686.5050401@comcast.net>
 <CA+P7+xoF8E55-XDnQT-GN1=hEwwq4pOsz7--P-SCy29C7ST3Hg@mail.gmail.com>
 <5880BB23.8030702@comcast.net> <xmqq37gezpz8.fsf@gitster.mtv.corp.google.com>
 <38ca43cb-2fc7-0448-352f-7d9413f815c5@gmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
From:   "David J. Bakeman" <nakuru@comcast.net>
X-Enigmail-Draft-Status: N1110
Message-ID: <5889436A.8000707@comcast.net>
Date:   Wed, 25 Jan 2017 16:31:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.1
MIME-Version: 1.0
In-Reply-To: <38ca43cb-2fc7-0448-352f-7d9413f815c5@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------040900090408060008040800"
X-CMAE-Envelope: MS4wfCwtcvj0TQT3XxweII1T8r1l3f5VMnoEzMlWDscYk2EEaG3mIj75qhdFOTxuT2SGspX6/R6sFxV32op/qey8vRFLIm0avLr5J9ROUGKS78myYy9WZ5y2
 ifqVIseWu6AeFZz/ic5guVBHVTmfgX+DQDN2jMJnDroiVqly/LHG7OllPE0UUo1bTXovU+ow0q70POPBD7uAnBmngTr1irGnne57wvmkI1cN5BBe9fvD3IJv
 JzRDFXKd38kJKW8khqsWInRXXBxbSo+4w+HVEMEN4Hc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------040900090408060008040800
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 01/20/2017 03:37 AM, Jakub Narębski wrote:
> W dniu 19.01.2017 o 22:42, Junio C Hamano pisze:
>> "David J. Bakeman" <nakuru@comcast.net> writes:
>  
> [...]
>>> Thanks I think that's close but it's a little more complicated I think
>>> :<(  I don't know if this diagram will work but lets try.
>>>
>>> original A->B->C->D->E->F
>>>              \
>>> first branch  b->c->d->e
>>>
>>> new repo e->f->g->h
>>>
>>> Now I need to merge h to F without loosing b through h hopefully.  Yes e
>>> was never merged back to the original repo and it's essentially gone now
>>> so I can't just merge to F or can I?
>> With the picture, I think you mean 'b' is forked from 'B' and the
>> first branch built 3 more commits on top, leading to 'e'.
>>
>> You say "new repo" has 'e' thru 'h', and I take it to mean you
>> started developing on top of the history that leads to 'e' you built
>> in the first branch, and "new repo" has the resulting history that
>> leads to 'h'.
>>
>> Unless you did something exotic and non-standard, commit 'e' in "new
>> repo" would be exactly the same as 'e' sitting on the tip of the
>> "first branch", so the picture would be more like:
>>
>>> original A->B->C->D->E->F
>>>              \
>>> first branch  b->c->d->e
>>>                         \
>>> new repo                 f->g->h
>> no?
> On the other hand Git has you covered even if you did something 
> non-standard, like starting new repo from the _state_ of 'e', that
> is you have just copied files and created new repository, having
> 'e' (or actually 'e*') as an initial commit.
>
>    original A<-B<-C<-D<-E<-F
>                 \
>    first branch  b<-c<-d<-e
>
>    new repo               e*<-f<-g<-h
>
> Note that arrows are in reverse direction, as it is newer commit
> pointing to its parents, not vice versa.
>
> Assuming that you have everything in a single repository, by adding
> both original and new repo as "remotes", you can use 'git replace'
> command to replace 'e*' with 'e'.
>
>    original A<-B<-C<-D<-E<-F
>                 \
>    first branch  b<-c<-d<-e
>                            \
>    new repo                 \-f<-g<-h
>    (with refs/replace)
>
>>     Then merging 'h' into 'F' will pull everything you did since
>> you diverged from the history that leads to 'F', resulting in a
>> history of this shape:
>>
>>> original A->B->C->D->E->F----------M
>>>              \                    /
>>> first branch  b->c->d->e         /
>>>                         \       /
>>> new repo                 f->g->h
> Then you would have the above history in repositories that fetched
> refs/replace/*, and the one below if replacement info is absent:
>
>    original A<-B<-C<-D<-E<-F<-----------M
>                 \                      /
>    first branch  b<-c<-d<-e           /
>                                      /
>    new repo               e*<-f->g->h
>
> But as Junio said it is highly unlikely that you are in this situation.
>
> HTH
OK so what I've done so far is to clone the original then I added
another remote connected to new repo.  Then I did git merge newrepo.  It
did a bunch of stuff that flashed by really fast and then reported a
conflict.  Now if I do a git st there are a bunch of files that seem to
be already added to a commit and all the files with conflicts which it's
says need to be fixed and added.
I'm still learning git even after using it for several years.  I've
never really seen this before.  So the already added files are the ones
that git was able to merge mechanically?  If so can I diff those changes
some way?  Would I have to un add (reset HEAD) all those files to see
the diffs?  Would it have assumed that my changes are to be preferred?

Thanks again for all the great help!

--------------040900090408060008040800
Content-Type: text/x-vcard; charset=utf-8;
 name="nakuru.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="nakuru.vcf"

begin:vcard
fn:David J. Bakeman
n:Bakeman;David J.
org:Nakuru Software Inc.
adr:;;1504 North 57th Street;Seattle;WA;98103;USA
email;internet:nakuru@comcast.net
tel;work:(206)545-0609
tel;fax:(206)600-6957
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------040900090408060008040800--
