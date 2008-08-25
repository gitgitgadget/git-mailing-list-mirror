From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Has the git shell revert been done so master should work?
Date: Sun, 24 Aug 2008 22:40:33 -0700
Message-ID: <7vej4dire6.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.10.0808240659350.16122@xenau.zenez.com>
 <20080824173804.GA26626@coredump.intra.peff.net>
 <alpine.LNX.1.10.0808242332580.6062@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 07:41:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXUpp-0001p0-Dm
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 07:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbYHYFkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 01:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbYHYFkm
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 01:40:42 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52032 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbYHYFkl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 01:40:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EFC4B6E5EC;
	Mon, 25 Aug 2008 01:40:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5C3BE6E5EB; Mon, 25 Aug 2008 01:40:35 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.10.0808242332580.6062@xenau.zenez.com> (Boyd Lynn
 Gerber's message of "Sun, 24 Aug 2008 23:34:19 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 593379C2-7268-11DD-ABA5-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93599>

Boyd Lynn Gerber <gerberb@zenez.com> writes:

> On Sun, 24 Aug 2008, Jeff King wrote:
>> On Sun, Aug 24, 2008 at 07:02:38AM -0600, Boyd Lynn Gerber wrote:
>> > I just did a clean clone of git git and, I am still seeing failures on all 
>> > platforms I made work.  Has the git shell bug been reverted?  What should 
>> > I do to get this working again on the 12 platforms?  Do I need to submit a 
>> > patch that reverts the patch that caused all this?
>> 
>> It's in 'next' but has not yet graduated to 'master'. You can try
>> cherry-picking 4cfc24af into master.
>
> I have never used cherry-pick before.  I can not seem to get the right 
> incantation to get this into master to test it.  Could someone assist me 
> with how to get this into master for testing?

For your future reference, it would have been:

	git checkout master
	git cherry-pick 4cfc24af

But I've already pushed out the 'master' with the workarounds, so it
should not be necessary anymore.  Please check if tonight's 'master' works
for you.

Thanks.
