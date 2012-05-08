From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Git commit path vs rebase path
Date: Tue, 08 May 2012 09:06:03 +0200
Message-ID: <4FA8C5DB.5060002@viscovery.net>
References: <CAAXzdLU6bQ7ta4_-WfGJVaJgt1R5tX=4PW2sq3SdjAB+F72w+Q@mail.gmail.com> <7vaa1j7vg1.fsf@alter.siamese.dyndns.org> <4FA8BBB0.1080406@viscovery.net> <CAAXzdLVaDAQkd_9qjnmTRoy8ccpyrZvwvBJQAfkp7LkYa7Li2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steven Penny <svnpenn@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 08 09:06:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SReUy-0003Xn-GE
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 09:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108Ab2EHHGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 03:06:09 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:30612 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753898Ab2EHHGH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 03:06:07 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SReUl-0000Zb-NI; Tue, 08 May 2012 09:06:04 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 6F9CB1660F;
	Tue,  8 May 2012 09:06:03 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <CAAXzdLVaDAQkd_9qjnmTRoy8ccpyrZvwvBJQAfkp7LkYa7Li2A@mail.gmail.com>
X-Enigmail-Version: 1.4.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197342>

Am 5/8/2012 8:44, schrieb Steven Penny:
> Johannes Sixt wrote:
>> The problem should be mitigated by be39048a7 (git-sh-setup.sh: Add an
>> pwd() function for MinGW), where the above now returns a Windows-style
>> absolute path, albeit with forward slashes instead of the backslashes.
> 
> http://github.com/git/git/commit/be390
> 
> This looks like a good solution for MinGW, but cygwin will not support that
> 
> $ pwd -W
> bash: pwd: -W: invalid option
> pwd: usage: pwd [-LP]

Are you saying that the new pwd function will also be used on Cygwin? That
would be a bug.

-- Hannes
