From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [Patch 3/5] Create html documents for all files in Documentation/RelNotes
Date: Sat, 6 Oct 2012 19:48:49 +0100
Organization: OPDS
Message-ID: <24F38BF6C67443D5873EEAAD758D03A4@PhilipOakley>
References: <505841759.269631.1349538675925.JavaMail.ngmail@webmail08.arcor-online.net> <343092834.269729.1349538958985.JavaMail.ngmail@webmail08.arcor-online.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Thomas Ackermann" <th.acker66@arcor.de>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 06 20:48:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKZQp-0000K6-GI
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 20:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755367Ab2JFSss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2012 14:48:48 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:55470 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755180Ab2JFSsq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Oct 2012 14:48:46 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqsMAGZ8cFBcGnKf/2dsb2JhbABFi1CyRAECgQuBCYIbBQEBBAEIAQEuHgEBJgYCAwUCAQMOBwwlFAEEGgYHFwYBEggCAQIDAYdiAwkKrzIFiVyKaYFKAneDU2ADiCOFRpgwgm4
X-IronPort-AV: E=Sophos;i="4.80,545,1344207600"; 
   d="scan'208";a="395691528"
Received: from host-92-26-114-159.as13285.net (HELO PhilipOakley) ([92.26.114.159])
  by out1.ip05ir2.opaltelecom.net with SMTP; 06 Oct 2012 19:48:44 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207166>

From: "Thomas Ackermann" <th.acker66@arcor.de>
>- create html for all release note files
> - fix some asciidoc layout problems
>
> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---
> Documentation/Makefile             | 2 ++
> Documentation/RelNotes/1.5.2.1.txt | 6 ------
> Documentation/RelNotes/1.6.0.2.txt | 6 ------
> Documentation/RelNotes/1.6.1.3.txt | 4 ----
> Documentation/RelNotes/1.6.1.4.txt | 3 ---
> Documentation/RelNotes/1.6.1.txt   | 6 ------
> 6 files changed, 2 insertions(+), 25 deletions(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 86594f6..80eb06d 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -24,6 +24,7 @@ SP_ARTICLES = user-manual
> SP_ARTICLES += howto/revert-branch-rebase
> SP_ARTICLES += howto/using-merge-subtree
> SP_ARTICLES += howto/using-signed-tag-in-pull-request
> +RELNOTES = $(patsubst %.txt,%,$(wildcard RelNotes/*.txt))
> API_DOCS = $(patsubst %.txt,%,$(filter-out 
> technical/api-index-skel.txt technical/api-index.txt, $(wildcard 
> technical/api-*.txt)))
> API_DOCS += technical/index-format
> API_DOCS += technical/pack-format
> @@ -35,6 +36,7 @@ API_DOCS += technical/racy-git
> API_DOCS += technical/send-pack-pipeline
> API_DOCS += technical/shallow
> API_DOCS += technical/trivial-merge
> +API_DOCS += $(RELNOTES)

Again, is this the right docs list?

> SP_ARTICLES += $(API_DOCS)
> SP_ARTICLES += technical/api-index
>
<snip> 
