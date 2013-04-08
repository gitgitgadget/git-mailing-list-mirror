From: Miklos Vajna <vmiklos@suse.cz>
Subject: Re: [PATCH] cherry-pick: better error message when the parameter is
 a non-commit
Date: Mon, 8 Apr 2013 14:27:50 +0200
Message-ID: <20130408122750.GB5132@suse.cz>
References: <20130403092704.GC21520@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 08 18:31:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPEx3-0003oz-Gb
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 18:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935835Ab3DHM15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 08:27:57 -0400
Received: from cantor2.suse.de ([195.135.220.15]:55182 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935294Ab3DHM14 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 08:27:56 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 36D89A3DDF;
	Mon,  8 Apr 2013 14:27:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130403092704.GC21520@suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220424>

Hi,

On Wed, Apr 03, 2013 at 11:27:04AM +0200, Miklos Vajna <vmiklos@suse.cz> wrote:
> When copy&paste goes wrong, and the user e.g. tries to cherry-pick a
> blob, the error message used to be:
> 
> 	fatal: BUG: expected exactly one commit from walk
> 
> Instead, now it is:
> 
> 	fatal: Can't cherry-pick a blob
> 
> Signed-off-by: Miklos Vajna <vmiklos@suse.cz>
> ---
>  sequencer.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Ping, any comment on this patch?

Thanks,

Miklos
