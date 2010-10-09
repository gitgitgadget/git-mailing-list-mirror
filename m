From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/5] t7607: add leading-path tests
Date: Sat, 9 Oct 2010 21:14:51 +0200
Message-ID: <201010092114.51881.j6t@kdbg.org>
References: <7v4oepaup7.fsf@alter.siamese.dyndns.org> <1286632380-7002-3-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat Oct 09 21:15:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4est-0004SN-LE
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 21:15:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757017Ab0JITO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 15:14:56 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:9499 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756953Ab0JITO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 15:14:56 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id CE5A1A7EB6;
	Sat,  9 Oct 2010 21:14:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 2B5D019F7DF;
	Sat,  9 Oct 2010 21:14:52 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <1286632380-7002-3-git-send-email-drizzd@aon.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158597>

On Samstag, 9. Oktober 2010, Clemens Buchacher wrote:
> +test_expect_failure 'will not overwrite untracked symlink in leading path'

> +test_expect_success 'will not be confused by symlink in leading path' '

Please guard these two with a SYMLINKS prerequisite.

-- Hannes
