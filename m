From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: Re: Documentation: user-manual: "git commit -a" doesn't motivate
 .gitignore
Date: Wed, 6 Aug 2008 17:54:54 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0808061753420.22639@harper.uchicago.edu>
References: <Pine.GSO.4.62.0808061603340.18817@harper.uchicago.edu>
 <20080806214747.GY32057@genesis.frugalware.org>
 <Pine.GSO.4.62.0808061725450.21683@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Aug 07 00:56:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQrvT-0003PT-L4
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 00:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187AbYHFWzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 18:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755401AbYHFWzF
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 18:55:05 -0400
Received: from smtp01.uchicago.edu ([128.135.12.77]:36458 "EHLO
	smtp01.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755125AbYHFWzE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 18:55:04 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp01.uchicago.edu (8.13.8/8.13.8) with ESMTP id m76MstcH031826;
	Wed, 6 Aug 2008 17:54:55 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m76Mstx6022673;
	Wed, 6 Aug 2008 17:54:55 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <Pine.GSO.4.62.0808061725450.21683@harper.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91548>

On Wed, 6 Aug 2008, Jonathan Nieder wrote:

> Subject: git commit --addremove: add and update all files
> 
> This makes git commit -A a shortcut for git add -A && git commit.  It
> saves keystrokes, but more importantly it seems to be conceptually the
> right thing thing for users who have perfect .gitignore files and want
> to ignore the index.
> ---
>  builtin-commit.c |   18 +++++++++++++++---
>  1 files changed, 15 insertions(+), 3 deletions(-)

I was too hasty - the patch is insane in a number of ways.  But hopefully
the intent is clear :)

Jonathan
