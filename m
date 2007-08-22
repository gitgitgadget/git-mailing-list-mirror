From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Wed, 22 Aug 2007 18:20:30 +0200
Message-ID: <20070822162030.GB3528@steel.home>
References: <46CC3090.7080500@gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 18:21:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INsxN-000891-C1
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 18:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbXHVQUg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 12:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765102AbXHVQUf
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 12:20:35 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:57019 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765073AbXHVQUd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 12:20:33 -0400
Received: from tigra.home (Fad89.f.strato-dslnet.de [195.4.173.137])
	by post.webmailer.de (fruni mo45) (RZmta 10.3)
	with ESMTP id 601bbaj7MFvlKX ; Wed, 22 Aug 2007 18:20:31 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 16453277BD;
	Wed, 22 Aug 2007 18:20:31 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id E7C7CBE01; Wed, 22 Aug 2007 18:20:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46CC3090.7080500@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyClFiUp4=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56396>

Carlos Rica, Wed, Aug 22, 2007 14:48:16 +0200:
> This is the first version of the program "builtin-reset.c",
> intended for replacing the script "git-reset.sh".

Very nice code :)

> +	obj = deref_tag(parse_object(sha1), sha1_to_hex(sha1), 40);
> +	if (!obj)
> +		die("Could not parse object '%s'.", rev);
> +	memcpy(sha1, obj->sha1, sizeof(sha1));

You might consider using hashcpy
