From: David Kastrup <dak@gnu.org>
Subject: Re: [install info (using perl) 1/2] Add support for an info version of the user manual
Date: Thu, 09 Aug 2007 01:46:21 +0200
Message-ID: <85abt1pp2q.fsf@lola.goethe.zz>
References: <591c5679ea79b76cd5db57443b1d691bde842351.1186484406.git.dak@gnu.org>
	<7vabt11vkj.fsf@assigned-by-dhcp.cox.net>
	<7v643p1vbr.fsf@assigned-by-dhcp.cox.net>
	<7v1wed1up3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 01:46:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIvEU-0007JC-1B
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 01:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763275AbXHHXqZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 19:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763593AbXHHXqZ
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 19:46:25 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:46788 "EHLO
	mail-in-07.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763106AbXHHXqX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Aug 2007 19:46:23 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id A130E24B17A;
	Thu,  9 Aug 2007 01:46:22 +0200 (CEST)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id 9234B13EDB6;
	Thu,  9 Aug 2007 01:46:22 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-025-080.pools.arcor-ip.net [84.61.25.80])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 7E0AD1BF3A1;
	Thu,  9 Aug 2007 01:46:22 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id D54241C3C79D; Thu,  9 Aug 2007 01:46:21 +0200 (CEST)
In-Reply-To: <7v1wed1up3.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Wed\, 08 Aug 2007 16\:18\:48 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3900/Wed Aug  8 22:55:59 2007 on mail-in-04.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55399>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
> How about doing something like this instead?
>

> ---
>
>  Documentation/Makefile      |   13 ++++---------
>  Documentation/fix-texi.perl |   15 +++++++++++++++
>  2 files changed, 19 insertions(+), 9 deletions(-)
>  create mode 100755 Documentation/fix-texi.perl
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 56d12aa..8c33729 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile

> new file mode 100755
> index 0000000..ff7d78f
> --- /dev/null
> +++ b/Documentation/fix-texi.perl

[...]

It makes Perl look like a programming language instead of line noise.
But putting it into a file with .perl extension will make users
recognize it nevertheless.  So

Acked-by: David Kastrup <dak@gnu.org>

I can fold this patch in and repost (probably not too many people have
applied the previous patches and would require a good fast forward
path, so one would probably not need a 3-commit version built on top
of the existing patches), or you may do so at your discretion.

Thanks, looks much nicer.  I still hope to rationalize Perl away
altogether at some point of time, but...

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
