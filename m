From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make git status usage say git status instead of git commit
Date: Sun, 02 Dec 2007 21:34:14 -0800
Message-ID: <7vir3gqr3d.fsf@gitster.siamese.dyndns.org>
References: <1196658129-16708-1-git-send-email-shawn.bohrer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Shawn Bohrer <shawn.bohrer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 06:34:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz3x4-0000AS-Cq
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 06:34:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbXLCFeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 00:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbXLCFeW
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 00:34:22 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:49689 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850AbXLCFeW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 00:34:22 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id B54AB2F0;
	Mon,  3 Dec 2007 00:34:43 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 45B3399E77;
	Mon,  3 Dec 2007 00:34:40 -0500 (EST)
In-Reply-To: <1196658129-16708-1-git-send-email-shawn.bohrer@gmail.com> (Shawn
	Bohrer's message of "Sun, 2 Dec 2007 23:02:09 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66867>

Shawn Bohrer <shawn.bohrer@gmail.com> writes:

> git status shares the same usage information as git commit since it
> shows what would be committed if the same options are given.  However,
> when displaying the usage information for git status it should say it
> is for git status not git commit.
>
> Signed-off-by: Shawn Bohrer <shawn.bohrer@gmail.com>

Thanks.  Will apply.

> As a side question, should the usage information also use the non dash
> notation of the command since it is deprecated?  I noticed all of the
> other commands are presently using the dash form, so I left it as is for
> now.

Wise choice.  We would probably want to clean them up at the same time
early post 1.5.4.
