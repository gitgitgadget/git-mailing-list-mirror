From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/2] add--interactive: rename [r]evert command to
	[r]eset
Date: Mon, 6 Oct 2008 07:55:09 -0700
Message-ID: <20081006145509.GD8203@spearce.org>
References: <20081005152654.GA13618@gmx.de> <20081005164124.GA31903@coredump.intra.peff.net> <20081005214644.GB32727@gmx.de> <20081005221150.GA22007@coredump.intra.peff.net> <b41e1729a8817f0d3cba2be1edc37513a72901dd.1223304141.git.marco-oweber@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Marc Weber <marco-oweber@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 06 17:00:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmrVY-00022o-Jq
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 16:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673AbYJFOzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 10:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752412AbYJFOzL
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 10:55:11 -0400
Received: from george.spearce.org ([209.20.77.23]:50079 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145AbYJFOzK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 10:55:10 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id CFF4C3835F; Mon,  6 Oct 2008 14:55:09 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <b41e1729a8817f0d3cba2be1edc37513a72901dd.1223304141.git.marco-oweber@gmx.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97591>

Marc Weber <marco-oweber@gmx.de> wrote:
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index da768ee..5352d16 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -498,8 +498,8 @@ sub update_cmd {
>         print "\n";
>  }
>  
> -sub revert_cmd {
> -       my @update = list_and_choose({ PROMPT => 'Revert',
> +sub reset_cmd {
> +       my @update = list_and_choose({ PROMPT => 'Reset',
>                                        HEADER => $status_head, },
>                                      list_modified());
>         if (@update) {

This patch is mangled.  The context line immediately above is
indented with tabs in the source file, but is 8 spaces in the patch.
The patch doesn't apply.

-- 
Shawn.
