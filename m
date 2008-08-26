From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: Something fishy with master.  After a ./configure on OpenServer
 6
Date: Tue, 26 Aug 2008 06:12:11 -0600
Message-ID: <alpine.LNX.1.10.0808260607460.6723@suse104.zenez.com>
References: <alpine.LNX.1.10.0808260410580.6723@suse104.zenez.com> <48B3F112.1060106@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Aug 26 14:18:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXxQE-0002DV-2C
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 14:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753005AbYHZMMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 08:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753094AbYHZMMN
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 08:12:13 -0400
Received: from suse104.zenez.com ([198.60.105.164]:19763 "EHLO
	suse104.zenez.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926AbYHZMMN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 08:12:13 -0400
Received: by suse104.zenez.com (Postfix, from userid 1000)
	id 3E285A7C8D7; Tue, 26 Aug 2008 06:12:12 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by suse104.zenez.com (Postfix) with ESMTP id 086AFA7C8D6;
	Tue, 26 Aug 2008 06:12:11 -0600 (MDT)
In-Reply-To: <48B3F112.1060106@viscovery.net>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93741>

On Tue, 26 Aug 2008, Johannes Sixt wrote:
> Boyd Lynn Gerber schrieb:
>> $ gmake check
>> for i in *.c; do sparse -Kalloca -Kthread -I/usr/local/include
>> -DNO_D_TYPE_IN_DIRENT -DSHA1_HEADER='<openssl/sha.h>'
>> -DSNPRINTF_RETURNS_BOGUS -DFREAD_READS_DIRECTORIES -DNO_STRCASESTR
>> -DNO_MKDTEMP -DNO_HSTRERROR -DNO_MEMMEM -D__BIG_ENDIAN__ -D__powerpc__
>> $i || exit; done
>> /usr/bin/bash: sparse: command not found
>
> Did you mean to run 'gmake test'?

I ran it first and I am having a few tests failing that were not before. 
I am investigating them.  When I ran gmake check before on 1.5.X it had 
the right information.  But the gmake test is the most important.  I need 
to figure-out why the test are failing now and make changes.  Every 
platform does not fail in the same place.  So it is going to take time to 
go through all the platforms and understand why the tests are failing.  It 
maybe just new tests.  That is what I am investigating now.

Thanks,

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
