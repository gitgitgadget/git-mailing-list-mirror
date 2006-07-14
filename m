From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] urls.txt: Use substitution to escape square brackets
Date: Fri, 14 Jul 2006 16:13:42 -0700
Message-ID: <7v8xmvok49.fsf@assigned-by-dhcp.cox.net>
References: <11528726881431-git-send-email-alp@atoker.com>
	<20060714215039.GA21994@diku.dk>
	<7vfyh3on6w.fsf@assigned-by-dhcp.cox.net> <44B82243.20604@atoker.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Jul 15 01:13:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1Wqy-00053d-C6
	for gcvg-git@gmane.org; Sat, 15 Jul 2006 01:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945899AbWGNXNo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 14 Jul 2006 19:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945902AbWGNXNo
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 19:13:44 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:689 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1945899AbWGNXNn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jul 2006 19:13:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060714231342.VKOI2704.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 14 Jul 2006 19:13:42 -0400
To: git@vger.kernel.org
In-Reply-To: <44B82243.20604@atoker.com> (Alp Toker's message of "Sat, 15 Jul
	2006 00:01:23 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23915>

Alp Toker <alp@atoker.com> writes:

> Junio C Hamano wrote:
>>
>> Looks nicer.  Alp?  Does this work with your version of
>> asciidoc?
>
> I'm using asciidoc 7.0.2, which came with Ubuntu Dapper.
>
> The man page output now looks like this:
>
>        =B7  ssh://[ # [user@] # ]host.xz/path/to/repo.git/
>        =B7  ssh://[ # [user@] # ]host.xz/~user/path/to/repo.git/
>        =B7  ssh://[ # [user@] # ]host.xz/~/path/to/repo.git

I got a bit inventive and removed the comments after #, which
were in Jonas's version, when I tried it out.  Maybe doing the
same might help you, since I suspect the above '#' are coming
from the comment part.

> Out of the three patches,
>
>   (at) "ssh://[user@]host.xz/path/to/repo.git/"
>   (jc) "ssh://+++[user@+++]host.xz/path/to/repo.git/"
>   (jf) "ssh://{startsb}user@{endsb}host.xz/path/to/repo.git/"
>
> I'd say (at) is still most readable, not requiring +++ markup (jc) or
> hacks to asciidoc.conf (jf).

I do not think defining [attribute] is a hack; it is a
documented feature.
