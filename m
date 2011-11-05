From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] fsck: print progress
Date: Sat, 05 Nov 2011 00:53:20 -0700
Message-ID: <4EB4EB70.40801@gmail.com>
References: <20111103211819.GA17341@sigill.intra.peff.net> <1320376242-27851-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 05 08:57:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMb7l-0005eD-Cr
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 08:57:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201Ab1KEHxY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Nov 2011 03:53:24 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58807 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862Ab1KEHxY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 03:53:24 -0400
Received: by ywf7 with SMTP id 7so3310953ywf.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 00:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=jMnCzBr4JzejHAgD3LGV/KBfvlZ9UU7bY43zSuweCKk=;
        b=vZP8JnjXWBlZRfaEYg7B7te4Wzin5WFnIxKwdgiGpq9oLi0rvvqxmAGO8G9GlLGT6m
         pLa9sHM/+9+nAgFRFrKUPk/Ss/x2h7B33x8OVWzGqfpqut+9VFZAwFJ/4ous76Prdv7+
         ISsUwABZjOytjQ3nkihWUivPSy2cot8uSgI04=
Received: by 10.50.197.227 with SMTP id ix3mr19730166igc.51.1320479603272;
        Sat, 05 Nov 2011 00:53:23 -0700 (PDT)
Received: from [192.168.2.10] (ip68-105-100-241.sd.sd.cox.net. [68.105.100.241])
        by mx.google.com with ESMTPS id a4sm4288217pbd.7.2011.11.05.00.53.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Nov 2011 00:53:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110911 Thunderbird/6.0
In-Reply-To: <1320376242-27851-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184834>

On 11/03/2011 08:10 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote=
:
> diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
[...]
> +--progress::
> +--no-progress::
> +	When fsck is run in a terminal, it will show the progress.
> +	These options can force progress to be shown or not
> +	regardless terminal check.

Can we reuse the --progress description in fetch-options.txt (minus the=
 q)?

--[no]-progress::
        Progress status is reported on the standard error stream
        by default when it is attached to a terminal. This flag
	forces progress status even if the standard error stream
	is not directed to a terminal.


> ++
> +Progress is not shown when --verbose is used. --progress is ignored
> +in this case.

What progress isn't shown? How about

	If --verbose is used with --progress the progress status
	will not be shown.
