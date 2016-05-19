From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [BUG] t9801 and t9803 broken on next
Date: Thu, 19 May 2016 10:19:51 +0200
Message-ID: <DD9F360B-78F0-4C83-B642-606688772E39@gmail.com>
References: <3A110437-F778-42E2-A987-86B4EAB3D963@gmail.com> <20160513103621.GA12329@dcvr.yhbt.net> <xmqqpospap8g.fsf@gitster.mtv.corp.google.com> <4830D469-3885-4010-9A04-D809F0C6159D@gmail.com> <xmqq37pk8q0h.fsf@gitster.mtv.corp.google.com> <5E7631C9-DD59-4358-B907-D7C7AEA1739C@gmail.com> <20160517121330.GA7346@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
	Git Users <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>, spearce@spearce.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 19 10:20:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3JBm-0003mO-Ho
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 10:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753600AbcESIUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 04:20:01 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37739 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753303AbcESIT4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2016 04:19:56 -0400
Received: by mail-wm0-f45.google.com with SMTP id a17so113818385wme.0
        for <git@vger.kernel.org>; Thu, 19 May 2016 01:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=q91V+a+sOQCCvfhtmjTcCN53qOKR+5Nt/JMjex3TuuQ=;
        b=C7NnAWDea6GLTfthCrEpKDreSHekHsuUwZtNRSC5moPIQ6uXOoaUGmEDZuoMVPk3tw
         B1DyUFHIUalV6dgkKINK5avFYTxwot/89m1LITHCHLiXQDWKHfSdzWPG45mFDYolXuHJ
         cnL3m1++MMsz3Nx4zUu1ehwn7f7SbgpGILsRbfmpYs+7nfB0vltSn3egWuXLwO2nU39f
         C5XDKcwNITmGCkjdS9I4vQsgwDNXvqWmn/E/SQXceKxhSi8sz5PQFHUGfVbO+aLWdNI9
         9anJObhrP199GQyUUI0XNxGQHG5FF1QUcS5IdoPMTcu2fpDwsjapGvnoKJg/trqwglRp
         WW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=q91V+a+sOQCCvfhtmjTcCN53qOKR+5Nt/JMjex3TuuQ=;
        b=LN5eNgpLSdZH9Zkmoo8+v24rAPt7t5G8+fCdm++ckF/eKkiLrPLiDb9oKqM6bLykzb
         O1wH+zStdZWIBcic9uQHZJLiHKqfZW3+PqwJU0Na0SH7U8dbgsLEmte7tNOLON4Qo3l2
         SFERKEDdydllsWbd2Y/rW4nb2HN9OiUrowU+pkZehEEYk01iBZNBixAkWrupckLvd2D1
         DLZHdxfz2OChVPXh6qz6Zw+kPl0woeYAqZ/SLXXXCkmwcj1swqWo4lLWnfGa9mw/azBz
         q4KHyU3xA475a0abhJ5HokrXodrNpEJFfR7x8V/Z0ThJ6rD4sxBoKLGVV7K6jy1lHEU3
         gLAQ==
X-Gm-Message-State: AOPr4FV6jQ15xds7WVcF4cOvRnkwoZwWiZ0SZX8vvUwVeEWGAMJl7tubOg5rvCFHMRfNQA==
X-Received: by 10.28.87.6 with SMTP id l6mr12890367wmb.48.1463645994642;
        Thu, 19 May 2016 01:19:54 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB7732.dip0.t-ipconnect.de. [93.219.119.50])
        by smtp.gmail.com with ESMTPSA id i4sm13025113wjj.49.2016.05.19.01.19.52
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 May 2016 01:19:53 -0700 (PDT)
In-Reply-To: <20160517121330.GA7346@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295044>


On 17 May 2016, at 14:13, Jeff King <peff@peff.net> wrote:

> On Tue, May 17, 2016 at 10:07:16AM +0200, Lars Schneider wrote:
> 
>> I think that is pretty much the problem. Here is what is happening:
>> 
>> 1.  git-p4 imports all changelists for the "main" branch
>> 
>> 2.  git-p4 starts to import a second branch and creates a fast-import
>>    "progress checkpoint". This triggers:
>> 
>>    --> fast-import.c: cycle_packfile
>>    --> fast-import.c: end_packfile
>>    --> fast-import.c: loosen_small_pack
>> 
>>    At this point we have no packfile anymore.
>> 
>> 3.  git-p4 sends the command "commit refs/remotes/p4/depot/branch2"
>>    to fast-import in order to create a new branch. This triggers:
>> 
>>    --> fast-import.c: parse_new_commit
>>    --> fast-import.c: load_branch
>>    --> fast-import.c: load_tree
>> 
>>    "load_tree" calls "find_object" and the result has a "pack_id" of 0.
>>    I think this indicates that the object is in the packfile. Shouldn't
>>    the "pack_id" be "MAX_PACK_ID" instead?
>> 
>>        myoe = find_object(sha1);
>>        if (myoe && myoe->pack_id != MAX_PACK_ID) {
> 
> Thanks for the analysis. I think this is definitely the problem.  After
> fast-import finalizes a packfile (either at the end of the program or
> due to a checkpoint), it never discards its internal mapping of objects
> to pack locations. It _has_ to keep such a mapping before the pack is
> finalized, because git's regular object database doesn't know about it.
> But afterwards, it should be able to rely on the object database.
> 
> Retaining the mapping at the end of the program is obviously OK because
> we won't make any more lookups in it.
> 
> Retaining it at a checkpoint when we keep the packfile is OK, because we
> can (usually) still access that packfile (the exception would be if
> somebody runs "git repack" while fast-import is running).
> 
> But obviously a checkpoint where we throw away the pack needs to clear
> that mapping.
> 
> The patch below probably makes your case work, but there are a lot of
> open questions:
Confirmed. The offending tests pass with your patch.


>  1. Should we always discard the mapping, even when not loosening
>     objects? I can't think of a real downside to always using git's
>     object lookups.
> 
>  2. Can we free memory associated with object_entry structs at this
>     point? They won't be accessible via the hash, but might other bits
>     of the code have kept pointers to them?
> 
>     I suspect it may screw up the statistics that fast-import prints at
>     the end, but that's a minor point.
> 
>  3. I notice that a few other structs (branch and tag) hold onto the
>     pack_id, which will now point to a pack we can't access. Does this
>     matter? I don't think so, because checkpoint() seems to dump the
>     branches and tags.
>  4. In general, should we be loosening objects at checkpoints at all?
> 
>     I guess it is probably more efficient than creating a bunch of
>     little packs. And it should probably not happen much at all outside
>     of tests (i.e., callers should generally checkpoint after an
>     appreciable amount of work is done).
I am not too familiar with the code and therefore I can't give a good
answer to your questions. However, I noticed that Shawn (CC'ed) wrote a 
lot of fast-import code. Maybe he can help?

>From my point of view little packs are no problem. I run fast-import on
a dedicated migration machine. After fast-import completion I run repack [1] 
before I upload the repo to its final location.


Thanks,
Lars

[1] https://gcc.gnu.org/ml/gcc/2007-12/msg00165.html


> 
> diff --git a/fast-import.c b/fast-import.c
> index 0e8bc6a..9bfbfb0 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -597,6 +597,22 @@ static struct object_entry *insert_object(unsigned char *sha1)
> 	return e;
> }
> 
> +static void clear_object_table(void)
> +{
> +	unsigned int h;
> +	for (h = 0; h < ARRAY_SIZE(object_table); h++) {
> +		/*
> +		 * We can't individually free objects here
> +		 * because they are allocated from a pool.
> +		 */
> +		object_table[h] = NULL;
> +	}
> +	/*
> +	 * XXX maybe free object_entry_pool here,
> +	 * or might something still be referencing them?
> +	 */
> +}
> +
> static unsigned int hc_str(const char *s, size_t len)
> {
> 	unsigned int r = 0;
> @@ -1035,6 +1051,9 @@ discard_pack:
> 	pack_data = NULL;
> 	running = 0;
> 
> +	/* The objects are now available via git's regular lookups. */
> +	clear_object_table();
> +
> 	/* We can't carry a delta across packfiles. */
> 	strbuf_release(&last_blob.data);
> 	last_blob.offset = 0;
