From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v3] for-each-ref: `:short` format for `refname`
Date: Wed, 3 Sep 2008 08:18:29 -0700
Message-ID: <20080903151829.GB27682@spearce.org>
References: <36ca99e90809030133r43fc5a3agad1aa38339a758a3@mail.gmail.com> <1220431352-30605-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	szeder@ira.uka.de
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 17:19:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kau8u-0004dc-RD
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 17:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbYICPSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 11:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635AbYICPSa
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 11:18:30 -0400
Received: from george.spearce.org ([209.20.77.23]:44104 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbYICPS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 11:18:29 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 27D8B38375; Wed,  3 Sep 2008 15:18:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1220431352-30605-1-git-send-email-bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94802>

Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> Try to shorten the refname to a non-ambiguous name.
> 
> Changes in v3:
>  * don't compare sha1's, its ambiguous if the short name
>    resovles to more than one ref
>  * use xstrdup()
>  * use indexes for the loops to clarify backward/forward
>    direction
> 
> 
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> Cc: git@vger.kernel.org
> Cc: szeder@ira.uka.de
> Cc: Shawn O. Pearce <spearce@spearce.org>
> ---

Looks good.  But the commit messages shouldn't have the "Changes
in v3" section or probably the "Cc:" lines.  The changes in v3
part usually goes below the ---.

I don't usually work on for-each-ref, but I'll toss an ack in anyway:

Acked-by: Shawn O. Pearce <spearce@spearce.org>

-- 
Shawn.
