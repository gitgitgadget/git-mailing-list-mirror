From: Rafael Kitover <rkitover@io.com>
Subject: Re: ignoring file modes completely
Date: Sun, 06 Feb 2011 15:29:56 -0500
Organization: CPAN
Message-ID: <4D4F04C4.6020401@io.com>
References: <4D4D6BC2.90101@io.com>	<1296921829.5467.1.camel@localhost.localdomain>	<4D4D7636.7090608@io.com>	<4D4D81C9.5080002@op5.se>	<4D4DA4C1.5050501@io.com>	<4D4E9EAC.4030508@drmicha.warpmail.net>	<4D4EC3FD.5010000@io.com>	<4D4EC8E6.2090200@io.com> <AANLkTikCKZetZXRCZSLiM73engBcyxNfCtBN5yWdEgRs@mail.gmail.com>
Reply-To: rkitover@io.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 06 21:30:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmBFd-0006Dj-Av
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 21:30:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291Ab1BFUaY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 15:30:24 -0500
Received: from smtp.prismnet.com ([209.198.128.91]:52236 "EHLO
	smtp.prismnet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753020Ab1BFUaY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 15:30:24 -0500
Received: from [127.0.0.1] (c-76-98-235-160.hsd1.pa.comcast.net [76.98.235.160])
	(authenticated bits=0)
	by smtp.prismnet.com (8.14.4/8.14.4) with ESMTP id p16KULoE038803
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sun, 6 Feb 2011 14:30:22 -0600 (CST)
	(envelope-from rkitover@io.com)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <AANLkTikCKZetZXRCZSLiM73engBcyxNfCtBN5yWdEgRs@mail.gmail.com>
X-Spam-Status: No, score=0.0 required=10.0 tests=RDNS_DYNAMIC
	autolearn=disabled version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on smtp.prismnet.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166199>

On 2/6/2011 1:10 PM, Dmitry Potapov wrote:
> On Sun, Feb 06, 2011 at 11:14:30AM -0500, Rafael Kitover wrote:
>> $ git diff HEAD
>> diff --git a/README b/README
>> old mode 100644
>> new mode 100755
>> $ git config --global core.filemode
>> false
>
> This is because core.filemode is set in the local configuration:
> $ git config core.filemode
> true
>
> Git automatically detects if chmod(2) is supported on the current file
> system and sets core.filemode to the corresponding value. Because cygwin
> emulates chmod(), git sets core.filemode to true.

That was it! Thank you very much. I can now use msysGit and Cygwin git 
together, very cool.
