From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 1/7] Windows: Add workaround for MSYS' path conversion
Date: Sun, 17 Aug 2008 22:35:48 +0200
Message-ID: <200808172235.48321.johannes.sixt@telecom.at>
References: <1218977083-14526-1-git-send-email-prohaska@zib.de> <1218977083-14526-2-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Aug 17 22:37:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUoze-0000dS-GZ
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbYHQUfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbYHQUfv
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:35:51 -0400
Received: from smtp4.srv.eunet.at ([193.154.160.226]:42447 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbYHQUfv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:35:51 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id E84DC97312;
	Sun, 17 Aug 2008 22:35:48 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 65A121D2A0;
	Sun, 17 Aug 2008 22:35:48 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1218977083-14526-2-git-send-email-prohaska@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92629>

On Sonntag, 17. August 2008, Steffen Prohaska wrote:
> MSYS' automatic path conversion causes problems when passing paths as '-D'
> arguments to the compiler.  MSYS tries to be smart and converts absolute
> paths to native Windows paths.  But we want the paths as we compute them in
> the Makefile.

Huh? Doesn't the Makefile compute paths like "/c/path/to/git"? We certainly 
don't want to compile such paths into git that in Windows speak actually 
mean "c:/path/to/git" - git is not an MSYS program and wouldn't understand 
the former. Which form of conversion are you refering to?

-- Hannes
