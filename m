Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FB221F404
	for <e@80x24.org>; Mon,  9 Apr 2018 13:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751851AbeDINhU (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 09:37:20 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:41789 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751801AbeDINhT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 09:37:19 -0400
Received: by mail-pf0-f175.google.com with SMTP id a2so5783586pff.8
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 06:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=QKo2O1xS4pPL6CNqfA/lJYcMRTVApCUdRUqrAiwrXzo=;
        b=IKjiTYkMrlRZupLAtZTwV9CSupecACrsZ+CeYWj9erRIL50s/DaWpacu7UFUIvpAWx
         W0N+FFezXeysJ9FoT31muBGlg3fFNbJAsnzRDVEG0DYUa68BFYkT3WQtjM/odfogrYOC
         aCXfpNIVO9oa3Wl74ZohZvmu7llYhbtsAPfsyTgrLZ2EnrBdNpJFmTiDIjreIShFXvFt
         b5/MeQjLUzWTTu/wpQy4/ii0TigXn78JxpXPRR3ri2swpmk0k9i1PZ9rkqFjg0Qu/bw8
         sH+pp5JiC75E0/YckhOYFvyuWg8lZs9XnKP2AaEs/E2T8CaVXInkQyna95G3/DSabZ2Z
         ftZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QKo2O1xS4pPL6CNqfA/lJYcMRTVApCUdRUqrAiwrXzo=;
        b=hU4b/pFKexYFgjBMUTGi1P+H91P+07pzAlor3iim/OixuFYrnb8S0zoL09sQVLytqu
         uWP+Ifvdt6xJpevI04qJeXTuOMaOaf+Jvv2ZROVtKmjII0RmLyD1a3AHD9P+0KmkDes7
         UjBRwxClcjiUXAPulzIstn6bDokqfP3xa/jGDY9uZgnoUnpPBrrXO7rUNdLxlAfUMjXd
         gniDGEdevRggmMjQR4CS5eqYqZi3n1pQd0KlkdQpRpUAXxxRbPuY57eHIPVtR3yAC0dJ
         svh/hFbDQeIwouJykvwkIIK8VJM0m5pSB2RsxhtHE6gDKMucasTXYq0VINEj6Ldadz30
         mUJw==
X-Gm-Message-State: AElRT7HylgFRVpo9foaiFqi4nJXv1VmS4Rld6O/Dr4lWLZZErf5usrfD
        +NmQ6WTObugMNUdyvKSOzHett1aI
X-Google-Smtp-Source: AIpwx49N0ykgDoX3fFICHoeL/cMh6c7iRAMOWapiBX9tNf2xuDu9zyl/HtcHDPA08tlVR/7q7lISbw==
X-Received: by 10.99.98.196 with SMTP id w187mr25619681pgb.307.1523281038698;
        Mon, 09 Apr 2018 06:37:18 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id r11sm1125257pfg.0.2018.04.09.06.37.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Apr 2018 06:37:18 -0700 (PDT)
Subject: Re: What's cooking in git.git (Apr 2018, #01; Mon, 9)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqd0z865pk.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <98394864-ece6-5112-0274-b2399087f207@gmail.com>
Date:   Mon, 9 Apr 2018 09:37:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqd0z865pk.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/9/2018 6:21 AM, Junio C Hamano wrote:
> * ds/commit-graph (2018-04-02) 16 commits
>   - commit-graph: implement "--additive" option
>   - commit-graph: build graph from starting commits
>   - commit-graph: read only from specific pack-indexes
>   - commit: integrate commit graph with commit parsing
>   - commit-graph: close under reachability
>   - commit-graph: add core.commitGraph setting
>   - commit-graph: implement git commit-graph read
>   - commit-graph: implement git-commit-graph write
>   - commit-graph: implement write_commit_graph()
>   - commit-graph: create git-commit-graph builtin
>   - graph: add commit graph design document
>   - commit-graph: add format document
>   - csum-file: refactor finalize_hashfile() method
>   - csum-file: rename hashclose() to finalize_hashfile()
>   - Merge branch 'jk/cached-commit-buffer' into HEAD
>   - Merge branch 'jt/binsearch-with-fanout' into HEAD
>   (this branch is used by ds/lazy-load-trees.)
>
>   Precompute and store information necessary for ancestry traversal
>   in a separate file to optimize graph walking.
>
>   Ready???
>   It seems that this topic is getting there.

I think this patch is ready to go, barring the edit of "--additive" to 
"--append" in the final commit message and squashing following diff into 
"commit-graph: implement git commit-graph read":

@@ -31,7 +31,7 @@ static struct opts_commit_graph {

  static int graph_read(int argc, const char **argv)
  {
-       struct commit_graph *graph = 0;
+       struct commit_graph *graph = NULL;
         char *graph_name;

         static struct option builtin_commit_graph_read_options[] = {

If you prefer that I re-roll with those changes, I can send a v8.

I'm currently working on new series based on this feature:

* [1] Lazy-load trees when reading commit-graph (ds/lazy-load-trees)

* [2] Compute and consume generation numbers

* Move commit-graph.c globals to the_repository

* Implement 'fsck' functionality for the commit-graph file

* Integrate 'commit-graph write' into 'gc --auto'

I would also like to open the feature to other contributors, especially 
for others who can contribute performance improvements using generation 
numbers. We had a very valuable discussion on the list [2], and I look 
forward to more collaborations like that.

Thanks,
-Stolee

[1] 
https://public-inbox.org/git/20180403120057.173849-1-dstolee@microsoft.com/T/#u

[2] 
https://public-inbox.org/git/20180403165143.80661-1-dstolee@microsoft.com/T/#u
