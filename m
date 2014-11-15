From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git push --all --tags
Date: Sat, 15 Nov 2014 19:33:30 +0100
Message-ID: <87389kb9fp.fsf@igel.home>
References: <loom.20141115T054352-272@post.gmane.org>
	<20141115185836.103fc4f493ad55725eab38f0@domain007.com>
	<20141115175655.GA27247@odin.ulthar.us>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ryan Jacobs <ryan.mjacobs@gmail.com>, git@vger.kernel.org
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Nov 15 19:33:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpiAH-0006O0-6z
	for gcvg-git-2@plane.gmane.org; Sat, 15 Nov 2014 19:33:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754314AbaKOSdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2014 13:33:36 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:57819 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754243AbaKOSdf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2014 13:33:35 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3jg4tg4n5mz3hjXq;
	Sat, 15 Nov 2014 19:33:31 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3jg4tg4HPFzvh1r;
	Sat, 15 Nov 2014 19:33:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id q8ScMMcC4S_V; Sat, 15 Nov 2014 19:33:30 +0100 (CET)
X-Auth-Info: 3EsHCADFgb+MXtI3eWCQxk/bfaFfvYacpuagMzKi6rwc9k31qhdKKWhH3Deqrb2Q
Received: from igel.home (ppp-93-104-152-230.dynamic.mnet-online.de [93.104.152.230])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sat, 15 Nov 2014 19:33:30 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 8EA1A2C2513; Sat, 15 Nov 2014 19:33:30 +0100 (CET)
X-Yow: Yow!  It's some people inside the wall!  This is better than mopping!
In-Reply-To: <20141115175655.GA27247@odin.ulthar.us> (Scott Schmit's message
	of "Sat, 15 Nov 2014 12:56:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Scott Schmit <i.grok@comcast.net> writes:

> On Sat, Nov 15, 2014 at 06:58:36PM +0300, Konstantin Khomoutov wrote:
>> On Sat, 15 Nov 2014 04:44:19 +0000 (UTC) Ryan Jacobs wrote:
>> > $ git push --all --tags
>> > error: --all and --tags are incompatible
>> > 
>> > Why are these flags incompatible? Just wondering 'cause I think that
>> > it would be a good feature to be able to push all of your branches
>> > and all of your tags to the server in one quick and simple command.
>> 
>>   git push --mirror
>> 
>> should do this.
>
> Except that mirror also deletes anything removed locally.  --all and
> --tags don't.

And --mirror pushes really all refs, including remote-tracking ones,
mirroring all ref namespaces as is.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
