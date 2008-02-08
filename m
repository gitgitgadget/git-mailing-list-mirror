From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-commit: remove .git/SQUASH_MSG upon successful commit
Date: Fri, 08 Feb 2008 02:03:12 -0800
Message-ID: <7vsl03kbof.fsf@gitster.siamese.dyndns.org>
References: <20080208095358.25666.qmail@b4daf7aef4dba9.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Fri Feb 08 11:04:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNQ5U-0004cI-8i
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 11:04:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbYBHKD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 05:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbYBHKD3
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 05:03:29 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42326 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932352AbYBHKD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 05:03:27 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DE4D4355C;
	Fri,  8 Feb 2008 05:03:25 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 604B23559;
	Fri,  8 Feb 2008 05:03:21 -0500 (EST)
In-Reply-To: <20080208095358.25666.qmail@b4daf7aef4dba9.315fe32.mid.smarden.org>
	(Gerrit Pape's message of "Fri, 8 Feb 2008 09:53:58 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73064>

Gerrit Pape <pape@smarden.org> writes:

> After doing a merge --squash, and commit afterwards, the commit message
> template SQUASH_MSG in the git directory is not removed, which means that
> the content of SQUASH_MSG is used as default commit message for all
> subsequent commits.  So have git commit remove the file SQUASH_MSG from
> the git directory upon a successful commit.

It appears that there are a few more differences from what
contrib/examples/git-commit.sh used to do.  For example, the
COMMIT_EDITMSG file used to be removed at around the same place
as the SQUASH_MSG file.
