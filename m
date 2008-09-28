From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] Document the textconv filter.
Date: Sun, 28 Sep 2008 13:07:21 +0200
Message-ID: <200809281307.21409.johannes.sixt@telecom.at>
References: <1222567618-22156-1-git-send-email-Matthieu.Moy@imag.fr> <1222567618-22156-4-git-send-email-Matthieu.Moy@imag.fr> <1222567618-22156-5-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Sep 28 13:08:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kju8i-0005X3-7M
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 13:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744AbYI1LHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 07:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752700AbYI1LHY
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 07:07:24 -0400
Received: from smtp2.srv.eunet.at ([193.154.160.116]:35672 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579AbYI1LHX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 07:07:23 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp2.srv.eunet.at (Postfix) with ESMTP id C7547BEE07;
	Sun, 28 Sep 2008 13:07:21 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 7FF52118E3;
	Sun, 28 Sep 2008 13:07:21 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1222567618-22156-5-git-send-email-Matthieu.Moy@imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96957>

On Sonntag, 28. September 2008, Matthieu Moy wrote:
> +Converting files to text before a diff
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The attribute `textconv` affects 'git diff' in a way similar to the
> +`diff` attribute, but with `textconv`, the user provides only a way to
> +convert the file into text, and git takes care of doing the diff as
> +usual (i.e. other options of 'git diff' such as '--color' remain
> +available).
> +
> +The value of `textconv` must be a string, which is the textconv
> +driver.

Wouldn't it be much more useful to have git parse stdout of the custom diff 
tool in order to colorize it? Of course, this would mean that external diff 
tools are more complicated and their stdout has to conform mostly to the git 
diff syntax. But:

> +To tell git to use the `exif` filter for jpeg images, use:
> +
> +----------------------------------------------------------------
> +*.jpg   textconv=exif
> +----------------------------------------------------------------

In this very example it would be possible that the external diff driver shows 
the differences in the image in a window and also produces EXIF information 
on stdout.

-- Hannes
