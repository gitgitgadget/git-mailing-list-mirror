From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Something fishy with master.  After a ./configure on OpenServer
 6
Date: Tue, 26 Aug 2008 14:03:30 +0200
Message-ID: <48B3F112.1060106@viscovery.net>
References: <alpine.LNX.1.10.0808260410580.6723@suse104.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 14:15:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXxI0-0007qj-IY
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 14:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239AbYHZMDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 08:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753005AbYHZMDf
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 08:03:35 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:30482 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642AbYHZMDe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 08:03:34 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KXxGk-0000cg-BQ; Tue, 26 Aug 2008 14:03:30 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 1BC8E54D; Tue, 26 Aug 2008 14:03:30 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.LNX.1.10.0808260410580.6723@suse104.zenez.com>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3, UPPERCASE_25_50=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93740>

Boyd Lynn Gerber schrieb:
> $ gmake check
> for i in *.c; do sparse -Kalloca -Kthread -I/usr/local/include
> -DNO_D_TYPE_IN_DIRENT -DSHA1_HEADER='<openssl/sha.h>'
> -DSNPRINTF_RETURNS_BOGUS -DFREAD_READS_DIRECTORIES -DNO_STRCASESTR
> -DNO_MKDTEMP -DNO_HSTRERROR -DNO_MEMMEM -D__BIG_ENDIAN__ -D__powerpc__
> $i || exit; done
> /usr/bin/bash: sparse: command not found

Did you mean to run 'gmake test'?

-- Hannes
