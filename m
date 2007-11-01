From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-diff.txt: add section "output format" describing the diff formats
Date: Wed, 31 Oct 2007 23:33:59 -0700
Message-ID: <7vir4mcw4o.fsf@gitster.siamese.dyndns.org>
References: <20071031135916.5625.qmail@134c5e95d8ec4d.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Thu Nov 01 07:34:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InTdH-0002ci-LK
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 07:34:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755972AbXKAGeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 02:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755838AbXKAGeG
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 02:34:06 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:39675 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755547AbXKAGeF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 02:34:05 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id D52442EF;
	Thu,  1 Nov 2007 02:34:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 585C38F18C;
	Thu,  1 Nov 2007 02:34:23 -0400 (EDT)
In-Reply-To: <20071031135916.5625.qmail@134c5e95d8ec4d.315fe32.mid.smarden.org>
	(Gerrit Pape's message of "Wed, 31 Oct 2007 13:59:16 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62922>

Gerrit Pape <pape@smarden.org> writes:

> diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
> index 0015032..a580f18 100644
> --- a/Documentation/diff-format.txt
> +++ b/Documentation/diff-format.txt
> @@ -1,5 +1,5 @@
> -The output format from "git-diff-index", "git-diff-tree" and
> -"git-diff-files" are very similar.
> +The output format from "git-diff-index", "git-diff-tree",
> +"git-diff-files" and "git diff --raw" are very similar.

I like this attention to the detail of mentioning "--raw".

> @@ -62,9 +62,9 @@ respectively.
>  diff format for merges
>  ----------------------
>  
> -"git-diff-tree" and "git-diff-files" can take '-c' or '--cc' option
> -to generate diff output also for merge commits.  The output differs
> -from the format described above in the following way:
> +"git-diff-tree", "git-diff-files" and "git-diff" can take '-c' or
> +'--cc' option to generate diff output also for merge commits.  The
> +output differs from the format described above in the following way:

... and this part should do so, too. 
