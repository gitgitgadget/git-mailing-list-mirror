From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] autoconf: clean temporary file mak.append
Date: Tue, 08 Aug 2006 14:35:02 -0700
Message-ID: <7vbqquvrll.fsf@assigned-by-dhcp.cox.net>
References: <200608081834.09271.jnareb@gmail.com>
	<7vk65juff7.fsf@assigned-by-dhcp.cox.net> <ebatsd$f1g$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 08 23:35:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAZET-0006UQ-IF
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 23:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbWHHVfG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 17:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbWHHVfG
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 17:35:06 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:38817 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S965052AbWHHVfE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Aug 2006 17:35:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060808213503.YZIZ2704.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 8 Aug 2006 17:35:03 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ebatsd$f1g$1@sea.gmane.org> (Jakub Narebski's message of "Tue,
	08 Aug 2006 22:58:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25091>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> diff --git a/Makefile b/Makefile
>> index d8cc835..d4297c2 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -793,7 +793,7 @@ clean:
>>       rm -f $(ALL_PROGRAMS) $(BUILT_INS) git$X
>>       rm -f *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags
>>       rm -rf autom4te.cache
>> -     rm -f config.log config.mak.autogen configure config.status config.cache
>> +     rm -f configure config.log config.mak.autogen config.mak.append config.status config.cache
>>       rm -rf $(GIT_TARNAME) .doc-tmp-dir
>>       rm -f $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
>>       rm -f $(htmldocs).tar.gz $(manpages).tar.gz
>
> I didn't add configure to make clean, because there was hand-crafted 
> configure script in git.git.

Did anybody ask who added 'configure'?
