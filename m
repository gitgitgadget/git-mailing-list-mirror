From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] MinGW: fix diff --no-index /dev/null ...
Date: Sat, 07 Mar 2009 13:40:44 -0800
Message-ID: <7vhc25m2oz.fsf@gitster.siamese.dyndns.org>
References: <cover.1236441065u.git.johannes.schindelin@gmx.de>
 <dba002b9e521c639847650fbaeb8b87b66b9562e.1236441065u.git.johannes.schindelin@gmx.de> <7v8wnhnl6t.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903072133270.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 07 22:42:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg4Hq-0007F7-0T
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 22:42:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755911AbZCGVk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 16:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755595AbZCGVk4
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 16:40:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45607 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753199AbZCGVkz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 16:40:55 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 239D84EB9;
	Sat,  7 Mar 2009 16:40:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6A9E64EB8; Sat, 
 7 Mar 2009 16:40:46 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0903072133270.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Sat, 7 Mar 2009 21:47:18 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A1767CF2-0B60-11DE-B5A3-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112588>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Unlike other places where a string is compared to /dev/null, in this case 
> do not parse a diff, but rather command line parameters that have 
> possibly been transformed from /dev/null to nul, so that the file can be 
> opened.
> -- snap --
>
> If you like it, may I ask you to amend the message?
>
>> Should this go to 'maint'?
>
> Technically, yes, as it is a fix.
>
> However, it might not be necessary, as literally all Windows work on Git 
> happens in git/mingw.git, git/mingw/j6t.git and git/mingw/4msysgit.git.

Yeah, I should have been clearer.  Unless msysgit will have a maintenance
track for 1.6.1.X, there is no point.

Thanks for reading my mind and a clarified message I can use for amending.
