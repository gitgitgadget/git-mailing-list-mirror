From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: GIT on MinGW problem
Date: Sat, 26 May 2007 20:08:04 -0300
Message-ID: <4658BDD4.6070904@xs4all.nl>
References: <1e5001c794a0$aac23140$0200a8c0@AMD2500>	 <033501c79710$a2eb0290$0200a8c0@AMD2500>	 <f329bf540705151251n10c05452s5a74e8eaa513bf90@mail.gmail.com>	 <464ABAAF.C6603C5@eudaptics.com> <fcaeb9bf0705211122sef3abf6sb3633f09228a7e7d@mail.gmail.com>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 27 01:10:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hs5Ov-0002Bh-NX
	for gcvg-git@gmane.org; Sun, 27 May 2007 01:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbXEZXKJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 19:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbXEZXKI
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 19:10:08 -0400
Received: from smtp-vbr5.xs4all.nl ([194.109.24.25]:4244 "EHLO
	smtp-vbr5.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbXEZXKH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 19:10:07 -0400
Received: from [192.168.1.102] (c911deb6.bhz.virtua.com.br [201.17.222.182])
	(authenticated bits=0)
	by smtp-vbr5.xs4all.nl (8.13.8/8.13.8) with ESMTP id l4QN9xiO075702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 27 May 2007 01:10:01 +0200 (CEST)
	(envelope-from hanwen@xs4all.nl)
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <fcaeb9bf0705211122sef3abf6sb3633f09228a7e7d@mail.gmail.com>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48504>

Nguyen Thai Ngoc Duy escreveu:
>> > >         warning: templates not found /usr/share/git-core/templates/
>> > >
>>
>> This should have been fixed by 2d84ffaf (currently master~1 in
>> git://repo.or.cz/git/mingw.git) and its parent. Can you make sure that
>> your build picks up the new Makefile setting that these commits
>> introduce?
> 
> That commit didn't work for me because template_dir was overridden by
> config.mak.autogen

thanks for noticing this. I'm building a -2 release which should fix this.


-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
