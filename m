From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Tests in Cygwin
Date: Thu, 07 May 2009 23:41:20 -0700
Message-ID: <7v4ovwaygf.fsf@alter.siamese.dyndns.org>
References: <83prfbhasp.fsf@kalahari.s2.org>
	<4A01E64C.7050703@SierraAtlantic.com>
	<7vvdoet13g.fsf@alter.siamese.dyndns.org>
	<4A028A0A.5070003@viscovery.net> <4A030277.2000708@SierraAtlantic.com>
	<20090508020037.GA1264@coredump.intra.peff.net>
	<4A03CAFE.4060503@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Don Slutz <Don.Slutz@SierraAtlantic.com>,
	Junio C Hamano <gitster@pobox.com>,
	Hannu Koivisto <azure@iki.fi>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri May 08 08:42:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2JmR-00067I-Sc
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 08:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760713AbZEHGlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 02:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755083AbZEHGlV
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 02:41:21 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:53040 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760008AbZEHGlU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 02:41:20 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090508064120.ZRYG20430.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Fri, 8 May 2009 02:41:20 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id ouhL1b0034aMwMQ04uhLdz; Fri, 08 May 2009 02:41:20 -0400
X-Authority-Analysis: v=1.0 c=1 a=fv-XvKvnAAAA:8 a=tTb5EiVFWSbVeJrGOTwA:9
 a=XWEkZ4NGiTbgvWaZINln3c-P7gMA:4 a=l9rlz7MJbUIA:10
X-CM-Score: 0.00
In-Reply-To: <4A03CAFE.4060503@viscovery.net> (Johannes Sixt's message of "Fri\, 08 May 2009 08\:02\:38 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118568>

Johannes Sixt <j.sixt@viscovery.net> writes:

>>   +for prerequisite in $(echo "$1" | tr , ' ')
>
> So, you dislike the space separator, but you also dislike the IFS games
> that save a few new processes? ;) (Think of Windows, where fork is expensive).

You can play IFS=, game, then ;-)

I have to admit that it feels so 80'ish, back when our UNIX machines were
so slow that we tried to shave every fork+exec from our shell scripts by
using built-ins when possible, though.
