From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: [PATCH] Add git-bundle - pack objects and references for
 disconnected transfer
Date: Fri, 16 Feb 2007 18:25:48 -0500
Message-ID: <45D63D7C.40205@verizon.net>
References: <7238711.2657861171629916957.JavaMail.root@vms064.mailsrvcs.net>
 <Pine.LNX.4.63.0702161443370.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 17 00:34:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HICav-0004gS-CB
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 00:34:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946291AbXBPXeW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 18:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946293AbXBPXeW
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 18:34:22 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:49254 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946291AbXBPXeV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 18:34:21 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JDK00AUFX2ZEO70@vms044.mailsrvcs.net> for
 git@vger.kernel.org; Fri, 16 Feb 2007 17:25:52 -0600 (CST)
In-reply-to: <Pine.LNX.4.63.0702161443370.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39961>

Johannes Schindelin wrote:
> Hi,
>
> On Fri, 16 Feb 2007, Mark Levedahl wrote:
>
>   
>> ... I *tried* that, and it fails under Cygwin. Apparently cygwin's bash 
>> (or something) mangles data in the pipe (99% certain it will turn out to 
>> be a latent crlf issue)...
>>     
>
> Have you tried
>
> 	export CYGWIN=binmode
>
> before that? (If it works, you have to make sure that other settings as 
> "ntsec" are retained in that environment variable, but not "nobinmode").
>
> Hth,
> Dscho
In a word, yes. I tried many things with mount and CYGWIN, none fixed 
the problem. What I don't have is a simple test case I can push upstream 
to demonstrate the failure mode. However, if this is a crlf issue I 
suspect this would not work in msys either, regardless of being able to 
find the issue in Cygwin.

Mark
