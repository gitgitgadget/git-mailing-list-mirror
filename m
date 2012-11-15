From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: Git does not understand absolute Win'dos' path
Date: Thu, 15 Nov 2012 19:20:04 +0000
Message-ID: <50A54064.9060003@ramsay1.demon.co.uk>
References: <1352884329.28981.YahooMailNeo@web162504.mail.bf1.yahoo.com> <50A36844.3090000@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Martin Lichtin <lichtin@yahoo.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Nov 15 20:23:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZ51g-0006cP-3T
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 20:23:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1768773Ab2KOTWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 14:22:42 -0500
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:39512 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768727Ab2KOTWl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 14:22:41 -0500
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 991DEA648C0;
	Thu, 15 Nov 2012 19:22:40 +0000 (GMT)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id F31BFA6487E;	Thu, 15 Nov 2012 19:22:39 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;	Thu, 15 Nov 2012 19:22:39 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <50A36844.3090000@viscovery.net>
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209843>

Johannes Sixt wrote:
> Am 11/14/2012 10:12, schrieb Martin Lichtin:
>> Maven's release plugin prepares a call Git like in this example:
>>
>> cmd.exe /X /C "git commit --verbose -F
>> C:\cygwin\tmp\maven-scm-915771020.commit pom.xml"
>>
>> Git doesn't seem to understand the -F argument and treats it like a
>> relative path (relative to the repository root):
>>
>> $ cmd.exe /X /C "git commit --verbose -F C:\cygwin\tmp\commit pom.xml" 
>> fatal: could not read log file 'mytestdir/C:\cygwin\tmp\commit': No
>> such file or directory
> 
> According to the code, this should not happen if you are using msysgit.
> For this reason, I guess you are using Cygwin git. Right?
> 
> I don't know what Cygwin programs are supposed to do if they receive an
> argument that looks like a Windows style absolute path.
> 
> OTOH, it could be argued that Maven should not treat a Cygwin program like
> a DOS program, and it should pass the path in the POSIXy form
> /c/cygwin/tmp/commit or /tmp/commit.

I would argue precisely this! :-D

ATB,
Ramsay Jones
