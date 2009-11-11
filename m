From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v5 2/2] filter-branch: nearest-ancestor rewriting outside subdir filter
Date: Wed, 11 Nov 2009 19:36:04 +0100
Message-ID: <200911111936.06332.trast@student.ethz.ch>
References: <4AE945D0.5030403@viscovery.net> <4AFA7C1E.1050606@viscovery.net> <7vocn8q5v2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 19:37:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8I45-0006X7-UJ
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 19:37:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758232AbZKKSg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 13:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758125AbZKKSg6
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 13:36:58 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:15352 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757814AbZKKSg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 13:36:57 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 11 Nov
 2009 19:37:01 +0100
Received: from thomas.localnet (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 11 Nov
 2009 19:36:50 +0100
User-Agent: KMail/1.12.3 (Linux/2.6.27.29-0.1-default; KDE/4.3.3; x86_64; ; )
In-Reply-To: <7vocn8q5v2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132684>

Junio C Hamano wrote:
> 
> Up to this point, nothing mentions the name of the new option.  Please
> write your log for a person who needs to write the release notes by
> looking at "git shortlog" output ;-)
> 
> I am wondering if this even needs an option to trigger.  Shouldn't you
> want this behaviour always when you give any pathspec?
> 
> What are the sane reasons to leave the rewritten ref to point at the old
> commit, essentially making the rewritten history unreachable?

Fear of hysterical raisins, nothing else.  I cannot really see a
use-case of the original behaviour, and since it does not change the
behaviour in the case of an unfiltered rewrite, it should be safe to
always be enabled.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
