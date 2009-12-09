From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Wed, 9 Dec 2009 11:52:41 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0912091150470.470@ds9.cixit.se>
References: <20091208144740.GA30830@redhat.com> <7vfx7lcj18.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.0912090941420.470@ds9.cixit.se> <20091209093758.GA2977@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 11:53:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIKAS-0003sx-0U
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 11:53:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897AbZLIKw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 05:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754832AbZLIKw6
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 05:52:58 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:37412 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754649AbZLIKw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 05:52:57 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id nB9AqfPO025096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 9 Dec 2009 11:52:41 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id nB9AqfUo025092;
	Wed, 9 Dec 2009 11:52:41 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <20091209093758.GA2977@redhat.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Wed, 09 Dec 2009 11:52:41 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134957>

Michael S. Tsirkin:

>> Maybe this could also be used to implement a "git merge --squash A..B", 
>> a.k.a a "partial merge".
> What exactly should it do?

The same thing, apply a set of changes on top of the current branch, just 
using the "merge" name, and not "rebase" or "cherry-pick". "merge --squash" 
is just "cherry-pick" with a different name.

-- 
\\// Peter - http://www.softwolves.pp.se/
