From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] Eliminate Scalar::Util usage from private-Error.pm
Date: 10 Jul 2006 18:42:35 -0700
Message-ID: <863bd8nchg.fsf@blue.stonehenge.com>
References: <20060710130046.GW29115@pasky.or.cz>
	<20060711005354.5911.62525.stgit@machine.or.cz>
	<86bqrwncnq.fsf@blue.stonehenge.com>
	<867j2knckf.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 11 03:43:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G07Gq-0000V0-74
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 03:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbWGKBmh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 21:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965049AbWGKBmh
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 21:42:37 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:23411 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S965048AbWGKBmh
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 21:42:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 7A3DA8F33A;
	Mon, 10 Jul 2006 18:42:36 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 00661-01-63; Mon, 10 Jul 2006 18:42:36 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 0A65E8F343; Mon, 10 Jul 2006 18:42:36 -0700 (PDT)
To: Petr Baudis <pasky@suse.cz>
x-mayan-date: Long count = 12.19.13.8.4; tzolkin = 1 Kan; haab = 17 Tzec
In-Reply-To: <867j2knckf.fsf@blue.stonehenge.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23680>

>>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:

>>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:
Randal> sub blessed {
Randal> my $item = shift;
Randal> local $@; # don't kill an outer $@
Randal> ref $item and eval { $item->can('can') };
Randal> }

Randal> Oops, lose the local $@ line.  Just found out this is a broken
Randal> thing in current Perls.  The rest is good though.

And thirdly, ignore what I *just* said, and concentrate on what I *previously*
said, becaused my testing was off.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
