From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] progress.c: avoid use of dynamic-sized array
Date: Sun, 08 Jun 2008 15:02:16 -0700
Message-ID: <7vve0jh9g7.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0806080924330.18454@xenau.zenez.com>
 <200806082151.m58Lp6sG014324@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Boyd Lynn Gerber <gerberb@zenez.com>,
	Git List <git@vger.kernel.org>
To: =?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 00:03:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5SzI-0005sL-In
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 00:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757833AbYFHWCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 18:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756385AbYFHWCv
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 18:02:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56884 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757833AbYFHWC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 18:02:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1B38437BE;
	Sun,  8 Jun 2008 18:02:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5126F37BD; Sun,  8 Jun 2008 18:02:21 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 94F6236E-35A6-11DD-A23C-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84332>

しらいしななこ  <nanako3@bluebottle.com> writes:

> Quoting Boyd Lynn Gerber <gerberb@zenez.com>:
>
>> Dynamically sized arrays are gcc and C99 construct.  Using them hurts
>> portability to older compilers, although using them is nice in this case
>> it is not desirable.  This patch removes the only use of the construct
>> in stop_progress_msg(); the function is about writing out a single line
>> of a message, and the existing callers of this function feed messages
>> of only bounded size anyway, so use of dynamic array is simply overkill.
>>
>> Signed-off-by: Boyd Lynn Gerber <gerberb@zenez.com>
>
> I may be mistaken but isn't this Junio's patch?  If so (quoting
> from SubmittingPatches document):
>
>   If you are forwarding a patch from somebody else, optionally, at
>   the beginning of the e-mail message just before the commit
>   message starts, you can put a "From: " line to name that person.

Heh, thanks for being picky ;-)

Something this small, either way is fine by me.  Besides, I've applied the
patch (and the other one) from Boyd already.
