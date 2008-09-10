From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] t9400, t9401: use "git cvsserver" without dash
Date: Wed, 10 Sep 2008 15:37:50 -0700
Message-ID: <7v8wtzvd8h.fsf@gitster.siamese.dyndns.org>
References: <7vljy13sq0.fsf@gitster.siamese.dyndns.org>
 <20080910062529.6117@nanako3.lavabit.com>
 <20080910200318.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 00:39:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdYLH-00074l-ME
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 00:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755380AbYIJWh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 18:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754658AbYIJWh5
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 18:37:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57276 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943AbYIJWh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 18:37:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 781BC5D7AB;
	Wed, 10 Sep 2008 18:37:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E48795D7A8; Wed, 10 Sep 2008 18:37:52 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1C67D726-7F89-11DD-9887-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95564>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Subject: [PATCH] Install git-cvsserver in $(bindir)
>
> It is one of the server side programs and needs to be found on usual $PATH.
>
> Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
> ...
> -	$(INSTALL) git$X git-upload-pack$X git-receive-pack$X git-upload-archive$X git-shell$X '$(DESTDIR_SQ)$(bindir_SQ)'
> +	$(INSTALL) git$X git-upload-pack$X git-receive-pack$X git-upload-archive$X git-shell$X git-cvsserver$X '$(DESTDIR_SQ)$(bindir_SQ)'

Thanks.

Will queue but without $X at the end, as I do not think we want it even on
Windows because cvsserver is a script.
