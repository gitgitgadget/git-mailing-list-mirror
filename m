From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/SubmittingPatches: Instruct how to use [PATCH] Subject header
Date: Sun, 03 Feb 2008 16:55:21 -0800
Message-ID: <7v7ihlpmkm.fsf@gitster.siamese.dyndns.org>
References: <r6ft1sd1.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Mon Feb 04 01:56:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLpdC-0002sG-6F
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 01:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754542AbYBDAzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 19:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754682AbYBDAzq
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 19:55:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42144 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754215AbYBDAzp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 19:55:45 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id ECBEA13BB;
	Sun,  3 Feb 2008 19:55:42 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6280713BA;
	Sun,  3 Feb 2008 19:55:40 -0500 (EST)
In-Reply-To: <r6ft1sd1.fsf@blue.sea.net> (Jari Aalto's message of "Mon, 04 Feb
	2008 02:24:10 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72439>

Jari Aalto <jari.aalto@cante.net> writes:

> Suggest putting additional message inside brackets, like [PATCH v2]
> for reworked content.
>
> Signed-off-by: Jari Aalto <jari.aalto AT cante.net>
> ---
>  Idea by Jakub Narebski
>
>  Documentation/SubmittingPatches |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index de08d09..69ecbd3 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -37,6 +37,9 @@ Checklist (and a short version for the impatient):
>  	  maintainer (gitster@pobox.com). If you use
>  	  git-send-email(1), please test it first by sending
>  	  email to yourself.
> +        - If you rework the patch, announce the message
> +          in brackets. For example "[PATCH/RFC]", "[PATCH (resend)]",
> +          "[PATCH v2]" etc.
>  

This adds something to the "short version" that the full version
does not even talk about?

I do not think this needs to be in the short version, but an
update to the full version would indeed be a good idea.

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index de08d09..0661293 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -112,7 +112,12 @@ lose tabs that way if you are not careful.
 
 It is a common convention to prefix your subject line with
 [PATCH].  This lets people easily distinguish patches from other
-e-mail discussions.
+e-mail discussions.  Use of additional markers after PATCH and
+the closing bracket to mark the nature of the patch is also
+encouraged.  E.g. [PATCH/RFC] is often used when the patch is
+not ready to be applied but it is for discussion, [PATCH v2],
+[PATCH v3] etc. are often seen when you are sending an update to
+what you have previously sent.
 
 "git format-patch" command follows the best current practice to
 format the body of an e-mail message.  At the beginning of the
