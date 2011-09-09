From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: The imporantance of including http credential caching in 1.7.7
Date: Fri, 9 Sep 2011 08:31:20 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87boutx2on.fsf@lifelogs.com>
References: <CAFcyEthzW1AY4uXgpsVxjyWCDXAJ6=GdWGqLFO6Acm1ovJJVaw@mail.gmail.com>
	<4E6769E3.4070003@drmicha.warpmail.net>
	<20110908191053.GA16064@sigill.intra.peff.net>
	<4E69C8F0.9070204@drmicha.warpmail.net> <87pqjaxbrm.fsf@lifelogs.com>
	<CAEBDL5VtVZcmQnj2CH7XzZ0YV_X61gO69-dXriGiYsAqk=NLPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Kyle Neath <kneath@gmail.com>,
	Jeff King <peff@peff.net>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Fri Sep 09 15:44:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R21Na-0007d5-Vg
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 15:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759106Ab1IINoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 09:44:17 -0400
Received: from cer-mailmxol2.jumptrading.com ([208.78.214.25]:50833 "EHLO
	cer-mailmxol2.jumptrading.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759100Ab1IINoQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2011 09:44:16 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AtcGAEUUak7AqF0N/2dsb2JhbABBoVEDhzOBUgEBBW4LEAsNFA0BARYPAQQ1ARMOBR6/YYNiAQSDBwSHbZBpFowE
Received: from unknown (HELO chiexchange02.w2k.jumptrading.com) ([192.168.93.13])
  by cer-mailmxol2.jumptrading.com with ESMTP; 09 Sep 2011 13:31:26 +0000
Received: from internalsmtp.w2k.jumptrading.com (10.2.4.29) by
 chiexchange02.w2k.jumptrading.com (10.2.4.71) with Microsoft SMTP Server id
 8.2.176.0; Fri, 9 Sep 2011 08:31:25 -0500
Received: from tzlatanov-ubuntu-desktop.jumptrading.com ([10.2.14.81]) by
 internalsmtp.w2k.jumptrading.com with Microsoft SMTPSVC(6.0.3790.1830);	 Fri,
 9 Sep 2011 08:31:25 -0500
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
Mail-Copies-To: never
Gmane-Reply-To-List: yes
In-Reply-To: <CAEBDL5VtVZcmQnj2CH7XzZ0YV_X61gO69-dXriGiYsAqk=NLPg@mail.gmail.com>
	(John Szakmeister's message of "Fri, 9 Sep 2011 06:32:25 -0400")
User-Agent: Gnus/5.110018 (No Gnus v0.18) Emacs/24.0.50 (gnu/linux)
X-OriginalArrivalTime: 09 Sep 2011 13:31:25.0535 (UTC) FILETIME=[C5BB16F0:01CC6EF4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181065>

On Fri, 9 Sep 2011 06:32:25 -0400 John Szakmeister <john@szakmeister.net> wrote: 

JS> [Added back some of the CC's]
JS> Ted: we don't usually cull the CC list on the git mailing list.

Sorry, I followed up via GMane (a NNTP interface to the mailing list).
I'll use `r'eply instead of `f'ollowup.

I actually set

Mail-Copies-To: never
Gmane-Reply-To-List: yes

because I hate getting CC'd on discussions I already follow via GMane.
But that's just my preference :)

JS> 2011/9/9 Ted Zlatanov <tzz@lifelogs.com>:
JS> [snip]
MJG> ... and one for Git on Windows? It seems we're lacking both Win and OS X
MJG> developers here.
>> 
>> Windows doesn't have a standard keychain service, does it?

JS> No, it doesn't, but you can use the wincrypt API which allows you to
JS> at least encrypt the password from the user's login credentials.  In
JS> particular, CryptProtectData() and CryptUnprotectData().  That way you
JS> can at least have the password stored encrypted on disk.

I don't think that's sufficient but could be wrong.

Ted
