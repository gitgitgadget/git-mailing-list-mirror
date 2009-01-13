From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/6] Move computation of absolute paths from Makefile to runtime and compute prefix on the fly if RUNTIME_PREFIX set
Date: Tue, 13 Jan 2009 20:43:16 +0100
Message-ID: <200901132043.16789.j6t@kdbg.org>
References: <1231595452-27698-1-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Jan 13 20:45:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMpBq-000103-VQ
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 20:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816AbZAMTnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 14:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752751AbZAMTnT
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 14:43:19 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:24973 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752709AbZAMTnS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 14:43:18 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 11629CDF89;
	Tue, 13 Jan 2009 20:43:17 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id DECA258275;
	Tue, 13 Jan 2009 20:43:16 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <1231595452-27698-1-git-send-email-prohaska@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105522>

On Samstag, 10. Januar 2009, Steffen Prohaska wrote:
> This is the first commit of a series that adds support for
> relocatable binaries (called RUNTIME_PREFIX).  Such binaries can be
> moved together with the system configuration files to a different
> directory, as long as the relative paths from the binary to the
> configuration files is preserved.  This functionality is essential
> on Windows where we deliver git binaries with an installer that
> allows to freely choose the installation location.  The commit
> series implements RUNTIME_PREFIX only on Windows.  Adding support
> on Unix should not be too hard, though.

This series looks sane, and my comments on 2/6 and 3/6 certainly do not 
indicate any showstoppers. I've just started using it; so far there are no 
problems.

-- Hannes
