From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [fixed PATCH] git-filter-branch.sh: Fix broken setting of GIT_DIR
Date: Sat, 11 Aug 2007 20:51:51 +0800
Message-ID: <46BDB0E7.3020506@midwinter.com>
References: <868x8j7aj2.fsf@lola.quinscape.zz>	<864pj74ay9.fsf@lola.quinscape.zz>	<7vk5s2mllf.fsf@assigned-by-dhcp.cox.net>	<85r6mawedp.fsf@lola.goethe.zz> <858x8iw9q1.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Aug 11 14:52:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJqS0-0004oV-5p
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 14:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbXHKMv5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 08:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbXHKMv5
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 08:51:57 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:54329 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751274AbXHKMv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 08:51:56 -0400
Received: (qmail 26362 invoked from network); 11 Aug 2007 12:51:56 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=vQhvQPgd2XZFlSS2FPMBcbgPgyRO9sObUvlxVoZd/sTrmhEzCpNf42Xl2hrTFSlr  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 11 Aug 2007 12:51:55 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <858x8iw9q1.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55609>

David Kastrup wrote:
> Actually, wouldn't by far the most straightforward thing be if
> git-rev-parse --git-dir always returned an absolute path (even when
> being passed a relative path in GIT_DIR)?
>   

That might also help get rid of an annoying failure mode where some git 
commands (the shell script ones) fail if you cd into a git repository 
via a symlink, while others (the builtins) work just fine.

-Steve
