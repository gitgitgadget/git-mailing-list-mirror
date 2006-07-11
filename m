From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] Eliminate Scalar::Util usage from private-Error.pm
Date: 10 Jul 2006 20:38:13 -0700
Message-ID: <86y7v0lska.fsf@blue.stonehenge.com>
References: <20060710130046.GW29115@pasky.or.cz>
	<20060711005354.5911.62525.stgit@machine.or.cz>
	<7v4pxo7vk4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 11 05:38:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G094k-0008JW-Ry
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 05:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbWGKDiQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 23:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965102AbWGKDiP
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 23:38:15 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:56978 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S965030AbWGKDiP
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 23:38:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 851978D561;
	Mon, 10 Jul 2006 20:38:14 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 13803-02-26; Mon, 10 Jul 2006 20:38:14 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 06D768D562; Mon, 10 Jul 2006 20:38:14 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.13.8.4; tzolkin = 1 Kan; haab = 17 Tzec
In-Reply-To: <7v4pxo7vk4.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23683>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio> Petr Baudis <pasky@suse.cz> writes:
>> We used just the blessed() routine so steal it from Scalar/Util.pm. ;-)
>> (Unfortunately, Scalar::Util is not bundled with older Perl versions.)

Junio> Eh, but aren't we going to rip out the try{}catch{} stuff to
Junio> avoid extra closures?

Heh.  Yeah, didn't notice that.  I keep cutting down the trees,
but the forest remains. :)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
