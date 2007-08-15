From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: [msysGit] Re: Need your help with MinGW Issue 17: --color options
 don't work (produce garbage)
Date: Thu, 16 Aug 2007 00:04:19 +0200
Message-ID: <46C37863.4020203@dawes.za.net>
References: <a1bbc6950708142329w4e0e3d7cq573c67dd3b28f03a@mail.gmail.com>	<3f4fd2640708150032l7441b285mc2cc9e22702bce21@mail.gmail.com>	<Pine.LNX.4.64.0708151708570.19222@wbgn129.biozentrum.uni-wuerzburg.de>	<46C36E7C.1080501@dawes.za.net> <7vsl6ko51b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Reece Dunn <msclrhd@googlemail.com>,
	msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 00:05:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILQz7-0000nm-CV
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 00:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757804AbXHOWE6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 18:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758169AbXHOWE6
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 18:04:58 -0400
Received: from sd-green-bigip-177.dreamhost.com ([208.97.132.177]:34963 "EHLO
	spunkymail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757661AbXHOWE5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Aug 2007 18:04:57 -0400
Received: from [192.168.201.100] (dsl-146-27-164.telkomadsl.co.za [165.146.27.164])
	by spunkymail-a5.g.dreamhost.com (Postfix) with ESMTP id C472E14D6B0;
	Wed, 15 Aug 2007 15:04:50 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vsl6ko51b.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55956>

Junio C Hamano wrote:
> Rogan Dawes <lists@dawes.za.net> writes:
> 
>> Users that *do* need to use rxvt or SSH should simply disable the
>> color mode, or alternatively, use the cygwin version. Color, while
>> useful, is hardly critical functionality.
> 
> Heh, that almost suggests that the native Windows command.com
> support can disable the color without upsetting anybody ;-)
> 

If that is the easiest way, yes.

I *do* think that trying to get color working on the DOS cmdline is a 
worthy goal. I just don't think it is worth overcomplicating the issue 
and trying to handle rare corner cases such as someone SSHing into a 
Windows box, or running CMD inside rxvt.

One approach that might be more compatible with the existing escape code 
approach is to define the appropriate ANSI color escape sequences. Ah, a 
bit more googling shows that cmd.exe doesn't handle ANSI sequences in 
Windows NT and later.

Regards,

Rogan
