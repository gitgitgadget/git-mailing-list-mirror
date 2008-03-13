From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 16/16] t7505: use SHELL_PATH in hook
Date: Thu, 13 Mar 2008 09:00:41 -0400
Message-ID: <20080313130041.GG19485@coredump.intra.peff.net>
References: <cover.1205356737.git.peff@peff.net> <20080312214243.GQ26286@coredump.intra.peff.net> <47D8D39C.3070904@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Whit Armstrong <armstrong.whit@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Adam Piatyszek <ediap@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Mar 13 14:02:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZn4O-0002G9-Nh
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 14:02:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858AbYCMNAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 09:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752733AbYCMNAp
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 09:00:45 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4839 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751907AbYCMNAo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 09:00:44 -0400
Received: (qmail 30200 invoked by uid 111); 13 Mar 2008 13:00:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 13 Mar 2008 09:00:42 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Mar 2008 09:00:41 -0400
Content-Disposition: inline
In-Reply-To: <47D8D39C.3070904@users.sourceforge.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77074>

On Thu, Mar 13, 2008 at 08:11:24AM +0100, Adam Piatyszek wrote:

>> -cat > "$HOOK" <<'EOF'
>> +echo "#!$SHELL_PATH" > "$HOOK"
>> +cat >> "$HOOK" <<'EOF'
>>  #!/bin/sh
>    ^^^^^^^^^
> The above line should be removed in my humble opinion.

Oops, yes. I did delete it, but then accidentally editor-typo'd it back
into existence. Good eyes.

-Peff
