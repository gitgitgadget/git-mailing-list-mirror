From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git files data formats documentation
Date: Sat, 05 Aug 2006 17:37:16 -0700
Message-ID: <7vejvud7ib.fsf@assigned-by-dhcp.cox.net>
References: <44D42F0D.3040707@gmail.com>
	<7vac6jfzem.fsf@assigned-by-dhcp.cox.net> <44D5141A.2070004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 06 02:37:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9We0-0007oT-MP
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 02:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbWHFAhT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 20:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWHFAhT
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 20:37:19 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:38640 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751473AbWHFAhS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 20:37:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060806003717.UZUC554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 5 Aug 2006 20:37:17 -0400
To: gitzilla@gmail.com
In-Reply-To: <44D5141A.2070004@gmail.com> (A. Large Angry's message of "Sat,
	05 Aug 2006 14:56:42 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24950>

A Large Angry SCM <gitzilla@gmail.com> writes:

> Junio C Hamano wrote:
> ...
>>> <OCTAL_MODE>
>>> 	# Octal encoding, without prefix, of the file system object
>>> 	# type and permission bits. The bit layout is according to the
>>> 	# POSIX standard, with only regular files, directories, and
>>> 	# symbolic links permitted. The actual permission bits are
>>> 	# all zero except for regular files. The only permission bit
>>> 	# of any consequence to Git is the owner executable bit. By
>>> 	# default, the permission bits for files will be either 0644
>>> 	# or 0755, depending on the owner executable bit.
>>> 	;
>>
>> It's not really "by default" -- more like "by definition", since
>> there is no way for the program to use something different.  We
>> used to record non-canonical modes in ancient versions of git,
>> but I think fsck-objects would warn on objects created that way.
>>
>
> See git-mktree.

That's a bad example -- the tool being too loose.
