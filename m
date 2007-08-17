From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] git-submodule: re-enable 'status' as the default subcommand
Date: Fri, 17 Aug 2007 11:09:47 +0200
Message-ID: <20070817090947.GG1070MdfPADPa@greensroom.kotnet.org>
References: <11862375532593-git-send-email-hjemli@gmail.com>
 <8c5c35580708170025g70db9f3eu664551400e9430d4@mail.gmail.com>
 <7vmywqh98d.fsf@gitster.siamese.dyndns.org>
 <11862375532593-git-send-email-hjemli@gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Lars Hjemli <lh@elementstorage.no>
To: Lars Hjemli <hjemli@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 11:09:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILxq6-00045O-KH
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 11:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759553AbXHQJJu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 05:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759537AbXHQJJu
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 05:09:50 -0400
Received: from psmtp09.wxs.nl ([195.121.247.23]:37030 "EHLO psmtp09.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759526AbXHQJJt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 05:09:49 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp09.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JMW002XBUSBOE@psmtp09.wxs.nl> for git@vger.kernel.org; Fri,
 17 Aug 2007 11:09:48 +0200 (MEST)
Received: (qmail 21354 invoked by uid 500); Fri, 17 Aug 2007 09:09:47 +0000
In-reply-to: <7vmywqh98d.fsf@gitster.siamese.dyndns.org>
 <11862375532593-git-send-email-hjemli@gmail.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56054>

On Sat, Aug 04, 2007 at 04:25:53PM +0200, Lars Hjemli wrote:
> This was broken as part of ecda072380.
> 
> Signed-off-by: Lars Hjemli <hjemli@gmail.com>
> ---
>  git-submodule.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 2cfeadd..3320998 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -313,7 +313,7 @@ case "$add,$init,$update,$status,$cached" in
>  ,,1,,)
>  	modules_update "$@"
>  	;;
> -,,,1,*)
> +,,,*,*)
>  	modules_list "$@"
>  	;;
>  *)

Sorry about that.  I didn't realize that it was supposed to do that
(it seems I didn't read the manual carefully enough) and I forgot
to mention I changed it.

On Fri, Aug 17, 2007 at 01:10:42AM -0700, Junio C Hamano wrote:
> "Lars Hjemli" <lh@elementstorage.no> writes:
> > I got no response on this patch, was it simply overlooked? I really think
> >
> > $ git submodule
> >
> > should show the available submodules and their status.
> 
> Probably.  I do not think of any other alternative behaviour
> that would make sense.
> 
> Sven?

No objections from me.

skimo
