From: Alexander Kitaev <Alexander.Kitaev@svnkit.com>
Subject: Re: Git GUI client SmartGit released
Date: Tue, 08 Dec 2009 15:17:36 +0100
Organization: TMate Software
Message-ID: <4B1E6000.50206@svnkit.com>
References: <4B161B15.2020106@syntevo.com> <20091202164810.GB31648@spearce.org> <4B16D8F8.90804@syntevo.com>
Reply-To: Alexander.Kitaev@svnkit.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Marc Strapetz <marc.strapetz@syntevo.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 15:58:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI1WY-0006M0-1i
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 15:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755819AbZLHO6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 09:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755799AbZLHO6d
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 09:58:33 -0500
Received: from relay1.mail.masterhost.ru ([83.222.23.61]:46585 "EHLO
	relay1.mail.masterhost.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755791AbZLHO6d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 09:58:33 -0500
X-Greylist: delayed 2455 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Dec 2009 09:58:32 EST
Received: from [UNAVAILABLE] ([194.228.14.206] helo=[192.168.42.118])
	by relay1.mail.masterhost.ru with esmtp 
	envelope from <Alexander.Kitaev@svnkit.com>
	authenticated with Alexander.Kitaev@svnkit.com
	message id 1NI0sl-0007tK-LE; Tue, 08 Dec 2009 17:17:40 +0300
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4B16D8F8.90804@syntevo.com>
X-Enigmail-Version: 0.96.0
X-SpamTest-Envelope-From: Alexander.Kitaev@svnkit.com
X-SpamTest-Group-ID: 00000000
X-SpamTest-Info: Profiles 11141 [Dec 08 2009]
X-SpamTest-Info: {relay has no DNS name}
X-SpamTest-Method: none
X-SpamTest-Rate: 40
X-SpamTest-Status: Not detected
X-SpamTest-Status-Extended: not_detected
X-SpamTest-Version: SMTP-Filter Version 3.0.0 [0284], KAS30/Release
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134886>

Hello,

>> I'm curious, did you guys replace JSch because its a pile of junk?
Above statement describes the reason behind my decision to use Trilead
SSH instead of JSCH more or less precisely.

In particular, version of JSCH we were using, used to work extremely
unreliable in case multiple channels within same connection were used
simultaneously. And code quality of JSCH didn't allow me to fix this and
other JSch issues in reasonable time.

Alexander Kitaev,
TMate Software,
http://svnkit.com/ - Java [Sub]Versioning Library!
http://sqljet.com/ - Java SQLite Library!

Marc Strapetz wrote:
>> I noticed you use JGit and the Trilead SSH client.
>>
>> I'm curious, did you guys replace JSch because its a pile of junk?
>> Did you patch JGit to use Trilead SSH instead of JSch?  If so,
>> would you be interested in contributing that change back to JGit?
>> I'm rather fed up with JSch...  :-)
> 
> We currently don't use JGit's transport, but we plant a custom SSH
> client on the git executable which connects back to SmartGit and just
> tunnels SSH data through. Anyway, I can remember that SVNKit was using
> JSch initially and they switched to Trilead because of problems with
> JSch (maybe Alexander in Cc can shed more light on that).
> 
> --
> Best regards,
> Marc Strapetz
> =============
> syntevo GmbH
> http://www.syntevo.com
> http://blog.syntevo.com
> 
> 
> 
> Shawn O. Pearce wrote:
>> Marc Strapetz <marc.strapetz@syntevo.com> wrote:
>>> We are proud to announce the general availability of our Git client
>>> SmartGit[1]:
>>>
>>>  http://www.syntevo.com/smartgit/index.html
>> Congrats on your release.
>>
>> I noticed you use JGit and the Trilead SSH client.
>>
>> I'm curious, did you guys replace JSch because its a pile of junk?
>> Did you patch JGit to use Trilead SSH instead of JSch?  If so,
>> would you be interested in contributing that change back to JGit?
>> I'm rather fed up with JSch...  :-)
>>
> 
