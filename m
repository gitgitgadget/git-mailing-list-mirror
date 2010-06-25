From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 4/4] Makefile: Don't pass $(ALL_CFLAGS) to the linker
Date: Fri, 25 Jun 2010 21:24:02 +0100
Message-ID: <4C251062.8040507@ramsay1.demon.co.uk>
References: <4C226520.5080009@ramsay1.demon.co.uk> <AANLkTinmGOSwNzLBngXHOU-pxNTbHFJQyCLIHQWFW6Eo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Peter Harris <git@peter.is-a-geek.org>
X-From: git-owner@vger.kernel.org Sat Jun 26 20:02:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSZiI-0008UT-Nn
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 20:02:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753833Ab0FZSC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jun 2010 14:02:28 -0400
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:34167 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753809Ab0FZSCY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Jun 2010 14:02:24 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1OSZhu-0004W9-lm; Sat, 26 Jun 2010 18:02:23 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <AANLkTinmGOSwNzLBngXHOU-pxNTbHFJQyCLIHQWFW6Eo@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149766>

Peter Harris wrote:
> On Wed, Jun 23, 2010 at 3:48 PM, Ramsay Jones wrote:
>> The msvc debug build (make MSVC=1 DEBUG=1) issues a warning
>> on every invocation of the linker:
>>
>>    LINK : warning LNK4044: unrecognized option '/Zi'; ignored
>>
>> In order to suppress the warning, we refrain from passing the
>> $(ALL_CFLAGS) macro to the linker.
> 
> Alternatively, we could leave the makefile alone and fix it up in
> compat/vcbuild/scripts/clink.pl

Hmm, OK ... but it would be much easier if we didn't pass inappropriate
options in the first place. :-P

Also, are you correctly filtering *all* possible inappropriate options?
For example, the very next patch on my branch (not sent to list) adds
a -W3 option ... ;-)

ATB,
Ramsay Jones
