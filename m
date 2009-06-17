From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: git rebase --interactive squash/squish/fold/rollup
Date: Wed, 17 Jun 2009 20:20:36 +0200
Message-ID: <20090617182036.GA4500@localhost>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com> <43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com> <7vvdmurfao.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Tapsell <johnflux@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 20:21:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGzlA-0000v7-QV
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 20:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbZFQSVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 14:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbZFQSVI
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 14:21:08 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:28068 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbZFQSVH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 14:21:07 -0400
Received: from darc.dnsalias.org ([84.154.66.80]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 17 Jun 2009 20:21:07 +0200
Received: from drizzd by darc.dnsalias.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MGzkS-0001HI-Pd; Wed, 17 Jun 2009 20:20:36 +0200
Content-Disposition: inline
In-Reply-To: <7vvdmurfao.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 17 Jun 2009 18:21:09.0747 (UTC) FILETIME=[6346D430:01C9EF78]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121766>

On Wed, Jun 17, 2009 at 09:33:19AM -0700, Junio C Hamano wrote:
> So I can see why a variant of "squash" that does not change (nor even ask
> for a replacement of) the commit log message from the one that is being
> amended could be useful.

How about deleting the commit message header?

pick c0ffee not to be modified commit message
pick 012345 squashme
...

=>

pick c0ffee not to be modified commit message
squash 012345
...

It requires explicit removal the unwanted commit message, avoiding any
accidents due to ambiguous keywords.
