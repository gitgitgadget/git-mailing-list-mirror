From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 5/5] Migrate git-am.sh to use git-rev-parse --parseopt
Date: Sat, 3 Nov 2007 10:55:56 +0100
Message-ID: <20071103095556.GB2853@steel.home>
References: <1194043193-29601-1-git-send-email-madcoder@debian.org> <1194043193-29601-2-git-send-email-madcoder@debian.org> <1194043193-29601-3-git-send-email-madcoder@debian.org> <1194043193-29601-4-git-send-email-madcoder@debian.org> <1194043193-29601-5-git-send-email-madcoder@debian.org> <1194043193-29601-6-git-send-email-madcoder@debian.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, torvalds@linux-foundation.org,
	git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sat Nov 03 10:56:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoFjl-0003Bc-PD
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 10:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753563AbXKCJ4B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 05:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752556AbXKCJ4A
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 05:56:00 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:38787 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188AbXKCJ4A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 05:56:00 -0400
Received: from tigra.home (Fcb01.f.strato-dslnet.de [195.4.203.1])
	by post.webmailer.de (mrclete mo37) (RZmta 14.0)
	with ESMTP id 401b9fjA35qN8S ; Sat, 3 Nov 2007 10:55:56 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 97CB5277AE;
	Sat,  3 Nov 2007 10:55:56 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 3CE9056D22; Sat,  3 Nov 2007 10:55:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1194043193-29601-6-git-send-email-madcoder@debian.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBtu
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63225>

Pierre Habouzit, Fri, Nov 02, 2007 23:39:52 +0100:
> diff --git a/git-am.sh b/git-am.sh
> index 2514d07..e5ed6a7 100755
> --- a/git-am.sh
> +++ b/git-am.sh
...
> -	usage ;;
> -	*)
> -	break ;;
> +		-i|--interactive)
> +			interactive=t ;;
> +		-b|--binary)
> +			binary=t ;;

Did you really have to change the indentation?
