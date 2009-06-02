From: Raman Gupta <rocketraman@fastmail.fm>
Subject: Re: Cygwin: Initial clone of repo containing .gitattributes has modified
 files
Date: Tue, 02 Jun 2009 11:56:22 -0400
Message-ID: <4A254BA6.3080601@fastmail.fm>
References: <4A251F66.2020809@fastmail.fm> <7vd49mfxcv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 18:03:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBWSJ-000358-Eq
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 18:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053AbZFBQDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 12:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751874AbZFBQDG
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 12:03:06 -0400
Received: from smtp102.rog.mail.re2.yahoo.com ([206.190.36.80]:26274 "HELO
	smtp102.rog.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751264AbZFBQDF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jun 2009 12:03:05 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jun 2009 12:03:05 EDT
Received: (qmail 77742 invoked from network); 2 Jun 2009 15:56:26 -0000
Received: from unknown (HELO apollo.rocketraman.com) (rocketraman@99.224.155.40 with login)
  by smtp102.rog.mail.re2.yahoo.com with SMTP; 2 Jun 2009 15:56:26 -0000
X-YMail-OSG: zrTQh5IVM1npStZXUrK6QtksVa5QuLvC3Q5AhxwyY4mPJeBZSXMWBfYfCYdD8fBKFA--
X-Yahoo-Newman-Property: ymail-3
Received: from localhost (localhost.localdomain [127.0.0.1])
	by apollo.rocketraman.com (Postfix) with ESMTP id DCC8921C0528;
	Tue,  2 Jun 2009 11:56:25 -0400 (EDT)
X-Virus-Scanned: amavisd-new at rocketraman.com
Received: from apollo.rocketraman.com ([127.0.0.1])
	by localhost (apollo.rocketraman.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P2mcn5Y+iNij; Tue,  2 Jun 2009 11:56:22 -0400 (EDT)
Received: from [192.168.1.5] (zeus.rocketraman.com [192.168.1.5])
	by apollo.rocketraman.com (Postfix) with ESMTP id A663A21C0527;
	Tue,  2 Jun 2009 11:56:22 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <7vd49mfxcv.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 0.95.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120526>

Junio C Hamano wrote:
> Raman Gupta <rocketraman@fastmail.fm> writes:
> 
>> When a repository containing a .gitattributes file, which contains
>> other files with -crlf set is cloned on cygwin, with autocrlf = true,
>> the initial checkout of the working copy sets the line endings for the
>> -crlf files incorrectly (it ignores the .gitattributes, presumably
>> because it hasn't been checked out yet).
> 
> I think this is what v1.6.3-rc0~83^2~1 (Read attributes from the index
> that is being checked out, 2009-03-13) was about.

Thanks! I looked for the fix but didn't find any reference to it. Sorry.

> I see you are using 

Actually, I use Linux -- its my coworkers that use cygwin! Bleh! :)

> a version based on 1.6.1.2; isn't there a newer Cygwin
> packaged one available?

Nope. That is the latest available as of this morning (at least in the
cygwin non-experimental branch).

Cheers,
Raman
