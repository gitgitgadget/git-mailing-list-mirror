From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 0/4] Cygwin MSVC patches
Date: Tue, 03 Nov 2009 08:08:41 +0100
Message-ID: <4AEFD6F9.5000305@viscovery.net>
References: <4AE7410D.3030109@ramsay1.demon.co.uk> <4AE7EB06.10305@viscovery.net> <4AE8C3FD.2020300@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>, mstormo@gmail.com
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Nov 03 08:08:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5DVa-00017w-RA
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 08:08:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248AbZKCHIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 02:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753201AbZKCHIj
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 02:08:39 -0500
Received: from lilzmailmt02.liwest.at ([212.33.55.12]:25183 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751010AbZKCHIj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 02:08:39 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N5DVQ-0005m9-9e; Tue, 03 Nov 2009 08:08:40 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 1B9036D9; Tue,  3 Nov 2009 08:08:40 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4AE8C3FD.2020300@ramsay1.demon.co.uk>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131946>

Ramsay Jones schrieb:
> Johannes Sixt wrote:
>> Ramsay Jones schrieb:
>>> With these patches, the msvc build on cygwin seems to be working fine.
>> What is "the msvc build on cygwin"?
> 
> The same as the msvc build on msys-MinGW, but replace msys-MinGW
> with Cygwin ;-)
> 
>> Is it "git built with msvc, then run in cygwin"?
> 
> Yes, but... *in theory* the cygwin msvc-built binaries could be transferred
> to an msys system and they should work (exactly as the msvc build on msys).
> Since I don't have an msys installation, I can't test that... so I won't
> guarantee it will work!
> 
> Any git needs a (bash-like) shell, perl, Tcl/Tk, ... etc.

Just to check I understand correctly: you are running "make MSVC=1" on
cygwin, and then you are using the resulting binaries with the POSIX tools
from cygwin.

-- Hannes
