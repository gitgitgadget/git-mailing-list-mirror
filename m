From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 13/14] t4135-*.sh: Skip the "backslash" tests on cygwin
Date: Tue, 14 Dec 2010 21:49:33 +0100
Message-ID: <201012142149.33725.j6t@kdbg.org>
References: <4D07B977.9010502@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"GIT Mailing-list" <git@vger.kernel.org>, jrnieder@gmail.com
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Dec 14 21:49:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSbob-0003NQ-9n
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 21:49:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759945Ab0LNUtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 15:49:36 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:62082 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758360Ab0LNUtf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 15:49:35 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 4CD202C400D;
	Tue, 14 Dec 2010 21:49:34 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id CB0A619F5F9;
	Tue, 14 Dec 2010 21:49:33 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <4D07B977.9010502@ramsay1.demon.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163687>

On Dienstag, 14. Dezember 2010, Ramsay Jones wrote:
> Note t3700-*.sh has a test protected by BSLASHSPEC which
> previously passed on cygwin and will now be (unnecessarily)
> skipped. This test needs to be skipped on MinGW, given how
> it is written; if you remove the single quotes around the
> filename, however, it will pass even on MinGW.

That is suspicious. It would mean that git add does not do file globbing 
anymore. Should it or should it not do file globbing?

-- Hannes
