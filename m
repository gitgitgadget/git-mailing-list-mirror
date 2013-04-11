From: Aaron Schrab <aaron@schrab.com>
Subject: Re: [PATCH v2 4/5] check-ignore: allow incremental streaming of
 queries via --stdin
Date: Thu, 11 Apr 2013 17:04:30 -0400
Message-ID: <20130411210430.GA6234@pug.qqx.org>
References: <20130411110511.GB24296@pacific.linksys.moosehall>
 <1365681913-7059-1-git-send-email-git@adamspiers.org>
 <1365681913-7059-4-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Thu Apr 11 23:04:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQOfh-0006Gg-GV
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 23:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935975Ab3DKVEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 17:04:33 -0400
Received: from pug.qqx.org ([50.116.43.67]:51651 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935750Ab3DKVEb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 17:04:31 -0400
Received: by pug.qqx.org (Postfix, from userid 1000)
	id 935EB1D3EE; Thu, 11 Apr 2013 17:04:30 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1365681913-7059-4-git-send-email-git@adamspiers.org>
User-Agent: Mutt/1.5.21+145 (gd0ebb66) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220929>

At 13:05 +0100 11 Apr 2013, Adam Spiers <git@adamspiers.org> wrote:
>The above use case suggests that empty STDIN is actually a reasonable
>scenario (e.g. when the caller doesn't know in advance whether any
>queries need to be fed to the background process until after it's
>already started), so we make the minor behavioural change that "no
>pathspec given." is no longer emitted in when STDIN is empty.

The last "in" there looks to be misplaced.  Was that originally 
something like "in the case"?  If so the removed words should be 
restored or the lingering one removed as well.
