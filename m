From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Builtin "git remote"
Date: Thu, 28 Feb 2008 17:56:25 -0800
Message-ID: <7vwsoofrue.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0802290144130.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 29 02:57:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUuV8-00049g-DY
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 02:57:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757190AbYB2B4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 20:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753722AbYB2B4i
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 20:56:38 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58092 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412AbYB2B4g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 20:56:36 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 02B281A56;
	Thu, 28 Feb 2008 20:56:35 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 365621A55; Thu, 28 Feb 2008 20:56:30 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0802290144130.22527@racer.site> (Johannes
 Schindelin's message of "Fri, 29 Feb 2008 01:44:33 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75494>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> It also demonstrates that format-patch --cover-letter should default to -M
> for the diffstat (search for "git-remote.perl"...).

It probably should inherit the settings for the primary part.
You did generate the series with -M, especially [PATCH 4/5],
didn't you?

> Johannes Schindelin (5):
>       path-list: add functions to work with unsorted lists
>       parseopt: add flag to stop on first non option
>       Test "git remote show" and "git remote prune"
>       Make git-remote a builtin
>       builtin-remote: prune remotes correctly that were added with --mirror

Also I wish the default indentation were not that deep, and also
line-wrapped at around 72-76 columns.
