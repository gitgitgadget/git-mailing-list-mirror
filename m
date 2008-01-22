From: picca <picca@synchrotron-soleil.Fr>
Subject: Re: tracking a file from another project in my own project
Date: Tue, 22 Jan 2008 14:56:58 +0100
Organization: Soleil
Message-ID: <20080122145658.18b6ef89@synchrotron-soleil.Fr>
References: <20080122093546.72db8da0@synchrotron-soleil.Fr>
	<7v7ii2rzbq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 14:57:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHJci-0004ao-6f
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 14:57:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbYAVN4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 08:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbYAVN4h
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 08:56:37 -0500
Received: from dns2.synchrotron-soleil.fr ([195.221.0.6]:59424 "EHLO
	raclette.synchrotron-soleil.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751690AbYAVN4g (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jan 2008 08:56:36 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by raclette.synchrotron-soleil.fr (Postfix) with ESMTP id 74390300FC;
	Tue, 22 Jan 2008 14:43:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at synchrotron-soleil.fr
Received: from raclette.synchrotron-soleil.fr ([127.0.0.1])
	by localhost (raclette.synchrotron-soleil.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4G+zG5v9iKXl; Tue, 22 Jan 2008 14:43:12 +0100 (CET)
Received: from venusbis.synchrotron-soleil.fr (venusbis.synchrotron-soleil.fr [195.221.0.152])
	by raclette.synchrotron-soleil.fr (Postfix) with ESMTP id F1019300D2;
	Tue, 22 Jan 2008 14:43:11 +0100 (CET)
Received: from localhost.localdomain ([195.221.5.120]) by venusbis.synchrotron-soleil.fr with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 22 Jan 2008 14:57:26 +0100
In-Reply-To: <7v7ii2rzbq.fsf@gitster.siamese.dyndns.org>
X-Mailer: Claws Mail 3.2.0 (GTK+ 2.12.1; i486-pc-linux-gnu)
X-OriginalArrivalTime: 22 Jan 2008 13:57:26.0042 (UTC) FILETIME=[B81D0FA0:01C85CFE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71450>

On Tue, 22 Jan 2008 01:20:41 -0800
Junio C Hamano <gitster@pobox.com> wrote:

> If I were you I'd probably just keep git.git as a submodule in
> your project and have two symlinks from your toplevel pointing
> at git.git/strbuf.[ch] (or from src/ to ../git.git/strbuf.[ch]).

So submodule is a requirement to achieved this comportment ?

If someone want to clone my project.git, must he also clone the
git.git project or he loose the ability to follow by it's own the
strbuf.[ch] file ?

> Or "merge -s subtree".

I red the git help merge -s explanation but I do not understand how
it can help in my case.

Thanks

Frederic
