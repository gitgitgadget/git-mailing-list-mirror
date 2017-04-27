Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6182D207E4
	for <e@80x24.org>; Thu, 27 Apr 2017 09:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031516AbdD0JJV (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 05:09:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:34700 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031467AbdD0JJT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 05:09:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2D2B375012;
        Thu, 27 Apr 2017 09:09:18 +0000 (UTC)
Subject: Re: [PATCH] Add --indent-heuristic to bash completion.
To:     Stefan Beller <sbeller@google.com>
References: <bbcbdf11-5065-8fcb-d78e-74db03814781@suse.cz>
 <CAGZ79kY2dmec17qdbpTqOx7Uro7X_UAyo0be5a08bdZyykA2nw@mail.gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Message-ID: <71692231-0a76-99f7-3577-9076b0f2e8ad@suse.cz>
Date:   Thu, 27 Apr 2017 11:09:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kY2dmec17qdbpTqOx7Uro7X_UAyo0be5a08bdZyykA2nw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/26/2017 09:38 PM, Stefan Beller wrote:
> On Tue, Apr 25, 2017 at 4:37 AM, Martin Liška <mliska@suse.cz> wrote:
>> Hello.
>>
>> The patch adds BASH completion for a newly added option.
>>
> 
> The looks good, though the format is unusual. (We prefer the
> format to be inline instead of an attachment)

Good, adding inline version.
I've read Documentation/SubmittingPatches, can you please help me which
maintainer should I CC?

Martin
---
 contrib/completion/git-completion.bash | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1150164d5..8fb25594c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1395,7 +1395,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--quiet --ext-diff --no-ext-diff
 			--no-prefix --src-prefix= --dst-prefix=
 			--inter-hunk-context=
-			--patience --histogram --minimal
+			--patience --histogram --indent-heuristic --minimal
 			--raw --word-diff --word-diff-regex=
 			--dirstat --dirstat= --dirstat-by-file
 			--dirstat-by-file= --cumulative
@@ -1482,6 +1482,7 @@ __git_format_patch_options="
 	--not --all --cover-letter --no-prefix --src-prefix= --dst-prefix=
 	--inline --suffix= --ignore-if-in-upstream --subject-prefix=
 	--output-directory --reroll-count --to= --quiet --notes
+	--indent-heuristic
 "
 
 _git_format_patch ()
@@ -1681,6 +1682,7 @@ __git_log_common_options="
 	--min-age= --until= --before=
 	--min-parents= --max-parents=
 	--no-min-parents --no-max-parents
+	--indent-heuristic
 "
 # Options that go well for log and gitk (not shortlog)
 __git_log_gitk_options="
-- 
2.12.2
