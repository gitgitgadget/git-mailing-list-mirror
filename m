From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] Improve --patch option documentation in git-add (updated patch)
Date: Tue, 15 Sep 2009 15:52:08 +0900
Message-ID: <20090915155208.6117@nanako3.lavabit.com>
References: <87ocpxb46g.fsf@jondo.cante.net>
	<7vab1hdppb.fsf@alter.siamese.dyndns.org>
	<87tyzp9da4.fsf@jondo.cante.net>
	<7vskf954sr.fsf@alter.siamese.dyndns.org>
	<87ab1gaol2.fsf@jondo.cante.net>
	<7vbplw28js.fsf@alter.siamese.dyndns.org>
	<87y6p08lz5.fsf@jondo.cante.net>
	<7vmy5fy2hz.fsf@alter.siamese.dyndns.org>
	<87ab0zny27.fsf_-_@jondo.cante.net>
	<237967ef0909130648l36b592aft9c50ccff5d03d1b1@mail.gmail.com>
	<87vdjnlywo.fsf@jondo.cante.net>
	<BLU0-SMTP18292B09CCFD873F4A6DF6AEE40@phx.gbl>
	<87fxaolqhd.fsf_-_@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Sean Estabrooks <seanlkml@sympatico.ca>,
	Mikael Magnusson <mikachu@gmail.com>, git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Tue Sep 15 08:53:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnRuR-0005nb-Hu
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 08:53:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757171AbZIOGwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 02:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756898AbZIOGwx
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 02:52:53 -0400
Received: from karen.lavabit.com ([72.249.41.33]:49170 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756890AbZIOGwx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 02:52:53 -0400
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id D5FB311B853;
	Tue, 15 Sep 2009 01:52:56 -0500 (CDT)
Received: from 8314.lavabit.com (delhi-202.54.61-99.vsnl.net.in [202.54.61.99])
	by lavabit.com with ESMTP id RJ2UNHGWCX0W; Tue, 15 Sep 2009 01:52:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=rrSZhVSfHRWuSbI3aTF8ZrG5PigHpEyo32vsrNz8C4JV7jy1QSWef5xD3uwgpgNxPywghqaMWan5ACnKx7MY/GZG+XfEUqhyui3kcF8c/CHf0QiOt9+cx0jnrACH//gxQ//kqSDS6hWBiznGGJVVzLsCWHev5JsgWFYDbTxgwM8=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <87fxaolqhd.fsf_-_@jondo.cante.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128518>

Quoting Jari Aalto <jari.aalto@cante.net>

> Sean Estabrooks <seanlkml@sympatico.ca> writes:
>> ... To me though, it seems more difficult to parse this description
>> than the one offered by Junio in an earlier thread ...perhaps you'd
>> consider something closer to yours, such as:
>>
>> 	Interactively review the differences between the index and the
>> 	work tree and choose which hunks to add into the index.
>>
>> 	This effectively runs ``add --interactive``, but bypasses the
>> 	initial command menu and jumps directly to the `patch` subcommand.
>> 	See ``Interactive mode'' for details.
>
>
> Updated, thanks,
> Jari
>
>
> From be5eebc53c2e3dcf67edfb371d8aa8263e1a8d69 Mon Sep 17 00:00:00 2001
> From: Jari Aalto <jari.aalto@cante.net>
> Date: Tue, 15 Sep 2009 08:33:51 +0300
> Subject: [PATCH] Improve --patch option documentation in git-add
>
> Signed-off-by: Jari Aalto <jari.aalto@cante.net>
> ---
>  Documentation/git-add.txt |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index e67b7e8..c57895a 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -72,9 +72,12 @@ OPTIONS
>  
>  -p::
>  --patch::
> -	Similar to Interactive mode but the initial command loop is
> -	bypassed and the 'patch' subcommand is invoked using each of
> -	the specified filepatterns before exiting.
> +	Interactively review the differences between the index and the
> +	work tree and choose which hunks to add into the index.
> +
> +	This effectively runs ``add --interactive``, but bypasses the
> +	initial command menu and jumps directly to the `patch` subcommand.
> +	See ``Interactive mode'' for details.
>  
>  -e, \--edit::
>  	Open the diff vs. the index in an editor and let the user

Sorry, but this patch doesn't seem to apply anywhere. Have you fetched recently?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
