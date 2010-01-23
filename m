From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH (resend 3)] git gui: Use git diff --submodule when	available
Date: Sat, 23 Jan 2010 23:42:26 +0100
Message-ID: <4B5B7B52.9020500@web.de>
References: <4B5B725C.6060301@web.de> <20100123223458.GB12679@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jan 23 23:42:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYoga-0000bs-7R
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 23:42:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636Ab0AWWmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 17:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752615Ab0AWWmb
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 17:42:31 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:50281 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595Ab0AWWm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 17:42:29 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 2C72514C6B274;
	Sat, 23 Jan 2010 23:42:27 +0100 (CET)
Received: from [80.128.48.239] (helo=[192.168.178.26])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NYogV-0000n4-00; Sat, 23 Jan 2010 23:42:27 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
In-Reply-To: <20100123223458.GB12679@spearce.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+bv70VxIo3XDaTcf+YCx4BTiHxNXFdiX0JOvrf
	Fg+FEaku/uAlrGOqRgKjp5NonBt1FSIK071MzOJ+NvZ8hRJnCm
	+vpKIutAO59i4g+DLaxQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137872>

Am 23.01.2010 23:34, schrieb Shawn O. Pearce:
> I actually just applied a modified version of your patch, so diff
> on submodules still works via submodule summary if git < 1.6.6.

One caveat: This will only work in versions 1.6.4 and above, as i
had to add the --files option to git submodule summary to make it
work.
