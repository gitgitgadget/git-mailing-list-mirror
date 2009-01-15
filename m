From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/3] bash-completion: Added comments to remind about
	required arguments
Date: Thu, 15 Jan 2009 07:35:43 -0800
Message-ID: <20090115153543.GF10179@spearce.org>
References: <1231963342-24461-1-git-send-email-ted@tedpavlic.com> <1231963342-24461-2-git-send-email-ted@tedpavlic.com> <1231963342-24461-3-git-send-email-ted@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: ted@tedpavlic.com
X-From: git-owner@vger.kernel.org Thu Jan 15 16:37:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNUI5-0006bq-J8
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 16:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760428AbZAOPfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 10:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760363AbZAOPfo
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 10:35:44 -0500
Received: from george.spearce.org ([209.20.77.23]:48034 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760311AbZAOPfo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 10:35:44 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 5F0CF38210; Thu, 15 Jan 2009 15:35:43 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1231963342-24461-3-git-send-email-ted@tedpavlic.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105837>

ted@tedpavlic.com wrote:
> From: Ted Pavlic <ted@tedpavlic.com>
> 
>   Adds a few simple comments above commands that take arguments. These
>   comments are meant to remind developers of potential problems that can
>   occur when the script is sourced on systems with "set -u." Any
>   function which "requires" arguments really ought to be called with
>   explicit arguments given.
> 
>   Also adds a #!bash to the top of bash completions so that editing
>   software can always identify that the file is of sh type.
> 
> Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
> Acked-by: Shawn O. Pearce <spearce@spearce.org>

Yup, this and also 2/3 look fine.  But again, the message, it
shouldn't be indented.

> ---
>  contrib/completion/git-completion.bash |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)

-- 
Shawn.
