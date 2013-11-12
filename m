From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Bug? diff.submodule=log adds text to commit -v message
Date: Tue, 12 Nov 2013 08:46:13 +0100
Message-ID: <5281DCC5.2000209@kdbg.org>
References: <loom.20131110T222043-57@post.gmane.org> <528140F5.6090700@web.de> <loom.20131111T214646-550@post.gmane.org> <52814C35.6040205@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>, Ari Pollak <ari@debian.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 08:46:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vg8gI-0006Ta-S8
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 08:46:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753388Ab3KLHqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 02:46:32 -0500
Received: from bsmtp5.bon.at ([195.3.86.187]:42432 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753149Ab3KLHqX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 02:46:23 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id B3C3810028;
	Tue, 12 Nov 2013 08:46:18 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id A5EAA19F5CF;
	Tue, 12 Nov 2013 08:46:13 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <52814C35.6040205@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237702>

Am 11.11.2013 22:29, schrieb Jens Lehmann:
> The diff below fixes the problem you describe for me. (But I do not
> consider it a worthwhile fix in its current form because a line
> starting with "Submodule " might appear in a perfectly normal commit
> message, while "diff --git " most probably won't).

And on top of that, "Submodule " originates from a translatable string,
doesn't it?

-- Hannes
