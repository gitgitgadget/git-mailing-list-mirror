From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: Re: [PATCH v2] git-send-email: show all headers when sending mail
Date: Mon, 19 Nov 2007 10:50:27 -0800 (PST)
Message-ID: <327906.50991.qm@web52410.mail.re2.yahoo.com>
References: <7voddqodhs.fsf@gitster.siamese.dyndns.org>
Reply-To: ddkilzer@kilzer.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 19:51:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuBhn-0002Aa-Tv
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 19:50:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbXKSSu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 13:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbXKSSu3
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 13:50:29 -0500
Received: from web52410.mail.re2.yahoo.com ([206.190.48.173]:27043 "HELO
	web52410.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750948AbXKSSu2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Nov 2007 13:50:28 -0500
Received: (qmail 53333 invoked by uid 60001); 19 Nov 2007 18:50:27 -0000
X-YMail-OSG: MZOKpf8VM1ll_74YL7DxILt3SY6yRPZjezwIR27qawg1vErNgKTal5wF6zaeesBHmQ--
Received: from [24.7.124.164] by web52410.mail.re2.yahoo.com via HTTP; Mon, 19 Nov 2007 10:50:27 PST
X-RocketYMMF: ddkilzer
In-Reply-To: <7voddqodhs.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65488>

I can't seem to reproduce this.  Could you send me (off-list)
0001-branch-contains.txt and any relevant config bits?

Dave


Junio C Hamano <gitster@pobox.com> wrote:

> Thanks.  Looks nice and obviously correct.
> 
> One thing that has been bugging me for a long time now stands
> out like a sore thumb much more: empty Cc: is shown.
> 
>     $ git-send-email --dry-run --to=junio@my.isp.net 0001-branch-contains.txt
>     Who should the emails appear to be from? [Junio C Hamano
> <gitster@pobox.com>]
>     Emails will be sent from: Junio C Hamano <gitster@pobox.com>
>     Message-ID to be used as In-Reply-To for the first email?
>     0001-branch-contains.txt
>     Dry-OK. Log says:
>     Date: Mon, 19 Nov 2007 00:10:04 -0800
>     Server: my.isp.net
>     MAIL FROM:<gitster@pobox.com>
>     RCPT TO:<junio@my.isp.net>
>     From: Junio C Hamano <gitster@pobox.com>
>     Subject: [PATCH] branch --contains=<commit>
>     Cc:
>     To: junkio@cox.net
> 
>     Result: OK
