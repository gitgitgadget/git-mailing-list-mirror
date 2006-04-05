From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: [PATCH] git-commit: document --append (amend really!)
Date: Wed, 5 Apr 2006 21:46:07 +0200
Message-ID: <20060405194607.GB20854@fiberbit.xs4all.nl>
References: <20060405191608.GA20572@fiberbit.xs4all.nl> <7vfykr24wi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Marco Roeland <marco.roeland@xs4all.nl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 05 21:46:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRDxS-0005y9-H8
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 21:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWDETqN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 15:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbWDETqN
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 15:46:13 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:27269 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S932075AbWDETqM
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 5 Apr 2006 15:46:12 -0400
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.54)
	id 1FRDx9-0005SL-TB; Wed, 05 Apr 2006 21:46:07 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfykr24wi.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18450>

On Wednesday April 5th 2006 Junio C Hamano wrote:

> Thanks for resurrecting this.
> 
> I suspect that some formatting tweak is needed; I recall
> asciidoc needs some special formatting when multi- paragraph
> description is involved in the list.

Here with asciidoc 7.1.2 (Debian 'sid') it looks good in the generated
man page. But I'll investigate if nobody beats me to it. Perhaps we
should develop a "sparse" like module for asciidoc.

> Of course, munging the patch title with s/append/amend/ would
> not hurt ;-).

Oops. Well I suppose I could use "git commit --amend" and then run "git
format-patch" again I suppose. ;-)
-- 
Marco Roeland
