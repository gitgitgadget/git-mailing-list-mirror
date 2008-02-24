From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use user.name and user.email in import-tars.perl
Date: Sun, 24 Feb 2008 10:06:38 -0800
Message-ID: <7v3arixm8h.fsf@gitster.siamese.dyndns.org>
References: <1203857838-29505-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Feb 24 19:07:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTLG8-0004XI-8V
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 19:07:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759544AbYBXSGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 13:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759535AbYBXSGy
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 13:06:54 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57465 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759521AbYBXSGx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 13:06:53 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EBB8F2DD9;
	Sun, 24 Feb 2008 13:06:51 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 269AA2DD6; Sun, 24 Feb 2008 13:06:47 -0500 (EST)
In-Reply-To: <1203857838-29505-1-git-send-email-mh@glandium.org> (Mike
 Hommey's message of "Sun, 24 Feb 2008 13:57:18 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74949>

Mike Hommey <mh@glandium.org> writes:

> Mimic what is done in git-import.sh and git-import.perl
>
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>
>  And that made me wonder if it wouldn't be worth, actually, to have
>  git config user.name and git config user.email return the "magic" values
>  gotten from guessing in ident.c when no value is in the config. That would
>  allow scripts, which have no other simple means to get the user name and
>  email, to have the same feature as builtins.

Or perhaps use "git var GIT_COMMITTER_IDENT"?
