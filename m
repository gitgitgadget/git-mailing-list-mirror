From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Include diff options in the git-log manpage
Date: Tue, 04 Dec 2007 09:57:47 -0800
Message-ID: <7vzlwq4a1w.fsf@gitster.siamese.dyndns.org>
References: <1193929060-6183-1-git-send-email-vmiklos@frugalware.org>
	<1193929060-6183-2-git-send-email-vmiklos@frugalware.org>
	<20071204122859.GQ31750@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Dec 04 18:58:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Izc26-0006s0-Ae
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 18:58:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbXLDR5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 12:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbXLDR5x
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 12:57:53 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:38671 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbXLDR5w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 12:57:52 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 8C6E42F0;
	Tue,  4 Dec 2007 12:58:13 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 1FB5D9CCED;
	Tue,  4 Dec 2007 12:58:10 -0500 (EST)
In-Reply-To: <20071204122859.GQ31750@genesis.frugalware.org> (Miklos Vajna's
	message of "Tue, 4 Dec 2007 13:28:59 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67070>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Thu, Nov 01, 2007 at 03:57:40PM +0100, Miklos Vajna <vmiklos@frugalware.org> wrote:
>> Recently I wanted to see what git log -M does but actually I was not able to
>> find it in the manpage, finally figured out that all the diff options are
>> missing from here.
>> 
>> Removing -p as it's already in diff-options.txt.
>
> could you please have a look at this patch? this also fixes the "-C is
> missing from man git-log" issue which was reported on IRC today.

There was a patch around diff options documentation from Sergei
last month, and somehow I thought it covered this issue as well.

Will format the docs before and after your fix, compare them, and then
decide either to drop or accept, which will take some time but will be
done before -rc0.

Thanks.
