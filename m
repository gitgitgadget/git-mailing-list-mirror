From: Adam Simpkins <adam@adamsimpkins.net>
Subject: Re: [PATCH 2/2] graph API: don't print branch lines for uninteresting merge parents
Date: Sat, 24 May 2008 15:21:01 -0700
Message-ID: <20080524222101.GA6795@adamsimpkins.net>
References: <7vk5hkpjj5.fsf@gitster.siamese.dyndns.org> <1211595851-11992-1-git-send-email-adam@adamsimpkins.net> <1211595851-11992-2-git-send-email-adam@adamsimpkins.net> <1211595851-11992-3-git-send-email-adam@adamsimpkins.net>
Reply-To: Adam Simpkins <adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 25 00:22:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0283-0005gf-PD
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 00:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762858AbYEXWV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 18:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762031AbYEXWV0
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 18:21:26 -0400
Received: from smtp172.iad.emailsrvr.com ([207.97.245.172]:42577 "EHLO
	smtp172.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762843AbYEXWVF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 18:21:05 -0400
Received: from relay7.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay7.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 428D61B401A
	for <git@vger.kernel.org>; Sat, 24 May 2008 18:21:04 -0400 (EDT)
Received: by relay7.relay.iad.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 2336C1B400E
	for <git@vger.kernel.org>; Sat, 24 May 2008 18:21:04 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id 793A414100C8; Sat, 24 May 2008 15:21:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1211595851-11992-3-git-send-email-adam@adamsimpkins.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82834>

On Fri, May 23, 2008 at 07:24:11PM -0700, Adam Simpkins wrote:
> Previously, the graphing code printed lines coming out of a merge commit
> for all of its parents, even if some of them were uninteresting.  Now it
> only prints lines for interesting commits.
> 
> For example, for a merge commit where only the first parent is
> interesting, the code now prints:
> 
>   *  merge commit
>   *  interesting child
> 
> instead of:
> 
>   M  merge commit
>   |\
>   *  interesting child

Whoops.  I forgot:

Signed-off-by: Adam Simpkins <adam@adamsimpkins.net>

-- 
Adam Simpkins
adam@adamsimpkins.net
