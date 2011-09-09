From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: The imporantance of including http credential caching in 1.7.7
Date: Fri, 9 Sep 2011 08:33:24 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <877h5hx2l7.fsf@lifelogs.com>
References: <CAFcyEthzW1AY4uXgpsVxjyWCDXAJ6=GdWGqLFO6Acm1ovJJVaw@mail.gmail.com>
	<4E6769E3.4070003@drmicha.warpmail.net>
	<20110908191053.GA16064@sigill.intra.peff.net>
	<4E69C8F0.9070204@drmicha.warpmail.net> <87pqjaxbrm.fsf@lifelogs.com>
	<CAEBDL5VtVZcmQnj2CH7XzZ0YV_X61gO69-dXriGiYsAqk=NLPg@mail.gmail.com>
	<CABPQNSbrjNR73GxE4xXFPqaVSUOaa5Drt4Je+zGY82rzajQxuw@mail.gmail.com>
	<CAEBDL5UymsgsQnE9t121omGkR3Zw9BsFqOinTshxEN4WDcOdeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <kusmabite@gmail.com>, <git@vger.kernel.org>,
	Kyle Neath <kneath@gmail.com>, Jeff King <peff@peff.net>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Fri Sep 09 15:36:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R21GK-0003gf-Hz
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 15:36:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933386Ab1IINgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 09:36:50 -0400
Received: from cer-mailmxol2.jumptrading.com ([208.78.214.25]:63151 "EHLO
	cer-mailmxol2.jumptrading.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759060Ab1IINgt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2011 09:36:49 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Sep 2011 09:36:49 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgoHAGwVak7AqF0N/2dsb2JhbABBnGiEaQOHM4FSAQEFeRALDRQlDwEEDSgBEw4Fh3q4BIZuBIdtkGkWhFKHMg
Received: from unknown (HELO chiexchange02.w2k.jumptrading.com) ([192.168.93.13])
  by cer-mailmxol2.jumptrading.com with ESMTP; 09 Sep 2011 13:33:31 +0000
Received: from internalsmtp.w2k.jumptrading.com (10.2.4.29) by
 chiexchange02.w2k.jumptrading.com (10.2.4.71) with Microsoft SMTP Server id
 8.2.176.0; Fri, 9 Sep 2011 08:33:30 -0500
Received: from tzlatanov-ubuntu-desktop.jumptrading.com ([10.2.14.81]) by
 internalsmtp.w2k.jumptrading.com with Microsoft SMTPSVC(6.0.3790.1830);	 Fri,
 9 Sep 2011 08:33:30 -0500
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
Mail-Copies-To: never
Gmane-Reply-To-List: yes
In-Reply-To: <CAEBDL5UymsgsQnE9t121omGkR3Zw9BsFqOinTshxEN4WDcOdeA@mail.gmail.com>
	(John Szakmeister's message of "Fri, 9 Sep 2011 06:54:15 -0400")
User-Agent: Gnus/5.110018 (No Gnus v0.18) Emacs/24.0.50 (gnu/linux)
X-OriginalArrivalTime: 09 Sep 2011 13:33:30.0274 (UTC) FILETIME=[1014C020:01CC6EF5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181064>

On Fri, 9 Sep 2011 06:54:15 -0400 John Szakmeister <john@szakmeister.net> wrote: 

JS> On Fri, Sep 9, 2011 at 6:48 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
JS> [snip]
>> Actually, it seems recent Windows versions does have a credential
>> manager, including an API:
>> 
>> http://www.yanzzee.com/2009/09/windows-keychain.html
>> http://msdn.microsoft.com/en-us/library/aa374731(v=VS.85).aspx#credentials_management_functions

JS> Yay!  It's about time they grew that feature. :-)

That could work.  I hope a Windows developer can take a look.  That
leaves VMS credential support... Come on guys!

Ted
