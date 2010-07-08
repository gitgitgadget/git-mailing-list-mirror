From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: fixing workdirs
Date: Thu, 08 Jul 2010 12:56:15 -0600
Message-ID: <4C361F4F.9070505@workspacewhiz.com>
References: <20100708110842.GC12789@madism.org> <20100708183714.GR2480@ece.pdx.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git ML <git@vger.kernel.org>, Pierre Habouzit <madcoder@madism.org>
To: Tait <git.git@t41t.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 20:56:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWwGl-0003ab-4r
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 20:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757228Ab0GHS4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 14:56:17 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:36885 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756867Ab0GHS4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 14:56:16 -0400
Received: (qmail 2131 invoked by uid 399); 8 Jul 2010 12:56:15 -0600
Received: from unknown (HELO ?192.168.1.2?) (jjensen@workspacewhiz.com@75.231.177.28)
  by hsmail.qwknetllc.com with ESMTPAM; 8 Jul 2010 12:56:15 -0600
X-Originating-IP: 75.231.177.28
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.4) Gecko/20100608 Lightning/1.0b2 Thunderbird/3.1
In-Reply-To: <20100708183714.GR2480@ece.pdx.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150593>

  ----- Original Message -----
From: Tait
Date: 7/8/2010 12:37 PM
> Pierre Habouzit<madcoder_madism.org>  said (on 2010/07/08):
>> ...                                    The workdir HEAD reflog is then a
>> symlink to the masters.
> #include<std-symlink-rant>
>
> Windows is an especially compatibility-breaking example, not only on the
> programming side, but also in relation to user interface, and compatibility
> with other programs. Programming-wise, documentation is sparse and
> would require lots of platform-specific work-arounds. The user-interface
> support is worse than terrible. And even if git does everything right,
> there's no guarantee a copy, backup/restore, antivirus program, etc. won't
> come along and corrupt the environment git so carefully created. Many of
> those other programs don't properly handle Windows reparse points. For
> those interested, http://shell-shocked.org/article.php?id=284 gives a
> reasonable-looking overview of the details on Windows.
I'm going to go out on a limb here and say that I suspect symbolic links 
work fine in Windows Vista and 7, because they are used all over the 
file system Microsoft installs.  Symbolic links for files, in 
particular, didn't exist until Vista.

Josh
