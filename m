From: Christian <crich-ml@beronet.com>
Subject: Re: git push over http is very dangerous
Date: Sun, 22 Apr 2007 09:21:37 +0200
Message-ID: <462B0D01.7000102@beronet.com>
References: <462394AC.303@beronet.com>	<7vfy6uwncc.fsf@assigned-by-dhcp.cox.net> <462A44B6.30404@beronet.com> <7v4pn9vaye.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 22 09:22:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfWPN-0006pi-CA
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 09:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754142AbXDVHWe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 03:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754149AbXDVHWe
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 03:22:34 -0400
Received: from beronet.com ([80.244.243.34]:3511 "EHLO mail.beronet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754148AbXDVHWd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 03:22:33 -0400
Received: from mail.beronet.com (localhost [127.0.0.1])
	by mail.beronet.com (Postfix) with ESMTP id 788EB510C6D;
	Sun, 22 Apr 2007 09:31:10 +0200 (CEST)
Received: from [192.168.2.6] (port-212-202-210-130.dynamic.qsc.de [212.202.210.130])
	by mail.beronet.com (Postfix) with ESMTP id 5161A510C2F;
	Sun, 22 Apr 2007 09:31:10 +0200 (CEST)
User-Agent: Icedove 1.5.0.7 (X11/20061013)
In-Reply-To: <7v4pn9vaye.fsf@assigned-by-dhcp.cox.net>
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on m24s12.beronet.com
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=5.0 tests=RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45224>

Junio C Hamano wrote:
> Christian <crich-ml@beronet.com> writes:
>
>   
>> The central machine is a  AMD Sempron, it runs Debian Sarge (3.1)
>> We've installed git from source, because sarge has it not in its
>> archives.
>>
>> Maybe we did something wrong at building time ? or you're right and
>> the debian sarge zlib does not fit good to the current git versions ?
>>     
>
> What I have been suspecting since I got that not-corrupted but
> reported to be corrupt tree is that the version running on your
> "unable to fsck" machine -- the one you use as the central
> machine -- has a dud (or miscompiled) version of git, which
> somehow reports corruption incorrectly on perfectly good
> objects when it validates it before using them.
>   
well if you like i can give you an account to that machine offlist, i 
could show you in a screen session where everything is.
> And to that machine, push over http succeeds fine only because
> push over http is "dangerous" in that it does not "validate" the
> pushed data on the receiving end like other codepaths do.
>
> It would be interesting to find out what the breakage is on that
> central machine.  I think enough people run Sarge that it is
> unlikely it's zlib at fault, but the way git uses the zlib API,
> which was cleaned up in the current tree with the two fixes from
> Linus I mentioned earlier.
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>   
