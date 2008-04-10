From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] git-send-email.perl: Handle shell metacharacters in
 $EDITOR properly
Date: Wed, 09 Apr 2008 20:39:08 -0700
Message-ID: <7vve2q1iqr.fsf@gitster.siamese.dyndns.org>
References: <cover.1207702130.git.bdonlan@fushizen.net>
 <1207704604-30393-1-git-send-email-bdonlan@fushizen.net>
 <1207704604-30393-2-git-send-email-bdonlan@fushizen.net>
 <1207704604-30393-3-git-send-email-bdonlan@fushizen.net>
 <47FC62B6.9020304@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bryan Donlan <bdonlan@fushizen.net>, git@vger.kernel.org,
	Adam Roben <aroben@apple.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Apr 10 05:40:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjndp-0000HE-Ix
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 05:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754713AbYDJDjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 23:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755031AbYDJDjS
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 23:39:18 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40837 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755981AbYDJDjR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 23:39:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9B4B73CD3;
	Wed,  9 Apr 2008 23:39:15 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E5CBA3CD2; Wed,  9 Apr 2008 23:39:10 -0400 (EDT)
In-Reply-To: <47FC62B6.9020304@viscovery.net> (Johannes Sixt's message of
 "Wed, 09 Apr 2008 08:31:18 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79163>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Bryan Donlan schrieb:
>> Also, update t/t9001-send-email.sh to test for this bug.
>> 
>> Signed-off-by: Bryan Donlan <bdonlan@fushizen.net>
>
> Your defintion of "properly"? I didn't immediately see what is wrong with
> the status quo and, hence, why your fix would solve a problem.

I agree the description of this series is a bit too sketchy.  I suspect
even Bryan would not remember what the broken behaviour was and what's the
new accepted behaviour is three months from now.
