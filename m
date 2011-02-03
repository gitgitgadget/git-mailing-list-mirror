From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] [PATCH 4/4] t5526: avoid dependency on submodule order
Date: Thu, 3 Feb 2011 21:08:54 +0100
Message-ID: <201102032108.54811.j6t@kdbg.org>
References: <1296747105-1663-1-git-send-email-patthoyts@users.sourceforge.net> <1296747105-1663-5-git-send-email-patthoyts@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Feb 03 21:09:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl5UG-00008H-4P
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 21:09:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756733Ab1BCUI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 15:08:58 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:19655 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756342Ab1BCUI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 15:08:57 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 4E111130053;
	Thu,  3 Feb 2011 21:08:55 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 2013319F5F2;
	Thu,  3 Feb 2011 21:08:55 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <1296747105-1663-5-git-send-email-patthoyts@users.sourceforge.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165992>

On Donnerstag, 3. Februar 2011, Pat Thoyts wrote:
> +test_cmp_unordered() {
> +	grep --line-regexp -f "$@" >&3
> +}

I don't think that this is sufficiently portable.

Furthermore, just like Dscho, I'd rather prefer to know why the output is not 
ordered as expected.

I'm fine with the other patches as well.

A side note regarding SYMLINKS: It's actually possible to remove 70 of the 130 
SYMLINKS checks from the test suite:

http://repo.or.cz/w/git/mingw/j6t.git/shortlog/refs/heads/war-on-symlinks

-- Hannes
