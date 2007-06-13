From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Add gitmodules(5)
Date: Wed, 13 Jun 2007 09:20:05 -0700
Message-ID: <7vd4zzg72i.fsf@assigned-by-dhcp.pobox.com>
References: <1181425132239-git-send-email-hjemli@gmail.com>
	<11814251322779-git-send-email-hjemli@gmail.com>
	<20070613153611.GA11852@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Wed Jun 13 18:20:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyVa3-0001TA-3C
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 18:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759321AbXFMQUJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 12:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759317AbXFMQUI
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 12:20:08 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:46094 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759309AbXFMQUG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 12:20:06 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070613162006.CWUS6565.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 13 Jun 2007 12:20:06 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id B4L51X00X1kojtg0000000; Wed, 13 Jun 2007 12:20:06 -0400
In-Reply-To: <20070613153611.GA11852@moooo.ath.cx> (Matthias Lederhofer's
	message of "Wed, 13 Jun 2007 17:36:11 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50088>

Matthias Lederhofer <matled@gmx.net> writes:

> Lars Hjemli <hjemli@gmail.com> wrote:
>> +SYNOPSIS
>> +--------
>> +.gitmodules
>
> My asciidoc (7.1.2 and 8.2.1) generates an empty refsynopsisdiv from
> this.  xmlto refuses to convert this into anything else:
> ...
> This breaks the build process for the documentation.  I could not find
> out how to fix this.  Probably just needs the right quoting for the
> dot at the beginning of the line.

Sorry, I should have caught this much earlier, as already knew
about this issue when I did gitattributes(5).

As it seems to be customary not to even say 'dot' at the
beginning for man(5) section (existing examples I found are
netrc, postgresrc, procmailrc, ...), I think the best fix is
just to do s/\.gitmodules/gitmodules/ there.
