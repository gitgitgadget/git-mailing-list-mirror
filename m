From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] doc: show usage of branch description
Date: Mon, 14 Sep 2015 13:01:00 +0100
Organization: OPDS
Message-ID: <DDA818BA5B3749C8953193DEC3682293@PhilipOakley>
References: <74514591d4cd502eee06cde3e099e656@dscho.org> <1442098288-3316-1-git-send-email-philipoakley@iee.org> <CA+P7+xqh0e+2aMZf8i-1hBc0fMgaz0UjVdboLv+L9+rBYBR85w@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>
To: "Jacob Keller" <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 14:00:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbSQU-0003Q6-Bn
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 14:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbbINL76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 07:59:58 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:42144 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751208AbbINL75 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Sep 2015 07:59:57 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2AyCgBftvZVPDopFlxdGQGDCVRpgyqEHLd+hW8EAQMBAYE0TQEBAQEBAQcBAQEBQAEkG4QeBQEBAQECAQgBARkVHgEBIQsCAwUCAQMVAwICBSECAhQBBAgSBgcDFAYTCAIBAgMBiAgDCgwJtg6GWIgrDYRtLIEihVGEfYJQgWsBAVCCcC+BFAWVVwGBF4N1hgSDf5EwhzyEZT0ziT6BPwEBAQ
X-IPAS-Result: A2AyCgBftvZVPDopFlxdGQGDCVRpgyqEHLd+hW8EAQMBAYE0TQEBAQEBAQcBAQEBQAEkG4QeBQEBAQECAQgBARkVHgEBIQsCAwUCAQMVAwICBSECAhQBBAgSBgcDFAYTCAIBAgMBiAgDCgwJtg6GWIgrDYRtLIEihVGEfYJQgWsBAVCCcC+BFAWVVwGBF4N1hgSDf5EwhzyEZT0ziT6BPwEBAQ
X-IronPort-AV: E=Sophos;i="5.17,527,1437433200"; 
   d="scan'208";a="609685869"
Received: from host-92-22-41-58.as13285.net (HELO PhilipOakley) ([92.22.41.58])
  by out1.ip04ir2.opaltelecom.net with SMTP; 14 Sep 2015 12:59:54 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277816>

From: "Jacob Keller" <jacob.keller@gmail.com>
> Hi,
>
> On Sat, Sep 12, 2015 at 3:51 PM, Philip Oakley <philipoakley@iee.org> 
> wrote:
>> The branch description will be included in 'git format-patch
>> --cover-letter' and in 'git pull-request' emails. Tell the reader.
>>
>> While here, clarify that the description may be a multi-line
>> explanation of the purpose of the branch's patch series.
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>>
>> This is a short doc patch to follow up $gmane/277628 where Johannes
>> Schindelin noted this otherwise undocumented feature.
>>
>
> Thanks for this.
>
>>
>>  Documentation/git-branch.txt       | 3 ++-
>>  Documentation/git-format-patch.txt | 2 +-
>>  Documentation/git-request-pull.txt | 3 ++-
>>  3 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/git-branch.txt 
>> b/Documentation/git-branch.txt
>> index a67138a..79ad1c7 100644
>> --- a/Documentation/git-branch.txt
>> +++ b/Documentation/git-branch.txt
>> @@ -197,7 +197,8 @@ start-point is either a local or remote-tracking 
>> branch.
>>
>>  --edit-description::
>>         Open an editor and edit the text to explain what the branch 
>> is
>> -       for, to be used by various other commands (e.g. 
>> `request-pull`).
>> +       for, to be used by various other commands (e.g. 
>> `format-patch`
>> +       and `request-pull`). Multi-line explanations may be used.
>>
>
> Are these the only locations? Just want to make sure while we're 
> updating it.

Searching for 'description' has many hits so it's not easy to be really 
sure. I had thought I'd asked an SO question ($SO/q/6866838) about 
branch descriptions many years ago, whose answers indicated it was 
little used, but actually I'd asked about the repo description (doh) 
which AFAICT is only used by gitweb.

A bit more delving found http://stackoverflow.com/a/8858853/717355 which 
suggests `git merge` would use it, but with no mention in the `git 
merge --help` man page. A link to the `git fmt-merge-msg` ("for internal 
use by scripts") finally provides the extra:

merge.branchdesc

In addition to branch names, populate the log message with the branch 
description text associated with them. Defaults to false.

However, that config key isn't listed in `git config --help` man page, 
so that capability is a bit buried. (note the default!)



It still means that my patch is incomplete in its aim to bring out these 
possible broader usages.


I haven't yet looked at the mail archives to see if there is more around 
the time of those introductions.

>
> Otherwise, for what it's worth...
>
> Acked-by: Jacob Keller <jacob.keller@gmail.com>
>
For the future, it would also be nice to allow some use within `git 
branch` for a `--show[-full]-description` option such that when branch 
info is being given (-a, -l, etc), then the descriptions for the local 
branches (which may have descriptions) are displayed, either as a single 
first line, or as a full multi-line description. But that's coding & 
review for the future. 
