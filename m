From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-svn woes
Date: Fri, 27 Feb 2009 21:54:29 -0800
Message-ID: <7vhc2fgl7u.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.2.00.0902271442270.5511@xanadu.home>
 <86d4c5e00902271253y50eaef01x8ca837d3a0ed7ef6@mail.gmail.com>
 <20090228033108.GB28606@dcvr.yhbt.net>
 <7vtz6fgrdi.fsf@gitster.siamese.dyndns.org>
 <20090228040949.GA13863@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Deskin Miller <deskinm@gmail.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Feb 28 06:56:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdIBZ-0003HA-NN
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 06:56:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbZB1Fyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 00:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752185AbZB1Fyk
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 00:54:40 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37599 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbZB1Fyk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 00:54:40 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4FA7A9DCA5;
	Sat, 28 Feb 2009 00:54:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 82DB19DCA4; Sat,
 28 Feb 2009 00:54:31 -0500 (EST)
In-Reply-To: <20090228040949.GA13863@dcvr.yhbt.net> (Eric Wong's message of
 "Fri, 27 Feb 2009 20:09:49 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 48224AD2-055C-11DE-9455-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111748>

Eric Wong <normalperson@yhbt.net> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Wong <normalperson@yhbt.net> writes:
>> 
>> > I've been poking around at this for a bit, I am pretty confused
>> > by this, too.  It's been a rough week, so I could be missing
>> > something obvious...
>> >
>> > Junio: since 1.6.2 might be out the door before we have time to resolve
>> > this, I'm leaning towards disabling the broken-symlink-workaround by
>> > default for the release. It seems far more people are negatively
>> > affected by the attempted fix around this rare problem than helped.
>> 
>> I agree that unfortunately is the message I am getting from the list ever
>> since the feature was introduced.
>
> OK, here goes:

Thanks; applied together with Ben Walton's "format_svn_date" fix.
