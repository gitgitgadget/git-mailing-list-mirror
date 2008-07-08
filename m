From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GiT and CentOS 5.2
Date: Tue, 08 Jul 2008 12:23:30 -0700
Message-ID: <7vtzf0tc25.fsf@gitster.siamese.dyndns.org>
References: <49523.216.185.71.22.1215539200.squirrel@webmail.harte-lyne.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "James B. Byrne" <byrnejb@harte-lyne.ca>
X-From: git-owner@vger.kernel.org Tue Jul 08 21:24:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGInq-0001yM-Ip
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 21:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872AbYGHTXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 15:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752378AbYGHTXo
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 15:23:44 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40228 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbYGHTXo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 15:23:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 94C7E1452C;
	Tue,  8 Jul 2008 15:23:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C06A01452B; Tue,  8 Jul 2008 15:23:39 -0400 (EDT)
In-Reply-To: <49523.216.185.71.22.1215539200.squirrel@webmail.harte-lyne.ca>
 (James B. Byrne's message of "Tue, 8 Jul 2008 13:46:40 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 604F01F0-4D23-11DD-9145-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87788>

"James B. Byrne" <byrnejb@harte-lyne.ca> writes:

> OS = CentOS-5.2
> perl = 5.8.8
>
> I get git from the yum repository at kernel.org.  Up until the most recent
> update I had no problems.  Now I am getting these dependency errors:
>
> Error: Missing Dependency: libcurl.so.4 is needed by package git
> Error: Missing Dependency: perl(:MODULE_COMPAT_5.10.0) is needed by
> package perl-Git
> Error: Missing Dependency: libc.so.6(GLIBC_2.7) is needed by package git
> Error: Missing Dependency: libexpat.so.1 is needed by package git
> Error: Missing Dependency: libcrypto.so.7 is needed by package git

As described in the announcement for 1.5.6.2, the machine at kernel.org I
cut x86_64 RPM on switched to FC9 early this month, and I updated my
personal bochs installation to FC9 to be consistent for producing i386
RPMs.

By the way, these RPMs are not in any way official.  I have been guessing
(without even bothering to confirm) that even for FC, distro people do not
use the RPM packages I have at kernel.org, but they build and distribute
their own to their users.  I could stop generating these RPMs, in other
words, but I've been doing this forever and they are still produced as
courtesy, even though I am not a FC user myself.

You could send a preconfigured CentOS 5.2 box to me and ask me to produce
yet another set of RPMs.  The release procedure already takes long enough
time out of my git day, however, and I doubt I can afford the time to do
so in practice, without reducing the time I spend on other git activities
such as reviewing and accepting changes from others or writing patches
myself.

People on other platforms like Debian, Macintosh, and Windows (Cygwin and
Msys) generate their own packages from the official tarballs and
distribute the result to help other users on their platforms.  Perhaps you
and other CentOS users can get together and do the same to help each
other?  That would be a great help to the community.

Thanks.
