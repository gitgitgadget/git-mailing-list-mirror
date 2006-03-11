From: Junio C Hamano <junkio@cox.net>
Subject: Re: annotate.perl triggers rpm bug
Date: Fri, 10 Mar 2006 23:11:01 -0800
Message-ID: <7v64mlxxq2.fsf@assigned-by-dhcp.cox.net>
References: <BAYC1-PASMTP0815EFABBF5266FB641C65AEED0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 11 08:11:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHyFq-0002pF-D6
	for gcvg-git@gmane.org; Sat, 11 Mar 2006 08:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbWCKHLE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Mar 2006 02:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbWCKHLE
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Mar 2006 02:11:04 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:6621 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751634AbWCKHLD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Mar 2006 02:11:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060311070940.ERCP15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 11 Mar 2006 02:09:40 -0500
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP0815EFABBF5266FB641C65AEED0@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Fri, 10 Mar 2006 16:23:20 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17496>

sean <seanlkml@sympatico.ca> writes:

> ....   RPM automatically creates a dependency for any
> perl "use" lines, and the above commit fools it into creating a false 
> dependecy...

Sheesh -- broken packaging.

> diff --git a/git-annotate.perl b/git-annotate.perl
> index feea0a2..6805b8b 100755
> --- a/git-annotate.perl
> +++ b/git-annotate.perl
> @@ -20,7 +20,7 @@ sub usage() {
>         -r, --rename
>                         Follow renames (Defaults on).
>         -S, --rev-file revs-file
> -                       use revs from revs-file instead of calling git-rev-list
> +                       uses revs from revs-file instead of calling git-rev-list
>         -h, --help
>                         This message.
>  ';

How about upcasing the word like other lines?
