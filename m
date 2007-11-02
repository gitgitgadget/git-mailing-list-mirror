From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] post-update hook: update working copy
Date: Fri, 02 Nov 2007 10:28:20 -0700
Message-ID: <472B5E34.60709@midwinter.com>
References: <1193964304-10847-1-git-send-email-sam.vilain@catalyst.net.nz> <7vd4ut7948.fsf@gitster.siamese.dyndns.org> <472AFD39.6000006@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Sam Vilain <sam.vilain@catalyst.net.nz>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Nov 02 18:28:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io0Jz-0003Ad-Uh
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 18:28:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757609AbXKBR2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 13:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757427AbXKBR2Y
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 13:28:24 -0400
Received: from tater.midwinter.com ([216.32.86.90]:54939 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754636AbXKBR2X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 13:28:23 -0400
Received: (qmail 12623 invoked from network); 2 Nov 2007 17:28:22 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=XC5RdFEzV774zrS15J3U8Q29rEoKStHGD6yTJ8iki6XYS+hLw1UC1VdMYkeJXqAy  ;
Received: from localhost (HELO sgrimm-mbp.lan) (koreth@127.0.0.1)
  by localhost with SMTP; 2 Nov 2007 17:28:22 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <472AFD39.6000006@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63146>

Andreas Ericsson wrote:
>>  - Who guarantees that a human user is not actively editing the
>>    work tree files without saving?
> There are times when one simply doesn't care.
>
> I realize that for my situation, a much simpler script can (and is) 
> used, so
> I agree with your concerns. The idea that every git repo has a human 
> hacking
> on it isn't true though, so doing things like this are sometimes useful,
> timesaving and a real help.

Yeah, that's absolutely true. My use cases would be twofold. First, a 
public reference tree on a shared development server where people can 
look over my corner of the code base without having to check the whole 
thing out for themselves.

Second, a Web server with a bunch of static text/image files and PHP 
scripts. If I can deploy by just pushing to a "current release" branch, 
that saves me from having to first push then ssh to the machine and do 
"git reset --hard".

Neither one of those things is impossible to do with vanilla git. They 
just require extra busywork steps at the moment if you don't use an 
"update the working copy on push" hook.

-Steve
