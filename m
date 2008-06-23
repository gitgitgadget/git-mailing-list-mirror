From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2/RFC] git.el: Commands for committing patches
Date: Mon, 23 Jun 2008 14:27:56 -0700
Message-ID: <7vlk0vhmeb.fsf@gitster.siamese.dyndns.org>
References: <m2prq9ujpa.fsf@nschum.de> <485F0388.4080907@thewritingpot.com>
 <m2abhcvcil.fsf@nschum.de> <m263s0vbri.fsf_-_@nschum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alexandre Julliard <julliard@winehq.org>
To: Nikolaj Schumacher <n_schumacher@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 23 23:30:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAtax-0003PH-Hj
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 23:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbYFWV2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 17:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbYFWV2G
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 17:28:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59663 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbYFWV2E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 17:28:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F0D6C59AE;
	Mon, 23 Jun 2008 17:28:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5AD9E59AD; Mon, 23 Jun 2008 17:27:58 -0400 (EDT)
In-Reply-To: <m263s0vbri.fsf_-_@nschum.de> (Nikolaj Schumacher's message of
 "Mon, 23 Jun 2008 09:41:37 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 42D7EA2E-416B-11DD-8223-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85935>

Nikolaj Schumacher <n_schumacher@web.de> writes:

> From 609f6fca6c70919036d41e1e4034b6e4de2e7ea2 Mon Sep 17 00:00:00 2001
> From: Nikolaj Schumacher <git@nschum.de>
> Date: Mon, 23 Jun 2008 09:34:14 +0200
> Subject: [PATCH] git.el: Added command for committing patches.
>
> This adds commands for committing patches from files, buffers and email
> buffers.
>
> In order to minimize code duplication, git-start-log-edit and
> git-prepare-log-buffer have been extracted from git-commit-file.
>
> Signed-off-by: Nikolaj Schumacher <git@nschum.de>
> ---
>  contrib/emacs/git.el |  200 +++++++++++++++++++++++++++++++++++++++++++------
>  1 files changed, 175 insertions(+), 25 deletions(-)

I do not use things in contrib/emacs/git.el myself, but this looks like a
lot of code to do what "M-| git am <Enter>" already does...
