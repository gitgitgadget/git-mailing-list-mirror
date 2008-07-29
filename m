From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make it clear that push can take multiple refspecs
Date: Tue, 29 Jul 2008 13:54:35 -0700
Message-ID: <7vbq0gcsxg.fsf@gitster.siamese.dyndns.org>
References: <1217362159-25440-1-git-send-email-ams@toroid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Abhijit Menon-Sen <ams@toroid.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 22:55:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNwET-0005iH-LZ
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 22:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951AbYG2Uyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 16:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755375AbYG2Uyp
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 16:54:45 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57247 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753074AbYG2Uyo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 16:54:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1379B42D85;
	Tue, 29 Jul 2008 16:54:41 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3165442D84; Tue, 29 Jul 2008 16:54:36 -0400 (EDT)
In-Reply-To: <1217362159-25440-1-git-send-email-ams@toroid.org> (Abhijit
 Menon-Sen's message of "Wed, 30 Jul 2008 01:39:19 +0530")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 907C9FFC-5DB0-11DD-BCFD-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90682>

Abhijit Menon-Sen <ams@toroid.org> writes:

> Signed-off-by: Abhijit Menon-Sen <ams@toroid.org>
> ---
>  Documentation/git-push.txt |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 94d07ab..b8c55dd 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -10,7 +10,8 @@ SYNOPSIS
>  --------
>  [verse]
>  'git push' [--all] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>]
> -           [--repo=all] [-f | --force] [-v | --verbose] [<repository> <refspec>...]

Doesn't this already say you can have zero or more refspecs?
