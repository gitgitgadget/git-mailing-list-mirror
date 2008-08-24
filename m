From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-submodule - Use "get_default_remote" from
 git-parse-remote
Date: Sun, 24 Aug 2008 12:07:47 -0700
Message-ID: <7vljymmdto.fsf@gitster.siamese.dyndns.org>
References: <e21617f50ffaae98ab73fa364e40440397bcbe33.1219598198.git.davvid@gmail.com>
 <1219603570-516-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: davvid@gmail.com, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 21:09:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXKxP-00060d-Ug
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 21:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752726AbYHXTH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 15:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752709AbYHXTH4
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 15:07:56 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47216 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519AbYHXTH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 15:07:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5B5166DBB8;
	Sun, 24 Aug 2008 15:07:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DC2926DBB7; Sun, 24 Aug 2008 15:07:48 -0400 (EDT)
In-Reply-To: <1219603570-516-1-git-send-email-mlevedahl@gmail.com> (Mark
 Levedahl's message of "Sun, 24 Aug 2008 14:46:10 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F356E970-720F-11DD-998B-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93550>

Mark Levedahl <mlevedahl@gmail.com> writes:

> Resolve_relative_url was using its own code for this function, but
> this is duplication with the best result that this continues to work.
> Replace with the common function provided by git-parse-remote.
>
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---
>
> I think it makes more sense to use the facility provided elsewhere rather
> than duplicate.

Ah, that's true.  Will apply, thanks.
