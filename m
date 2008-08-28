From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Future suggestion's to assist with changes to git.
Date: Thu, 28 Aug 2008 16:59:17 -0700
Message-ID: <7vej48d73e.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.10.0808281646570.18129@suse104.zenez.com>
 <20080828233045.GE29609@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Boyd Lynn Gerber <gerberb@zenez.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 29 02:00:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYrPi-0002df-LR
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 02:00:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753798AbYH1X70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 19:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753498AbYH1X70
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 19:59:26 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43299 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418AbYH1X7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 19:59:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 183D36C64D;
	Thu, 28 Aug 2008 19:59:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A68416C648; Thu, 28 Aug 2008 19:59:19 -0400 (EDT)
In-Reply-To: <20080828233045.GE29609@coredump.intra.peff.net> (Jeff King's
 message of "Thu, 28 Aug 2008 19:30:45 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 56DFD236-755D-11DD-B049-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94220>

Jeff King <peff@peff.net> writes:

> On Thu, Aug 28, 2008 at 05:10:53PM -0600, Boyd Lynn Gerber wrote:
>
>> Maybe on item could be on the git web site news items could be created to  
>> announce backward compatibility changes.  I think most people do visit the 
>> main website to look for information.  Having these changes posted there  
>> or linked from the main page could be a positive method so something like  
>> this will not happen in the future.
>
> Do they? I haven't been to the git web site in quite a long time. Nor
> have I been to (for example) the vim web site. The two things I would
> personally notice are:
>
>   - a note during upgrade of my system's packages. And this is going to
>     be dependent on the packaging system used. 1.6.0 hasn't hit many
>     distributions yet, so maybe there is still time for this. Gerrit,
>     do you mind putting something into NEWS.Debian about the drop of
>     "git-*" so that people with apt-listchanges will see it?
>
>     For people building from source, we have the Release Notes, but
>     beyond that, I don't know where to put it (and I don't meant the web
>     site is a bad place -- the more places the better, but there is no
>     catch-all place).

That would help compared to doing nothing, but many people who complained
in the first thread (this is the third one, by the way) was k.org users
who used a machine somebody else installs the software for them.  Messages
during installation would not help those people.

>   - the command complaining that my use of it is deprecated. In
>     retrospect, we probably should have done this.

This is arguable.  People would have get annoying messages thrown into
their mailbox from their cron jobs, even before the switchover happened,
which effectively means that we move the whining period from now back to
the beginning of the deprecation period -- it won't reduce the amount of
actual whining.
