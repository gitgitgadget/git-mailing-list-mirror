From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH] gitk: make pointer selection visible in highlighted lines
Date: Wed, 27 Nov 2013 20:16:13 +0100
Message-ID: <871u21hczm.fsf@thomasrast.ch>
References: <20131127180601.GA31211@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Wed Nov 27 20:16:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vlkaz-0006o2-8R
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 20:16:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757422Ab3K0TQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 14:16:17 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:60662 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754857Ab3K0TQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 14:16:16 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 214034D65A0;
	Wed, 27 Nov 2013 20:16:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id anUn3TC_eaVD; Wed, 27 Nov 2013 20:16:13 +0100 (CET)
Received: from linux-1gf2.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 965FF4D659F;
	Wed, 27 Nov 2013 20:16:13 +0100 (CET)
In-Reply-To: <20131127180601.GA31211@wheezy.local> (Max Kirillov's message of
	"Wed, 27 Nov 2013 20:06:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238456>

Max Kirillov <max@max630.net> writes:

> Custom tags have higher priority than sel, and when they define
> their own background, it makes selection invisible. Especially
> inconvenient for filesep (to select filenames), but may aslo affect
> other tags.
>
> Signed-off-by: Max Kirillov <max@max630.net>

Nice.

Tested-by: Thomas Rast <tr@thomasrast.ch>

> ---
>  gitk-git/gitk | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 5cd00d8..9f350ab 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -2385,6 +2385,7 @@ proc makewindow {} {
>      $ctext tag conf found -back $foundbgcolor
>      $ctext tag conf currentsearchhit -back $currentsearchhitbgcolor
>      $ctext tag conf wwrap -wrap word
> +    $ctext tag raise sel
>  
>      .pwbottom add .bleft
>      if {!$use_ttk} {

-- 
Thomas Rast
tr@thomasrast.ch
