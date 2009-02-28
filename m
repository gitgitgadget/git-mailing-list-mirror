From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-svn woes
Date: Fri, 27 Feb 2009 19:41:29 -0800
Message-ID: <7vtz6fgrdi.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.2.00.0902271442270.5511@xanadu.home>
 <86d4c5e00902271253y50eaef01x8ca837d3a0ed7ef6@mail.gmail.com>
 <20090228033108.GB28606@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Deskin Miller <deskinm@gmail.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Feb 28 04:43:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdG6T-0005A9-TV
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 04:43:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151AbZB1Dlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 22:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753172AbZB1Dlj
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 22:41:39 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45058 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912AbZB1Dli (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 22:41:38 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 63CA51E60;
	Fri, 27 Feb 2009 22:41:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A399D1E5B; Fri,
 27 Feb 2009 22:41:30 -0500 (EST)
In-Reply-To: <20090228033108.GB28606@dcvr.yhbt.net> (Eric Wong's message of
 "Fri, 27 Feb 2009 19:31:08 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B28C6D8E-0549-11DE-8E98-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111745>

Eric Wong <normalperson@yhbt.net> writes:

> I've been poking around at this for a bit, I am pretty confused
> by this, too.  It's been a rough week, so I could be missing
> something obvious...
>
> Junio: since 1.6.2 might be out the door before we have time to resolve
> this, I'm leaning towards disabling the broken-symlink-workaround by
> default for the release. It seems far more people are negatively
> affected by the attempted fix around this rare problem than helped.

I agree that unfortunately is the message I am getting from the list ever
since the feature was introduced.
