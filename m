From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH 2/2] Teach rev-list an option to read revs from the standard
 input.
Date: Thu, 07 Sep 2006 09:11:34 +0100
Message-ID: <44FFD436.4020407@shadowen.org>
References: <7v64g1a9f7.fsf@assigned-by-dhcp.cox.net>	<44FEBFD6.10709@shadowen.org> <7vhczk5wup.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 10:12:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLEzW-0005VL-CX
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 10:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbWIGIMB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 04:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWIGIMB
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 04:12:01 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:18436 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1750969AbWIGIMA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 04:12:00 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1GLEz0-0007x5-Sg; Thu, 07 Sep 2006 09:11:34 +0100
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhczk5wup.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26613>

Junio C Hamano wrote:
> Andy Whitcroft <apw@shadowen.org> writes:
> 
>> Ok, I've tested this with an updated version of my patch to make
>> send-pack use this (which I'll send out following this message) and it
>> seems to work pretty well.
> 
> Eh, I have your earlier one placed on "pu" already.  I do not
> mind replacing it with the new one but (1) have you checked what
> is in "pu"?  (2) how different is this new one compared to it?

There was white space breakage in the patch which I noticed late in the
game, and a problem with the printing lacking newlines.  Your conversion
to direct writes on the fd fixes the bug part.

What you have on 'pu' looks good to me.

/me wasn't aware of the meaning of the pu branch :)

-apw
