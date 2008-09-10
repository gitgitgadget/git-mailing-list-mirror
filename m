From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rename dynamic memory allocation functions to their "x"
 version
Date: Tue, 09 Sep 2008 21:11:42 -0700
Message-ID: <7vprnczlkx.fsf@gitster.siamese.dyndns.org>
References: <200809092157.10185.dotanba@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dotan Barak <dotanba@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 06:12:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdH4Z-0007xo-Kl
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 06:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbYIJELt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 00:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbYIJELt
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 00:11:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44479 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbYIJELs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 00:11:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6DD5C5AFE6;
	Wed, 10 Sep 2008 00:11:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D09785AFE3; Wed, 10 Sep 2008 00:11:44 -0400 (EDT)
In-Reply-To: <200809092157.10185.dotanba@gmail.com> (Dotan Barak's message of
 "Tue, 9 Sep 2008 21:57:10 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 95F83B80-7EEE-11DD-B985-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95478>

Dotan Barak <dotanba@gmail.com> writes:

> In places that the standard malloc/strdup is used without checking
> if the allocation was successful, I replaced it to xmalloc/xstrdup
> which check the memory allocation result.
>
> Signed-off-by: Dotan Barak <dotanba@gmail.com>

Looks good.  Will apply, but I'd retitle it (it is not "rename").

Thanks.
