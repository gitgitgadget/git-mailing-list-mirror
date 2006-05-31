From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: format-patch signoff argument no longer works
Date: Wed, 31 May 2006 15:19:55 -0400
Message-ID: <20060531191955.GH13682@fieldses.org>
References: <93c3eada0605310332p19241861g466e1516a2aaf0df@mail.gmail.com> <93c3eada0605310411r712dab8au9b1c7d8ecb595a66@mail.gmail.com> <20060531112803.GB3877@spinlock.ch> <m2mzcycn4f.fsf@ziti.fhcrc.org> <7vejyayq46.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Seth Falcon <sethfalcon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 31 21:20:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlWEa-0000Ca-Vq
	for gcvg-git@gmane.org; Wed, 31 May 2006 21:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965110AbWEaTT5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 15:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965112AbWEaTT5
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 15:19:57 -0400
Received: from mail.fieldses.org ([66.93.2.214]:14516 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S965110AbWEaTT4
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 May 2006 15:19:56 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.62)
	(envelope-from <bfields@fieldses.org>)
	id 1FlWEV-0006Xt-7a; Wed, 31 May 2006 15:19:55 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vejyayq46.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21077>

On Wed, May 31, 2006 at 12:02:33PM -0700, Junio C Hamano wrote:
> Now, we could do that by re-adding "format-patch -s" option, or
> alternatively we could add that to "send-email".  We might want
> to do both ;-)

Personally, just to give myself the best change of catching problems
with the outgoing email, I'd prefer to have as much as possible be done
*before* send-email, so whatever I review is as close to what's sent out
as possible.

--b.
