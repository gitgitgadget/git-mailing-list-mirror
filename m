From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH 0/5] git-glossary
Date: Mon, 08 Dec 2014 17:04:46 +0100
Message-ID: <5485CC1E.4010401@drmicha.warpmail.net>
References: <cover.1418052470.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 17:04:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy0ns-0008OY-Ql
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 17:04:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755809AbaLHQEt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 11:04:49 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:35570 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755507AbaLHQEs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Dec 2014 11:04:48 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id C9A1920D49
	for <git@vger.kernel.org>; Mon,  8 Dec 2014 11:04:47 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Mon, 08 Dec 2014 11:04:47 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=vryVZZZmxgNxFBb3KBBZ5Z
	vA27I=; b=HUPV4NG4KOHjxXPtwfYoqwnnpZV0KhthKhIzRD5uxJpOkOfsd46MQB
	TGsE46+GxxhA60k8Je85Bpv54SmaPi3+f1JuD3CCpJupMzL/bwIyMJXXnvCkIs/m
	DBYFqpbtMDkEsNuWGhN4rv1EXizrmMWlHsNmL76VZ8CKVMG/9ImCQ=
X-Sasl-enc: HIdsJRBTVFQBeSCHRV8HyzM6KvBdDI9s7B9m/i8QpWT5 1418054687
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 6A4396801B6
	for <git@vger.kernel.org>; Mon,  8 Dec 2014 11:04:47 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <cover.1418052470.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261051>

Michael J Gruber schrieb am 08.12.2014 um 16:38:
> More and more people use Git in localised setups, which usually means
> mixed localisation setups - not only, but also because of our English
> man pages.
> 
> Here's an attempt at leveraging our current infrastructure for helping
> those poor mixed localisation folks. The idea is to keep the most
> important iterms in the glossary and translate at least these.
> 
> 1/5: generate glossary term list automatically from gitglossary.txt
> 2/5: introduce git-glossary command which helps with lookups
> 3/5: introduce git-glossary.txt, the man page for the command
> 4/5: git.pot update
> 5/5: sample de.po update
> 
> Without 4/5 and 5/5, a few terms from the glossary can be translated
> already by coincidence with localised messages from some git commands.
> 
> Michael J Gruber (5):
>   glossary.h: generate a glossary list from the Makefile
>   glossary: introduce glossary lookup command
>   glossary: man page
>   l10n: git-glossary
>   l10n: de: git-glossary
> 
>  .gitignore                     |    2 +
>  Documentation/git-glossary.txt |   48 ++
>  Makefile                       |    8 +-
>  builtin.h                      |    1 +
>  builtin/glossary.c             |  104 +++
>  command-list.txt               |    1 +
>  generate-glossary.sh           |    8 +
>  git.c                          |    1 +
>  po/de.po                       | 1382 ++++++++++++++++++++++++----------------
>  po/git.pot                     | 1362 +++++++++++++++++++++++----------------
>  10 files changed, 1839 insertions(+), 1078 deletions(-)
>  create mode 100644 Documentation/git-glossary.txt
>  create mode 100644 builtin/glossary.c
>  create mode 100755 generate-glossary.sh

While I did send 5/5 with UTF-8 encoding (or rather: git-sendemail
helpfully did so) it seems it doesn't get through. Anyways, this stuff
is here also:

https://github.com/mjg/git/tree/glossary-cmd

Or rather:

The following changes since commit a0de725a8ff02c1f2a9452c2234bee819242395c:

  Sync with Git 2.2 (2014-11-26 13:20:21 -0800)

are available in the git repository at:

  git://github.com/mjg/git glossary-cmd

for you to fetch changes up to 1265605787662a72c2457be0623a76d4d2a74bc1:

  l10n: de: git-glossary (2014-12-08 16:26:31 +0100)

----------------------------------------------------------------
Michael J Gruber (5):
      glossary.h: generate a glossary list from the Makefile
      glossary: introduce glossary lookup command
      glossary: man page
      l10n: git-glossary
      l10n: de: git-glossary
