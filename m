From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/3] git-daemon: plug new upload-tar command
Date: Sat, 02 Sep 2006 12:36:20 +0200
Organization: At home
Message-ID: <edbmqp$bns$1@sea.gmane.org>
References: <11570277231100-git-send-email-vagabon.xyz@gmail.com> <44F72039.3040206@lsrfire.ath.cx> <cda58cb80609020114h1e1ee553saf5aa90df8bc3ba0@mail.gmail.com> <7vfyfa1rvf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Sep 02 12:36:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJSrU-0001uQ-DD
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 12:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbWIBKgZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 06:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbWIBKgZ
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 06:36:25 -0400
Received: from main.gmane.org ([80.91.229.2]:14559 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751014AbWIBKgZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Sep 2006 06:36:25 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GJSrI-0001sW-GY
	for git@vger.kernel.org; Sat, 02 Sep 2006 12:36:16 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Sep 2006 12:36:16 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Sep 2006 12:36:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26328>

Junio C Hamano wrote:

> "Franck Bui-Huu" <vagabon.xyz@gmail.com> writes:
> 
>>> So if you beat me to it, that would be great.  Or if you have a better
>>> idea, that would be also great. :-)
>>
>> Well I'll try to start something, not sure to have a lot of time
>> though. Please contact me before starting anything, I would be sad to
>> write something for /dev/null again ;)
> 
> I do not necessarily think your effort were for /dev/null; for
> example, I was hoping you defend [PATCH 3/3].
> 
> While it makes sense to make "tar-tree --remote" usable outside
> a git managed repository, I think people expect the connection
> to obey core.gitproxy if the command is run inside a repository
> that has a configuration file.

If I remember correclty git now support (totally undocumented) per-user
configuration file, so one can have core.gitproxy even outside git
repository. Although some warning that you are running from outside
repository and configuration might be not what you want would be nice. 

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
