From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-archive: ignore prefix when checking file attribute
Date: Thu, 10 Apr 2008 03:56:18 -0700
Message-ID: <7vskxuvuzx.fsf@gitster.siamese.dyndns.org>
References: <a1b6cb1b0804081435w24074d1aq177e8c1a5e1af0f8@mail.gmail.com>
 <47FD31C3.8070001@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ulrik Sverdrup <ulrik.sverdrup@gmail.com>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Apr 10 12:57:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjuSq-0002er-3C
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 12:57:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754864AbYDJK40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 06:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754804AbYDJK40
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 06:56:26 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44833 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754835AbYDJK4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 06:56:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 37DA2216A;
	Thu, 10 Apr 2008 06:56:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 99A162169; Thu, 10 Apr 2008 06:56:20 -0400 (EDT)
In-Reply-To: <47FD31C3.8070001@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of "Wed, 09 Apr 2008 23:14:43 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79204>

Thanks.  Will apply as a fix.

In the longer term, we probably should teach attributes.c to optionally
read from a tree (introduce git_attribute_set_tree() call upfront, or
something like that, but I haven't thought through the details yet), so
that archive can ignore what happens to be checked out.
