Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D1F820282
	for <e@80x24.org>; Sun, 11 Jun 2017 17:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751912AbdFKRHH (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Jun 2017 13:07:07 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34386 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751751AbdFKRHG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2017 13:07:06 -0400
Received: by mail-io0-f194.google.com with SMTP id a96so8732549ioj.1
        for <git@vger.kernel.org>; Sun, 11 Jun 2017 10:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J0nIEzRB2uc6xCggvIj20P8JRUxmbgrdOsngZsNFjGU=;
        b=N1nPOFmlREwuwIfOw9lz81g0tdEbTN+z/yX05oez/2xMZ6MASwu1q8uxc+0BAWy8m3
         IutlFFU0XeKc/qTFb6jQoHgBknHWKv8T2E8Cd84Wo6uC+b70+6570d6E8Uu9B9dIFKQW
         oa8DMc0wmIr7QV06q7lWAIgthaCd90MYk9QfbTtGonBFRsEJUJMmoPdi3Gj6kqEaj5uu
         n2C5+V4rxQvVmwDB516Ho+aqte3XgPVfHSppFYR9b+s7+eCRbUwUrkCjWSetChI8t4vb
         b64JihSwt2nVQEEqKosr0ubcG/TQKqxCFsqQ9Hay0uSdcQm1UOH0HTYb2+sin2Ymlhto
         +b/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J0nIEzRB2uc6xCggvIj20P8JRUxmbgrdOsngZsNFjGU=;
        b=o5wZQAvO4emEW8n6JKf9GXmh4LI388y/Tir1KSAn+empg/Zu5jhk+99+zDL+PqvLgH
         PefgERJb85kdEyLGWaRTaaZMTke2BOTyjd75TWUtI0zBVQy9PdvXH5kuCYkwA/lYzHE0
         72SG886PEqr+NRpcZd75dqylIfDlwF2mxpZaHOgWDeKn4wZmB7hR2tui9tasHgJq2Okl
         WMElfR9dGLJWlocWnVqhGy+jFjEQchZWpPsJvxyU3WrrQXzlsJb6BRd1iXVlfKTt6zhb
         noClgQFs49N80bgZHr6Odp2zSOgEmlbn5RJnq/Zw22GZay63blcWtcH8sDMdELNKS2f2
         lyTg==
X-Gm-Message-State: AODbwcCBMAWqNUYmW61+A1xwBjlRfY7e3FNsnbtbFUGbCPFHezKTNHSn
        YOyY+3Bz6RoQ+PeN3HM=
X-Received: by 10.107.55.132 with SMTP id e126mr50183656ioa.133.1497200825342;
        Sun, 11 Jun 2017 10:07:05 -0700 (PDT)
Received: from [192.168.2.102] (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id w70sm2923912itb.18.2017.06.11.10.07.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jun 2017 10:07:04 -0700 (PDT)
Subject: Re: Feature Request: Show status of the stash in git status command
To:     Jeff King <peff@peff.net>, Samuel Lijin <sxlijin@gmail.com>
Cc:     Houston Fortney <houstonfortney@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <CA+B9myHRahTd+FDgzK5AhXW+hq_Y_czMX9X6MXYBcr9WSPeiDw@mail.gmail.com>
 <20170610082534.6437ifexzly4oqg6@sigill.intra.peff.net>
 <CAJZjrdXCHVKQOxR=+z5cOkieKzE-iSMta--kHVjSYXuansb34Q@mail.gmail.com>
 <20170610102217.vxf6tsrdfp6srupr@sigill.intra.peff.net>
From:   liam Beguin <liambeguin@gmail.com>
Message-ID: <1c04d689-6796-17d1-e058-18874768c22a@gmail.com>
Date:   Sun, 11 Jun 2017 13:07:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20170610102217.vxf6tsrdfp6srupr@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

As it looks like something easy enough for a beginner, I though I could
give it a try. Here is what it looks like. If it's good enough, I'll 
add a few lines to document 'status.showStash' and send a patch.

There is one thing I've noticed though. When using 'git stash pop', it
shows the the number of stashes before dropping the commit and I'm not
quite sure how to address this.

--

diff --git a/wt-status.c b/wt-status.c
index 25aafc35c833..fab66d4cd72e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -801,6 +801,27 @@ static void wt_longstatus_print_changed(struct wt_status *s)
 	wt_longstatus_print_trailer(s);
 }
 
+static int stash_count_refs(struct object_id *ooid, struct object_id *noid,
+			    const char *email, timestamp_t timestamp, int tz,
+			    const char *message, void *cb_data)
+{
+	int *c = cb_data;
+	(*c)++;
+	return 0;
+}
+
+static void wt_longstatus_print_stash_summary(struct wt_status *s)
+{
+	int stash_count = 0;
+
+	for_each_reflog_ent("refs/stash", stash_count_refs, &stash_count);
+	if (stash_count > 0)
+		status_printf_ln(s, GIT_COLOR_NORMAL,
+				 Q_("Your stash currently has %d commit",
+				    "Your stash currently has %d commits", stash_count),
+				 stash_count);
+}
+
 static void wt_longstatus_print_submodule_summary(struct wt_status *s, int uncommitted)
 {
 	struct child_process sm_summary = CHILD_PROCESS_INIT;
@@ -1536,6 +1557,7 @@ static void wt_longstatus_print(struct wt_status *s)
 	const char *branch_color = color(WT_STATUS_ONBRANCH, s);
 	const char *branch_status_color = color(WT_STATUS_HEADER, s);
 	struct wt_status_state state;
+	int show_stash = 0;
 
 	memset(&state, 0, sizeof(state));
 	wt_status_get_state(&state,
@@ -1641,6 +1663,8 @@ static void wt_longstatus_print(struct wt_status *s)
 		} else
 			printf(_("nothing to commit, working tree clean\n"));
 	}
+	if (!git_config_get_bool("status.showStash", &show_stash) && show_stash)
+		wt_longstatus_print_stash_summary(s);
 }
 
 static void wt_shortstatus_unmerged(struct string_list_item *it,




On 10/06/17 06:22 AM, Jeff King wrote:
> On Sat, Jun 10, 2017 at 06:12:28AM -0400, Samuel Lijin wrote:
> 
>> On Sat, Jun 10, 2017 at 4:25 AM, Jeff King <peff@peff.net> wrote:
>>> On Wed, Jun 07, 2017 at 06:46:18PM -0400, Houston Fortney wrote:
>>>
>>>> I sometimes forget about something that I stashed. It would be nice if
>>>> the git status command would just say "There are x entries in the
>>>> stash." It can say nothing if there is nothing stashed so it is
>>>> usually not adding clutter.
>>>
>>> I think the clutter issue would depend on your workflow around stash.
>>>
>>> Some people carry tidbits in their stash for days or weeks. E.g., I
>>> sometimes start on an idea and decide it's not worth pursuing (or more
>>> likely, I post a snippet of a patch as a "how about this" to the mailing
>>> list but don't plan on taking it further). Rather than run "git reset
>>> --hard", I usually "git stash" the result. That means if I really do
>>> decide I want it back, I can prowl through the stash list and find it.
>>>
>>> All of which is to say that if we had such a feature, it should probably
>>> be optional. For some people it would be very useful, and for others it
>>> would be a nuisance.
>>
>> Perhaps there should be a flag for this if it is implemented, say
>> status.showStash?
> 
> Yes, that was what I was thinking.
> 
> -Peff
> 

 - Liam
