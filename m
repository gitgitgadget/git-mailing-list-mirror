From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: Anyone running GIT on native Windows
Date: Fri, 11 May 2007 01:00:55 -0300
Message-ID: <4643EA77.4040803@xs4all.nl>
References: <2b6901c78faa$cf9aa7e0$0200a8c0@AMD2500>		 <7vejlufmhd.fsf@assigned-by-dhcp.cox.net>		 <2b7f01c78fb1$be4dc6a0$0200a8c0@AMD2500>		 <463ECEF4.625F3633@eudaptics.com> <e5bfff550705070448t7813d064mbac82abb45591888@mail.gmail.com> <463F14FF.F8DF11EB@eudaptics.com> <46415106.5040401@xs4all.nl> <46417351.6BBA9313@eudaptics.com>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marco Costalba <mcostalba@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Fri May 11 06:01:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmMJq-0005Aq-I3
	for gcvg-git@gmane.org; Fri, 11 May 2007 06:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754728AbXEKEBV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 00:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753699AbXEKEBV
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 00:01:21 -0400
Received: from smtp-vbr15.xs4all.nl ([194.109.24.35]:2290 "EHLO
	smtp-vbr15.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754728AbXEKEBV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 00:01:21 -0400
Received: from [192.168.1.100] (c911deb6.bhz.virtua.com.br [201.17.222.182])
	(authenticated bits=0)
	by smtp-vbr15.xs4all.nl (8.13.8/8.13.8) with ESMTP id l4B41EnY066265
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 May 2007 06:01:16 +0200 (CEST)
	(envelope-from hanwen@xs4all.nl)
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <46417351.6BBA9313@eudaptics.com>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46933>

Johannes Sixt escreveu:
> Han-Wen Nienhuys wrote:
>> I packaged Mingw GIT using NSIS some time ago; see
>>
>>   http://lilypond.org/git/binaries/mingw/
>>
>> Due various personal reasons, I haven't been able to update this, but I
>> will package a new version soon. Please try it to see whether there are
>> any rough edges.
> 
> I've tried this shortly after you released it. But it did not work as
> expected. The symtom was (IIRC) that a simple
> 
>    git init
> 
> said that 'init' is not a git-command. I tried this from CMD, not rxvt.

I don't know; I've tested it with Wine under Linux only. Maybe it couldn't 
find the git-init.exe binary, have you checked that c:/Program Files/Git/usr/bin/ 
was in the path?

> relocation (i.e. an arbitrary installation directory). Could you please
> package the latest version from the 'devel' branch?
> 
>   git://repo.or.cz/git/mingw.git

http://lilypond.org/git/binaries/mingw/git-1.5.1-1.mingw.exe

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
