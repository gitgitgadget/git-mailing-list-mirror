From: John Keeping <john@keeping.me.uk>
Subject: Re: git-submodule nested subrepo bug (Segmentation fault)
Date: Wed, 22 May 2013 09:08:02 +0100
Message-ID: <20130522080802.GP27005@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kirill Berezin <enelar@develop-project.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 22 10:08:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uf45p-00007Z-Bf
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 10:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969Ab3EVIIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 04:08:13 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:60080 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176Ab3EVIIK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 04:08:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 829AA23841;
	Wed, 22 May 2013 09:08:09 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -11.414
X-Spam-Level: 
X-Spam-Status: No, score=-11.414 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	FAKE_REPLY_C=1.486] autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yWRdzfNlCfWy; Wed, 22 May 2013 09:08:08 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id A86762378A;
	Wed, 22 May 2013 09:08:04 +0100 (BST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225140>

I'm guessing Kirill meant to send this to the list and not just to me.

It looks to me like the segfault is in MSys's mkdir.exe and not a Git
process.

----- Forwarded message from Kirill Berezin <enelar@develop-project.ru> -----

From: Kirill Berezin <enelar@develop-project.ru>
To: John Keeping <john@keeping.me.uk>
Date: Wed, 22 May 2013 09:54:47 +0400
Message-ID: <CAAObgf-PE_6pf3af5Uba8RfKwXa43GXeG9RoMjf62uSZ7k4mTg@mail.gmail.com>
Subject: Re: git-submodule nested subrepo bug (Segmentation fault)

Ok, version is: 1.8.1.msysgit.1
Segmentation fault at the git clone --recursive http://github.com/Exsul/al_server
0 [main] mkdir 6596 open_stackdumpfile: Dumping stack trace to mkdir.exe.stackdump
C:\Users\....\libexec\git-core\git-submodule: line 181: 6596
Segmentation fault (core dumped) mkdir -p "$ditdir_base"
fatal: Could not switch to 's:/USER/..../al_server/.git/modules/': No such file or directory
Clone of 'https://.../Exsul/chat.git' into submodule path 'chat' failed

PS so much mails per day...

2013/5/20 Kirill Berezin <enelar@develop-project.ru>:
> This is standart github shell(Windows 7). Right now i cant access my
> home platform, will tell you tommorow.
>
> 2013/5/20 John Keeping <john@keeping.me.uk>:
>> On Mon, May 20, 2013 at 09:32:21AM +0400, Kirill Berezin wrote:
>>> When you trying to add submodule, that already has submodule, it craches.
>>> For example you could try: git clone --recursive
>>> http://github.com/Exsul/al_server
>>
>> Which version of Git were you using?  I was not able to reproduce this
>> with 1.8.3-rc3.



----- End forwarded message -----
