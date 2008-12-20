From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: fix typos, grammar, asciidoc syntax
Date: Sat, 20 Dec 2008 12:08:51 -0800
Message-ID: <7v3agiy5gs.fsf@gitster.siamese.dyndns.org>
References: <200812191314.19302.markus.heidelberg@web.de>
 <7v3agj1gvp.fsf@gitster.siamese.dyndns.org>
 <200812201418.38707.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Sat Dec 20 21:10:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LE89n-0001hc-G2
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 21:10:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbYLTUI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 15:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753198AbYLTUI6
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 15:08:58 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50363 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181AbYLTUI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 15:08:57 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DAFC38736C;
	Sat, 20 Dec 2008 15:08:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0B2A18736B; Sat,
 20 Dec 2008 15:08:53 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 084ED67A-CED2-11DD-9FAE-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103657>

Markus Heidelberg <markus.heidelberg@web.de> writes:

> Junio C Hamano, 20.12.2008:
>> Markus Heidelberg <markus.heidelberg@web.de> writes:
>> 
>> > @@ -172,7 +172,7 @@ only the primary branches.  In addition, if you happen to be on
>> >  your topic branch, it is shown as well.
>> >  
>> >  ------------
>> > -$ git show-branch --reflog='10,1 hour ago' --list master
>> > +$ git show-branch --reflog="10,1 hour ago" --list master
>> >  ------------
>> 
>> Is this just a personal taste, or a correction to typography?
>
> When using single quotes, the manpage displayed backticks.

It does not seem to do that to me:

    $ git help show-branch | grep 10,1 | od -bc
    0000000 040 040 040 040 040 040 040 040 040 040 044 040 147 151 164 040
                                                      $       g   i   t
    0000020 163 150 157 167 055 142 162 141 156 143 150 040 055 055 162 145
              s   h   o   w   -   b   r   a   n   c   h       -   -   r   e
    0000040 146 154 157 147 075 342 200 231 061 060 054 061 040 150 157 165
              f   l   o   g   = 342 200 231   1   0   ,   1       h   o   u
    0000060 162 040 141 147 157 342 200 231 040 055 055 154 151 163 164 040
              r       a   g   o 342 200 231       -   -   l   i   s   t
    0000100 155 141 163 164 145 162 012
              m   a   s   t   e   r  \n

It does not use ASCII single quote ' (\047) but the result still does
render well enough to keep anybody who are typing, following the printed
examples, from mistaking it from a backquote:

    http://pics.livejournal.com/gitster/pic/00009pk0/g6

But in this particular case, because sq/dq does not make any difference to
the example, I am Ok to change it to dq.  But I suspect there are many
other places that do need to use sq in examples, so...
