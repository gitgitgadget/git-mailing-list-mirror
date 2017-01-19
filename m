Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9671820A17
	for <e@80x24.org>; Thu, 19 Jan 2017 13:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752622AbdASNOG (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 08:14:06 -0500
Received: from resqmta-po-02v.sys.comcast.net ([96.114.154.161]:56481 "EHLO
        resqmta-po-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752612AbdASNOF (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 19 Jan 2017 08:14:05 -0500
Received: from resomta-po-10v.sys.comcast.net ([96.114.154.234])
        by resqmta-po-02v.sys.comcast.net with SMTP
        id UCVPcHKmjoFDdUCVXcwfad; Thu, 19 Jan 2017 13:12:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20161114; t=1484831523;
        bh=d7yc+7SxbeG8yrOZoiUx2G2HFUj1FtvKzOxu6GALPro=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=J72HSA4FIu4P2eiiLCkXMtAX/mJKqc/G8BgnWDoFQUZSS4gmBNQyqfi+6tdT3yUZS
         0IOchlXLshQ27F8OjQi+nk/Fwhkyci1emazXw7PiMNX3+5XmRaDoRgAnfBP7peBxAW
         7k88i5KAD9ERmyEU8tnaKVao7KTY4Uv0W8sz5I+9++SxL9RFuMVrltGytuUQ6MFfYL
         5VjhvKYQPvAfPituqdaSdLVx4FwNWyCBnktw+Mz8XjAN8hRVJZ+hHiNoSgFD4bJSs+
         1VfRYYmjUsIFvBXhnGka1n6/BNmx4XCa/h22RUqilfMj4WfK91O/uy2S8KFgFZQiin
         48hOd4oKCydpQ==
Received: from localhost.localdomain ([73.35.250.55])
        by resomta-po-10v.sys.comcast.net with SMTP
        id UCVXcYMzYbEEOUCVXcwZny; Thu, 19 Jan 2017 13:12:03 +0000
Subject: Re: merge maintaining history
To:     Jacob Keller <jacob.keller@gmail.com>
References: <58798686.5050401@comcast.net>
 <CA+P7+xoF8E55-XDnQT-GN1=hEwwq4pOsz7--P-SCy29C7ST3Hg@mail.gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
From:   "David J. Bakeman" <nakuru@comcast.net>
X-Enigmail-Draft-Status: N1110
Message-ID: <5880BB23.8030702@comcast.net>
Date:   Thu, 19 Jan 2017 05:12:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.1
MIME-Version: 1.0
In-Reply-To: <CA+P7+xoF8E55-XDnQT-GN1=hEwwq4pOsz7--P-SCy29C7ST3Hg@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------070302090007050506060301"
X-CMAE-Envelope: MS4wfEQH5EC1lHWjqfDBkSYPHC9HgbaYIwtgyQXvXY5qlg02t5dIaOuUQolQx4GCQWicy7NDheBvTD7NBApdq+mp6kJFZ5nx2aRMdzcnKIWtMar+KC4hSw2H
 WiFVRGpduSvmoXlojet/yg9SO42R2xvEhANFzLYXgjPS6lm+32f7c2G3rR9TiC5GzytlLekyJHs1fEO0nHZgYdr9c55dJT9RgeY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------070302090007050506060301
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 01/14/2017 10:24 PM, Jacob Keller wrote:
> On Fri, Jan 13, 2017 at 6:01 PM, David J. Bakeman <nakuru@comcast.net> wrote:
>> History
>>
>> git cloned a remote repository and made many changes pushing them all to
>> said repository over many months.
>>
>> The powers that be then required me to move project to new repository
>> server did so by pushing local version to new remote saving all history!
>>
>> Now have to merge back to original repository(which has undergone many
>> changes since I split off) but how do I do that without loosing the
>> history of all the commits since the original move?  Note I need to push
>> changes to files that are already in existence.  I found on the web a
>> bunch of ways to insert a whole new directory structure into an existing
>> repository but as I said I need to do it on top of existing files.  Of
>> course I can copy all the files from my local working repository to the
>> cloned remote repository and commit any changes but I loose all the
>> history that way.
>>
>> Thanks.
> If I understand it.. you have two remotes now:
>
> The "origin" remote, which was the original remote you started with.
>
> You have now a "new" remote which you created and pushed to.
>
> So you want to merge the "new" history into the original tree now, so
> you checkout the original tree, then "git merge <new-remote>/<branch>"
> and then fix up any conflicts, and then git commit to create a merge
> commit that has the new history. Then you could push that to both
> trees.
>
> I would want a bit more information about your setup before providing
> actual commands.
Thanks I think that's close but it's a little more complicated I think
:<(  I don't know if this diagram will work but lets try.

original A->B->C->D->E->F
             \
first branch  b->c->d->e

new repo e->f->g->h

Now I need to merge h to F without loosing b through h hopefully.  Yes e
was never merged back to the original repo and it's essentially gone now
so I can't just merge to F or can I?
 
>
> Thanks,
> Jake
>


--------------070302090007050506060301
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


--------------070302090007050506060301--
