From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 01/14] Add data structures and basic functions for
 commit trailers
Date: Sun, 09 Feb 2014 14:51:03 +0100 (CET)
Message-ID: <20140209.145103.574296288999775548.chriscool@tuxfamily.org>
References: <20140206194123.325.99451.chriscool@tuxfamily.org>
	<20140206202004.325.80557.chriscool@tuxfamily.org>
	<xmqqvbwrx0sh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, johan@herland.net, josh@joshtriplett.org,
	tr@thomasrast.ch, mhagger@alum.mit.edu, sunshine@sunshineco.com,
	dan.carpenter@oracle.com, greg@kroah.com, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Feb 09 14:51:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCUmu-0004ij-PZ
	for gcvg-git-2@plane.gmane.org; Sun, 09 Feb 2014 14:51:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbaBINvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Feb 2014 08:51:07 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:59863 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751424AbaBINvG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Feb 2014 08:51:06 -0500
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id EC8F06D;
	Sun,  9 Feb 2014 14:51:03 +0100 (CET)
In-Reply-To: <xmqqvbwrx0sh.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241875>

From: Junio C Hamano <gitster@pobox.com>
>
> Christian Couder <chriscool@tuxfamily.org> writes:
> 
>> +	enum action_if_exist if_exist;
>> +	enum action_if_missing if_missing;
> 
> Probably "if_exists" is more gramatically correct.
> 
> 	if (x->if_exists) {
>         	... do this ...
> 	}
> 
> would read well, but not "x->if_exist".                

Ok, I will use "if_exists" instead of "if_exist" and also:

enum action_if_exists { EXISTS_ADD_IF_DIFFERENT, EXISTS_ADD_IF_DIFFERENT_NEIGHBOR,
			EXISTS_ADD, EXISTS_OVERWRITE, EXISTS_DO_NOTHING };

instead of:

enum action_if_exist { EXIST_ADD_IF_DIFFERENT, EXIST_ADD_IF_DIFFERENT_NEIGHBOR,
			EXIST_ADD, EXIST_OVERWRITE, EXIST_DO_NOTHING };

to be consistent.

Thanks,
Christian.
