From: Sam Vilain <sam@vilain.net>
Subject: Re: Decompression speed: zip vs lzo
Date: Fri, 11 Jan 2008 11:28:52 +1300
Message-ID: <47869C24.3000400@vilain.net>
References: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com> <7v4pdmfw27.fsf@gitster.siamese.dyndns.org> <47855765.9090001@vilain.net> <alpine.LSU.1.00.0801092328580.31053@racer.site> <47856E8D.4010006@vilain.net> <4785A6DB.3080007@vilain.net> <20080110091607.GA17944@artemis.madism.org> <alpine.LFD.1.00.0801101332150.3054@xanadu.home> <alpine.LFD.1.00.0801101252030.3148@woody.linux-foundation.org> <478691EB.1080704@vilain.net> <alpine.LFD.1.00.0801101400550.3148@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 10 23:29:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD5uJ-00055f-Js
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 23:29:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755012AbYAJW27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 17:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756192AbYAJW27
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 17:28:59 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:49658 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756039AbYAJW26 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 17:28:58 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id 8FF5421D193; Fri, 11 Jan 2008 11:28:56 +1300 (NZDT)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 22F3521D192;
	Fri, 11 Jan 2008 11:28:53 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <alpine.LFD.1.00.0801101400550.3148@woody.linux-foundation.org>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70106>

Linus Torvalds wrote:
>> wilber:~/src/perl-preview$ du -sk .git
>> 73274   .git
>> wilber:~/src/perl-preview$ git-repack -a
>> Counting objects: 244360, done.
>> Compressing objects: 100% (55493/55493), done.
>> Writing objects: 100% (244360/244360), done.
>> Total 244360 (delta 181061), reused 244360 (delta 181061)
>> wilber:~/src/perl-preview$ du -sk .git/objects/pack/
>> 75389   .git/objects/pack/
> 
> Hmm. I'm not sure I understand what this was supposed to show?
> 
> You reused all the old deltas, and you did "du -sk" on two different 
> things before/after (and didn't do a "-a -d" to repack the old pack 
> either). So does the result actually have anything to do with any 
> compression algorithm?
> 
> Use "-a -d -f" to repack a whole archive.

Drat, guess that means I'll have to recompute the deltas - I was trying
to avoid that.

Ok, see you in an hour or two, hopefully sans bonehead mistakes this time :)

Sam.
