From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] doc: show usage of branch description
Date: Mon, 14 Sep 2015 14:24:09 +0100
Organization: OPDS
Message-ID: <114A566297E948AFA2962DB352AD46A8@PhilipOakley>
References: <74514591d4cd502eee06cde3e099e656@dscho.org> <1442098288-3316-1-git-send-email-philipoakley@iee.org> <CA+P7+xqh0e+2aMZf8i-1hBc0fMgaz0UjVdboLv+L9+rBYBR85w@mail.gmail.com> <DDA818BA5B3749C8953193DEC3682293@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=response
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>
To: "Philip Oakley" <philipoakley@iee.org>,
	"Jacob Keller" <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 15:24:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbTk9-0008Pp-2k
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 15:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942AbbINNYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 09:24:21 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:38112 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751127AbbINNYU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Sep 2015 09:24:20 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CyKwAWyvZVPDopFlxdGQEBAYMHVFsOgyqEHLd+hW8EAQMBAYE2TQEBAQEBAQcBAQEBQAE/QQECAoNYBQEBAQECAQgBARkVHgEBIQsCAwUCAQMVAwICBSECAhQBBAgSBgcDFAYBEggCAQIDAYgIAwoMCbV/hliIMQ2EbQEBCAIBH4EihVGEfYJQgj2CcC+BFAWVVwGBF4N1hgSDf5Ewhm5OhGU9M4NQKIQEgwEBAQE
X-IPAS-Result: A2CyKwAWyvZVPDopFlxdGQEBAYMHVFsOgyqEHLd+hW8EAQMBAYE2TQEBAQEBAQcBAQEBQAE/QQECAoNYBQEBAQECAQgBARkVHgEBIQsCAwUCAQMVAwICBSECAhQBBAgSBgcDFAYBEggCAQIDAYgIAwoMCbV/hliIMQ2EbQEBCAIBH4EihVGEfYJQgj2CcC+BFAWVVwGBF4N1hgSDf5Ewhm5OhGU9M4NQKIQEgwEBAQE
X-IronPort-AV: E=Sophos;i="5.17,528,1437433200"; 
   d="scan'208";a="248162923"
Received: from host-92-22-41-58.as13285.net (HELO PhilipOakley) ([92.22.41.58])
  by out1.ip07ir2.opaltelecom.net with SMTP; 14 Sep 2015 14:23:44 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277819>

From: "Philip Oakley" <philipoakley@iee.org>
> From: "Jacob Keller" <jacob.keller@gmail.com>
>> Hi,
>>
>> On Sat, Sep 12, 2015 at 3:51 PM, Philip Oakley <philipoakley@iee.org> 
>> wrote:
>>> The branch description will be included in 'git format-patch
>>> --cover-letter' and in 'git pull-request' emails. Tell the reader.
[...]
>> Are these the only locations? Just want to make sure while we're 
>> updating it.
>
> A bit more delving found http://stackoverflow.com/a/8858853/717355 
> which suggests `git merge` would use it, but with no mention in the 
> `git merge --help` man page. A link to the `git fmt-merge-msg` ("for 
> internal use by scripts") finally provides the extra:
>
> merge.branchdesc
>
> In addition to branch names, populate the log message with the branch 
> description text associated with them. Defaults to false.
>
> However, that config key isn't listed in `git config --help` man page, 
> so that capability is a bit buried. (note the default!)

This is incorrect. It was fixed in fc0aa39 (Documentation: include 
'merge.branchdesc' for merge and config as well, 2015-05-27), but my 
local docs hadn't included it.

>
> It still means that my patch is incomplete in its aim to bring out 
> these possible broader usages.
>
i.e. mentioning 'merge' as a command that uses the branch description, 
and noting it within the merge pages.
