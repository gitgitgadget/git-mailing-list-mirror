From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: Re: [PATCH] Documentation: update-index: -z applies also to --index-info
Date: Thu, 07 Oct 2010 21:36:31 +0200
Message-ID: <87ocb5u75s.fsf@gmail.com>
References: <AANLkTimsJ+uG7KhiBMii8szFYmbXo5OjAkYgs99_Hjzr@mail.gmail.com>
	<081ad1459d5b1584cbe474581bd3a01d0d58d11d.1286477945.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 21:37:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3wHm-0005k3-78
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 21:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754788Ab0JGThj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 15:37:39 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58258 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754785Ab0JGThf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 15:37:35 -0400
Received: by bwz11 with SMTP id 11so166816bwz.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 12:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject
         :in-reply-to:references:user-agent:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=ELMxNW0JgJP7lDVC0GMHT+IIKer3EizLxXQEWT9a70g=;
        b=RrlqB0RFt6fUTeDaclGxv2LwPwCzzsmot+pWP1ksJq2pQVBn4oGB8y3nzxgFUSVPm9
         jAk3LXq/aRABHAk64kwziuHSKjkLZFz+0Fe5FVNZnxtklpgezMNBJQ+X8KSHZ79nYUrG
         DCEFKFNvfoqnkGOHD8xanzSwM7mhppw4MxqSY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        b=XC7ni0YvFIUDPO0oRLZu2UkP4/Kytt3U8n5r2w/pTCFC63XQJQGVlCKvDYIZ8NvfO9
         +vPpB2AKUUvDs0tZcVSWLkbPIuziNkz/IVxvxubRxgp2VVlQBwrYYBHrj7U6+CLjlYW4
         K4PZji3tPz0QJxeqcoibIbSp694DxPGjDYzdA=
Received: by 10.204.58.75 with SMTP id f11mr1045396bkh.138.1286480253715;
        Thu, 07 Oct 2010 12:37:33 -0700 (PDT)
Received: from localhost (176.119.broadband10.iol.cz [90.177.119.176])
        by mx.google.com with ESMTPS id y19sm1922894bkw.6.2010.10.07.12.37.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 Oct 2010 12:37:32 -0700 (PDT)
In-Reply-To: <081ad1459d5b1584cbe474581bd3a01d0d58d11d.1286477945.git.bert.wesarg@googlemail.com>
	(Bert Wesarg's message of "Thu, 7 Oct 2010 20:59:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158447>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> Also mention, that --stdin and --index-info needs to be the last
> option supplied and indicate this in the usage string.
>
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> ---
>  Documentation/git-update-index.txt |   13 +++++++------
>  builtin/update-index.c             |    2 +-
>  2 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-update-index.txt
> b/Documentation/git-update-index.txt
> index 74d1d49..022c0fc 100644 Documentation/git-update-index.txt
> --- a/Documentation/git-update-index.txt
> +++ b/Documentation/git-update-index.txt
> @@ -18,10 +18,10 @@ SYNOPSIS
>  	     [--skip-worktree | --no-skip-worktree]
>  	     [--ignore-submodules]
>  	     [--really-refresh] [--unresolve] [--again | -g]
> -	     [--info-only] [--index-info]
> -	     [-z] [--stdin]
> +	     [--info-only]
>  	     [--verbose]
> -	     [--] [<file>]*
> +	     [[-z] --stdin | --index-info]
> +	     [--] [<file>]

If you want to remove the asterisk after all, then please make it
`<file>...', not `[<file>]'.

=C5=A0t=C4=9Bp=C3=A1n
