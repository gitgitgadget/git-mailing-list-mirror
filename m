From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH v2] user-manual: mention git gui citool (commit, amend)
Date: Sun, 5 Aug 2007 16:17:00 +0200
Message-ID: <17AA7EBE-B755-4F26-9C7E-AF6D762811F2@zib.de>
References: <20070803125634.GB28323@fieldses.org> <1186318785677-git-send-email-prohaska@zib.de> <Pine.LNX.4.64.0708051457110.14781@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: bfields@fieldses.org, gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Aug 05 16:25:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHh2t-00081b-Fh
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 16:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758020AbXHEOZY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 10:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752528AbXHEOZY
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 10:25:24 -0400
Received: from mailer.zib.de ([130.73.108.11]:62428 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757414AbXHEOZX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 10:25:23 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l75EGDAG022094;
	Sun, 5 Aug 2007 16:19:42 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db10786.pool.einsundeins.de [77.177.7.134])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l75EG8UJ020282
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 5 Aug 2007 16:16:09 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0708051457110.14781@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55025>


On Aug 5, 2007, at 3:58 PM, Johannes Schindelin wrote:

> Hi,
>
> On Sun, 5 Aug 2007, Steffen Prohaska wrote:
>
>> git gui is especially useful because it allows to select diff hunks.
>
> You should give a _big_ _fat_ _red_ warning there.
>
> If you selectively commit diff hunks, you _never_ tested what you
> committed.
>
> That is the reason we're not advertising git add -i more actively.

Hmm... If you do 'git cherry-pick' or 'git rebase' you also did
not test what you committed. Should we advertise them less
actively as well?

But I see your point. Selecting diff hunks tends to be more fine
grained than cherry-picking. But this depends on the details of
what you're doing. I don't think a general warning is appropriate.

	Steffen
