From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] Documentation: diff-filter=T only tests for symlink changes
Date: Sat, 18 Oct 2008 22:40:45 +0900
Message-ID: <20081018224045.6117@nanako3.lavabit.com>
References: <87vdvq5lu4.fsf_-_@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Sat Oct 18 15:46:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrC8R-0001YD-4U
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 15:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbYJRNpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 09:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbYJRNpL
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 09:45:11 -0400
Received: from karen.lavabit.com ([72.249.41.33]:48585 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751359AbYJRNpK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 09:45:10 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 7BB7CC7B09;
	Sat, 18 Oct 2008 08:45:09 -0500 (CDT)
Received: from 6585.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id 6IM8I7BPFBA3; Sat, 18 Oct 2008 08:45:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=wZnHoaAu6le8BVcNTSV8BS3E5wdDuzHMbS43jBD/2SJCPgVYMDhCfted8LQjjjRqPAqbbnfaSYkwIHIebv6zEzjEU4v0j2CqPjZ5aMsY50sODnhQYp3bnCa2EawqlR2mTsar553Sg4ock+BSVd9fsyrk2dldGrsNsf5TJ9wpREI=;
  h=From:To:Cc:Date:Subject:In-reply-to:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-reply-to: <87vdvq5lu4.fsf_-_@cup.kalibalik.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98549>

Quoting Anders Melchiorsen <mail@cup.kalibalik.dk>:

> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 7788d4f..7604a13 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -137,7 +137,7 @@ endif::git-format-patch[]
>  --diff-filter=[ACDMRTUXB*]::
>  	Select only files that are Added (`A`), Copied (`C`),
>  	Deleted (`D`), Modified (`M`), Renamed (`R`), have their
> -	type (mode) changed (`T`), are Unmerged (`U`), are
> +	type (symlink/regular file) changed (`T`), are Unmerged (`U`), are
>  	Unknown (`X`), or have had their pairing Broken (`B`).
>  	Any combination of the filter characters may be used.
>  	When `*` (All-or-none) is added to the combination, all
> -- 
> 1.6.0.2.514.g23abd3

Are symlinks and regular files the only kind of object you can see in diff? What happens when a file or directory changes to a submodule?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
