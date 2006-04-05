From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: How should I handle binary file with GIT
Date: 05 Apr 2006 11:51:39 -0700
Message-ID: <86ek0bsvno.fsf@blue.stonehenge.com>
References: <20060405073022.13054.qmail@web25806.mail.ukl.yahoo.com>
	<7v3bgs4exz.fsf@assigned-by-dhcp.cox.net> <e10mn9$cjs$1@sea.gmane.org>
	<Pine.LNX.4.64.0604051131010.2550@localhost.localdomain>
	<86wte4rq3d.fsf@blue.stonehenge.com>
	<7vslor27n4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 05 20:51:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRD6a-00037L-0l
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 20:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWDESvp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 14:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWDESvp
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 14:51:45 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:36183 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751335AbWDESvo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Apr 2006 14:51:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 0D7B48F3C2;
	Wed,  5 Apr 2006 11:51:40 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 07457-02-29; Wed,  5 Apr 2006 11:51:39 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 8CE748F3D0; Wed,  5 Apr 2006 11:51:39 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.13.3.8; tzolkin = 9 Lamat; haab = 1 Pop
In-Reply-To: <7vslor27n4.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18445>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio> If we wanted to use the patch+diff (i.e. "format-patch,
Junio> send-email, and then am" workflow) to transfer new version of
Junio> binary files to a recipient, which I think is useful in some
Junio> projects, the sanest way to handle this is probably to add
Junio> Nico's delta, going from preimage to postimage, encoded for
Junio> safer transport, to our diff output.

This is what I was looking for, and thanks for confirming that at least within
a local respository, everything already works.  Yeay.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
