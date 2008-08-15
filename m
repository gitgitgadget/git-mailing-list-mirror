From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix t3700 on filesystems which do not support question
 marks in names
Date: Fri, 15 Aug 2008 00:17:24 -0700
Message-ID: <7vproabvcr.fsf@gitster.siamese.dyndns.org>
References: <81b0412b0808150011r534d8453yab2a5c42b255657f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Kevin Ballard" <kevin@sb.org>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 09:19:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTta6-00044B-Kw
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 09:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945AbYHOHRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 03:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbYHOHRk
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 03:17:40 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59591 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891AbYHOHRj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 03:17:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 97EC75FAB5;
	Fri, 15 Aug 2008 03:17:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D6E465FAB2; Fri, 15 Aug 2008 03:17:33 -0400 (EDT)
In-Reply-To: <81b0412b0808150011r534d8453yab2a5c42b255657f@mail.gmail.com>
 (Alex Riesen's message of "Fri, 15 Aug 2008 09:11:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3DD82720-6A9A-11DD-95AD-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92461>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> And the prominent example of the deficiency are, as usual, the filesystems
> of Microsoft house.
>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
>  t/t3700-add.sh |   19 ++++++++++++-------
>  1 files changed, 12 insertions(+), 7 deletions(-)
>
> From 2e5bbfea6a3ee6ff8cf82599cec0e49de94d0631 Mon Sep 17 00:00:00 2001
> From: Alex Riesen <raa.lkml@gmail.com>
> Date: Fri, 15 Aug 2008 09:00:54 +0200
> Subject: [PATCH] Fix t3700 on filesystems which do not support question marks in names
>
> And the prominent example of the deficiency are, as usual, the filesystems
> of Microsoft house.

Can other glob specials such as '*' or '[' be used instead of skipping the
test?
