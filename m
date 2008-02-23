From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 2/3] t3404: use configured shell instead of /bin/sh
Date: Sat, 23 Feb 2008 22:09:41 +0100
Message-ID: <200802232209.41428.johannes.sixt@telecom.at>
References: <20080220235944.GA6278@coredump.intra.peff.net> <200802232113.40100.johannes.sixt@telecom.at> <7v63wf2yzt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Whit Armstrong <armstrong.whit@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 22:10:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT1dg-00062o-Sx
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 22:10:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763541AbYBWVJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 16:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763493AbYBWVJo
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 16:09:44 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:43797 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762247AbYBWVJn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 16:09:43 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id D19489749C;
	Sat, 23 Feb 2008 22:09:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 9F83A60C6A;
	Sat, 23 Feb 2008 22:09:41 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <7v63wf2yzt.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74852>

On Saturday 23 February 2008 21:34, Junio C Hamano wrote:
> -echo "#!$SHELL" >fake-editor
> +echo "#!$SHELL_PATH" >fake-editor.sh

Hm, when we run the test outside make, like

   $ sh t3404-rebase-interactive.sh

then the fake-editor.sh script begins with this line:

   #!

Isn't this a trap similar to what Jeff wanted to avoid?

-- Hannes
