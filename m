From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH] gitk: Fix typo in proc blobdiffmaybeseehere
Date: Fri, 20 Dec 2013 00:16:58 +0100
Message-ID: <87ob4cctxx.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
References: <52AF0688.3070104@viscovery.net> <52B29CB8.8090304@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Dec 20 00:17:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtmqB-0000oP-AR
	for gcvg-git-2@plane.gmane.org; Fri, 20 Dec 2013 00:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756576Ab3LSXRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Dec 2013 18:17:11 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:50533 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755822Ab3LSXRK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 18:17:10 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id F20C14D6580;
	Fri, 20 Dec 2013 00:17:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id bO6Nwimzz9q7; Fri, 20 Dec 2013 00:16:58 +0100 (CET)
Received: from linux-1gf2.Speedport_W723_V_Typ_A_1_00_098.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 75BC24D64C4;
	Fri, 20 Dec 2013 00:16:58 +0100 (CET)
In-Reply-To: <52B29CB8.8090304@viscovery.net> (Johannes Sixt's message of
	"Thu, 19 Dec 2013 08:14:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239553>

Johannes Sixt <j.sixt@viscovery.net> writes:

> can't use non-numeric string as operand of "!"
>     while executing
> "if {!$ateof} {
> 	set nlines [expr {[winfo height $ctext]
> 			  / [font metrics textfont -linespace]}]
> 	if {[$ctext compare "$target_scrollpos + $nlines ..."
>     (procedure "maybe_scroll_ctext" line 5)
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
> Am 12/16/2013 14:56, schrieb Johannes Sixt:
>> To reproduce, start gitk in any repository, click a commit, then the
>> "back" button (left-pointing arrow button) or type Alt+Cursor-Left. The
>> error I get is this:
>> 
>> can't use non-numeric string as operand of "!"
>
> It turns out to be just a simple typo.
[...]
> -    maybe_scroll_ctext ateof
> +    maybe_scroll_ctext $ateof
>  }

Ew.  Sorry about that!

It's very polite of you to call it a typo, but I think it's safe to
blame it on my lack of practice in Tcl :-)

-- 
Thomas Rast
tr@thomasrast.ch
