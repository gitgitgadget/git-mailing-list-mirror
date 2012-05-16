From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Git commit path vs rebase path
Date: Wed, 16 May 2012 07:52:41 +0200
Message-ID: <4FB340A9.60607@viscovery.net>
References: <CAAXzdLU6bQ7ta4_-WfGJVaJgt1R5tX=4PW2sq3SdjAB+F72w+Q@mail.gmail.com>	<7vaa1j7vg1.fsf@alter.siamese.dyndns.org>	<4FA8BBB0.1080406@viscovery.net>	<CAAXzdLVaDAQkd_9qjnmTRoy8ccpyrZvwvBJQAfkp7LkYa7Li2A@mail.gmail.com>	<4FA8C5DB.5060002@viscovery.net>	<CAAXzdLW9_O+feVpBhDSXQH_SFRdrct1tjadpFoJ5d7-Qd1LWEg@mail.gmail.com>	<7vhavqwqpz.fsf@alter.siamese.dyndns.org>	<7v1umuwpo9.fsf@alter.siamese.dyndns.org>	<CAAXzdLVj0szCgpdOSdhnLdkBKAM+e6vrQpvrsz4HeUo+Nh1K6A@mail.gmail.com>	<4FAC047A.4010001@ramsay1.demon.co.uk> <CAAXzdLXbYp5YW9cZXxmRJk0MP=6PU897f4nuTe4ipLqk+EH9PQ@mail.gmail.com> <4FB03CA1.4030703@ramsay1.demon.co.uk> <4FB09FF2.70309@viscovery.net> <4FB2931A.1080504@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Steven Penny <svnpenn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed May 16 07:52:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUXAK-0001ap-D0
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 07:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755241Ab2EPFwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 May 2012 01:52:47 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:38886 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754969Ab2EPFwq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2012 01:52:46 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SUXA9-0004LO-In; Wed, 16 May 2012 07:52:41 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 3447C1660F;
	Wed, 16 May 2012 07:52:41 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <4FB2931A.1080504@ramsay1.demon.co.uk>
X-Enigmail-Version: 1.4.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197865>

Am 5/15/2012 19:32, schrieb Ramsay Jones:
>     ++ GIT_SEQUENCE_EDITOR=args
>     ++ eval args '"$@"'
>     +++ args /usr/home/ramsay/git/.git/rebase-merge/git-rebase-todo
>     argv[0] = 'C:\msysgit\msysgit\home\ramsay\bin\args.exe'
>     argv[1] = 'C:/msysgit/msysgit/home/ramsay/git/.git/rebase-merge/git-rebase-todo'
...
> So, the msys "path munging" of program arguments saves the day!

Absolutely. This path munging is an essential detail in the process.

I don't know whether Cygwin has a similar feature, but I suppose not,
otherwise we wouldn't have received this issue report.

-- Hannes
