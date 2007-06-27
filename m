From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: add support for --bool and --int while setting values
Date: Tue, 26 Jun 2007 19:18:27 -0700
Message-ID: <7vk5tqrvgs.fsf@assigned-by-dhcp.pobox.com>
References: <1182780024442-git-send-email-frank@lichtenheld.de>
	<467FCBEA.906B14@eudaptics.com>
	<20070625161401.GW19725@planck.djpig.de>
	<7vbqf2ta9f.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Wed Jun 27 04:18:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3N71-0001UW-6F
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 04:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754885AbXF0CSa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 22:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754760AbXF0CSa
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 22:18:30 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:53017 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754465AbXF0CS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 22:18:29 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070627021828.OGY3133.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Tue, 26 Jun 2007 22:18:28 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id GSJU1X0011kojtg0000000; Tue, 26 Jun 2007 22:18:28 -0400
In-Reply-To: <7vbqf2ta9f.fsf@assigned-by-dhcp.pobox.com> (Junio C. Hamano's
	message of "Tue, 26 Jun 2007 19:13:32 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51012>

Junio C Hamano <gitster@pobox.com> writes:

> Frank Lichtenheld <frank@lichtenheld.de> writes:
>
>> Something that I forgot to mention in the previous mail:
>> One real problem with the patch is that it expands the k,m,g suffixes
>> for integer values. It probably shouldn't do that.
>
> How about doing something like this, then?

Nah, that wouldn't work, as normalize_value's return value is
parsed and quoted.  Grumble....
