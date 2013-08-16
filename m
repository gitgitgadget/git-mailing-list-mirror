From: Mattias =?UTF-8?B?QW5kcsOpZQ==?= <maandree@member.fsf.org>
Subject: Re: [PATCH] CET is only one hour ahead of UTC
Date: Fri, 16 Aug 2013 12:58:20 +0200
Message-ID: <20130816125820.2adb2a8e.maandree@kth.se>
References: <1376649800-442-1-git-send-email-maandree@operamail.com>
	<1376650451-2440-1-git-send-email-maandree@operamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mattias =?UTF-8?B?QW5kcsOpZQ==?= <maandree@operamail.com>
X-From: git-owner@vger.kernel.org Fri Aug 16 12:58:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAHjk-0000a0-K8
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 12:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541Ab3HPK60 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Aug 2013 06:58:26 -0400
Received: from smtp-4.sys.kth.se ([130.237.48.193]:54305 "EHLO
	smtp-4.sys.kth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753375Ab3HPK6Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Aug 2013 06:58:25 -0400
Received: from mailscan-2.sys.kth.se (mailscan-2.sys.kth.se [130.237.48.169])
	by smtp-4.sys.kth.se (Postfix) with ESMTP id EA38A1FE6;
	Fri, 16 Aug 2013 12:58:23 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at kth.se
Received: from smtp-4.sys.kth.se ([130.237.48.193])
	by mailscan-2.sys.kth.se (mailscan-2.sys.kth.se [130.237.48.169]) (amavisd-new, port 10024)
	with LMTP id ihx1CTRql4_S; Fri, 16 Aug 2013 12:58:22 +0200 (CEST)
X-KTH-Auth: maandree [193.150.208.92]
X-KTH-mail-from: maandree@member.fsf.org
Received: from localhost.localdomain (c193-150-208-92.bredband.comhem.se [193.150.208.92])
	by smtp-4.sys.kth.se (Postfix) with ESMTPSA id 43ED01FDE;
	Fri, 16 Aug 2013 12:58:21 +0200 (CEST)
In-Reply-To: <1376650451-2440-1-git-send-email-maandree@operamail.com>
X-Mailer: Claws Mail 3.9.2 (GTK+ 2.24.20; x86_64-unknown-linux-gnu)
X-Awesomeness: 120 %
User-Agent: Claws Mail
X-Operating-System: GNU/Linux
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232419>

On Fri, 16 Aug 2013 12:54:11 +0200
Mattias Andr=C3=A9e <maandree@operamail.com> wrote:

> Signed-off-by: Mattias Andr=C3=A9e <maandree@operamail.com>
> ---
>  man1/git-commit-tree.1 | 6 +++---
>  man1/git-commit.1      | 6 +++---
>  man1/git-tag.1         | 6 +++---
>  3 files changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/man1/git-commit-tree.1
> b/man1/git-commit-tree.1 index 2014cc3..1bef965 100644
> --- a/man1/git-commit-tree.1
> +++ b/man1/git-commit-tree.1
> @@ -148,14 +148,14 @@ It is
>  <unix timestamp>
>  is the number of seconds since the UNIX epoch\&.
>  <timezone offset>
> -is a positive or negative offset from UTC\&. For example
> CET (which is 2 hours ahead UTC) is -+0200\&.
> +is a positive or negative offset from UTC\&. For example
> CET (which is 1 hour ahead UTC) is ++0100\&.
>  .RE
>  .PP
>  RFC 2822
>  .RS 4
>  The standard email format as described by RFC 2822, for
> example -Thu, 07 Apr 2005 22:13:13 +0200\&.
> +Thu, 07 Apr 2005 22:13:13 +0100\&.
>  .RE
>  .PP
>  ISO 8601
> diff --git a/man1/git-commit.1 b/man1/git-commit.1
> index 7d80bbd..c61ffaf 100644
> --- a/man1/git-commit.1
> +++ b/man1/git-commit.1
> @@ -481,14 +481,14 @@ It is
>  <unix timestamp>
>  is the number of seconds since the UNIX epoch\&.
>  <timezone offset>
> -is a positive or negative offset from UTC\&. For example
> CET (which is 2 hours ahead UTC) is -+0200\&.
> +is a positive or negative offset from UTC\&. For example
> CET (which is 1 hour ahead UTC) is ++0100\&.
>  .RE
>  .PP
>  RFC 2822
>  .RS 4
>  The standard email format as described by RFC 2822, for
> example -Thu, 07 Apr 2005 22:13:13 +0200\&.
> +Thu, 07 Apr 2005 22:13:13 +0100\&.
>  .RE
>  .PP
>  ISO 8601
> diff --git a/man1/git-tag.1 b/man1/git-tag.1
> index c6d9be5..f6be47b 100644
> --- a/man1/git-tag.1
> +++ b/man1/git-tag.1
> @@ -337,14 +337,14 @@ It is
>  <unix timestamp>
>  is the number of seconds since the UNIX epoch\&.
>  <timezone offset>
> -is a positive or negative offset from UTC\&. For example
> CET (which is 2 hours ahead UTC) is -+0200\&.
> +is a positive or negative offset from UTC\&. For example
> CET (which is 1 hour ahead UTC) is ++0100\&.
>  .RE
>  .PP
>  RFC 2822
>  .RS 4
>  The standard email format as described by RFC 2822, for
> example -Thu, 07 Apr 2005 22:13:13 +0200\&.
> +Thu, 07 Apr 2005 22:13:13 +0100\&.
>  .RE
>  .PP
>  ISO 8601

I when on a limb and assumed that these patches for
git-htmldocs and git-manpages, respectively, should
also be sent to git@ as I could not find any other
mailing list for them.
