From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/3] Export thread-safe version of
 'has_symlink_leading_path()'
Date: Sun, 12 Jul 2009 14:33:36 -0700
Message-ID: <7vfxd1lh73.fsf@alter.siamese.dyndns.org>
References: <20090707000500.GA5594@dpotapov.dyndns.org>
 <alpine.LFD.2.01.0907081902371.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081933530.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081936470.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081940220.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081942380.3352@localhost.localdomain>
 <7vskh646bw.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0907090832200.3352@localhost.localdomain>
 <7vws6h3ji4.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0907091011280.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907091013540.3352@localhost.localdomain>
 <7vab3d3dpc.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0907091153130.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907091344340.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907091344530.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907091347080.3352@localhost.localdomain>
 <86r5wmvk17.fsf@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Sun Jul 12 23:33:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQ6gB-0000o7-4g
	for gcvg-git-2@gmane.org; Sun, 12 Jul 2009 23:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbZGLVdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2009 17:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbZGLVdn
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jul 2009 17:33:43 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56235 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbZGLVdn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2009 17:33:43 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D472327EC2;
	Sun, 12 Jul 2009 17:33:42 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0C02327EBD; Sun,
 12 Jul 2009 17:33:37 -0400 (EDT)
In-Reply-To: <86r5wmvk17.fsf@broadpark.no> (Kjetil Barvik's message of "Sun\,
 12 Jul 2009 02\:09\:56 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AC0E5B06-6F2B-11DE-9336-424D1A496417-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123161>

Kjetil Barvik <barvik@broadpark.no> writes:

>   I have looked at and tested (the version from the origin/pu branch, so
>   it contains the memset() line squashed in) patch 5/3, 6/3 and 7/3, and
>   all 3 patches looks correct, so you can add
>
>      Reviewed-and-tested-by: Kjetil Barvik
>
>   if you want to.

Thanks.

>   But, I guess it is me which is a litle late to comment things, since I
>   already see that all 3 patches is in the pu, next and master branches
>   already, less than 3 days after beeing posted to the malinglist.
>
>   But, would'nt it be a good thing to let all patches at least be in the
>   pu branch for minimum x days before entering next and master?  Or: let
>   it go minimum x days after beeing posted to the list before entering
>   the next and master branch?  x = 4?

That number x depends on the quality of the patches and to a great extent
how well I know the area of the code affected by the patch.
