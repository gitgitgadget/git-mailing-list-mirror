From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/3] bash-completion: Support running when set -u is
	enabled
Date: Thu, 15 Jan 2009 07:34:02 -0800
Message-ID: <20090115153402.GE10179@spearce.org>
References: <1231963342-24461-1-git-send-email-ted@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: ted@tedpavlic.com
X-From: git-owner@vger.kernel.org Thu Jan 15 16:35:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNUFj-0005el-N2
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 16:35:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080AbZAOPeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 10:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753820AbZAOPeE
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 10:34:04 -0500
Received: from george.spearce.org ([209.20.77.23]:48027 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753906AbZAOPeD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 10:34:03 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id E94B738210; Thu, 15 Jan 2009 15:34:02 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1231963342-24461-1-git-send-email-ted@tedpavlic.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105836>

ted@tedpavlic.com wrote:
> From: Ted Pavlic <ted@tedpavlic.com>
> 
>   Under "set -u" semantics, it is an error to access undefined
>   variables. Some user environments may enable this setting in the
>   interactive shell.
> 
>   In any context where the completion functions access an undefined
>   variable, accessing a default empty string (aka "${1-}" instead of
>   "$1") is a reasonable way to code the function, as it silences
>   the undefined variable error while still supplying an empty string.
> 
>   In this patch, functions that should always take an argument still use
>   $1. Functions that have optional arguments use ${1-}.
> 
> Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
> Acked-by: Shawn O. Pearce <spearce@spearce.org>

Yup.  This patch isn't as bad as everyone made it out to be.
I think we should go ahead and include it.

But usually we don't indent the commit message like you did
above; instead the message should be aligned on the left margin at
column 0.  git log will indent the message during display, hence
any identation you add in the patch email just makes the message
that much harder to read from git log.

> ---
>  contrib/completion/git-completion.bash |   18 +++++++++---------
>  1 files changed, 9 insertions(+), 9 deletions(-)

-- 
Shawn.
