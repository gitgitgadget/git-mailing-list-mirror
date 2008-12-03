From: "Jan Hudec" <bulb@ucw.cz>
Subject: Re: Ad: fast-import problem importing dos format files under cygwin
Date: Wed, 3 Dec 2008 14:43:11 +0100 (CET)
Message-ID: <51143.194.138.12.144.1228311791.squirrel@artax.karlin.mff.cuni.cz>
References: <43827.194.138.12.144.1228290700.squirrel@artax.karlin.mff.cuni.cz>
    <43270.194.138.12.144.1228295417.squirrel@artax.karlin.mff.cuni.cz>
    <49367909.8070605@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Jan Hudec" <bulb@ucw.cz>, git@vger.kernel.org
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Dec 03 14:44:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7s1m-0006Kk-0v
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 14:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbYLCNnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 08:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbYLCNnN
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 08:43:13 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.26.195]:60577 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbYLCNnM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 08:43:12 -0500
Received: from artax.karlin.mff.cuni.cz (localhost [127.0.0.1])
	by artax.karlin.mff.cuni.cz (Postfix) with ESMTP id 274E59803E;
	Wed,  3 Dec 2008 14:43:11 +0100 (CET)
Received: from 194.138.12.144
        (SquirrelMail authenticated user jhud7196)
        by artax.karlin.mff.cuni.cz with HTTP;
        Wed, 3 Dec 2008 14:43:11 +0100 (CET)
In-Reply-To: <49367909.8070605@viscovery.net>
User-Agent: SquirrelMail/1.4.9a
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102260>


Dne 3 Prosinec 2008, 13:18, Johannes Sixt napsal(a):
> Jan Hudec schrieb:
>> On 3 December 2008, 08:51, Jan Hudec wrote:
>>> Hello folks,
>>>
>>> I have been playing with fast-import in cygwin and I have problems
>>> importing files with CR/LF line-endings. The size in data command is
>>> calculated including the CRs and than the file is copied binary to the
>>> fast-import input stream. However fast-import skips the CRs when
>>> reading,
>>> overreads by that number of bytes and fails when it tries to read the
>>> next command from the middle.
>
> Do you happen to have core.autocrlf set in some way and could it make a
> difference for fast-import? I have it unset.

I have it set to false explicitly in global config. Tried with not having
it set at all and gives the same problem. Since the previous version of
MSys Git worked for me, I suspect it's somehow cygwin-related.

-- 
                                        - Jan Hudec <bulb@ucw.cz>
