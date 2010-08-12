From: Brian Foster <brian.foster@innova-card.com>
Subject: Re: [Q] `git fetch tag NAME' into mirror repo does not update HEAD, what to do?
Date: Thu, 12 Aug 2010 12:38:51 +0200
Message-ID: <201008121238.51983.brian.foster@innova-card.com>
References: <201008120954.27648.brian.foster@innova-card.com> <4C63B1C9.6050801@dbservice.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 12:39:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjVCA-0005Gi-Bs
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 12:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617Ab0HLKja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 06:39:30 -0400
Received: from 6-61.252-81.static-ip.oleane.fr ([81.252.61.6]:38620 "EHLO
	zebulon.innova-card.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751869Ab0HLKj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 06:39:29 -0400
Received: from localhost ([127.0.0.1])
	by zebulon.innova-card.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Thu, 12 Aug 2010 12:39:00 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.28-15-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <4C63B1C9.6050801@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153364>

On Thursday 12 August 2010 10:33:13 Tomas Carnecky wrote:

Tom,
 Thanks for the reply, but I suspect you didn't read
 the problem correctly ....

> On 8/12/10 9:54 AM, Brian Foster wrote:
> >  Bare repository ORIG's master looks like this:
> >[ ... ] 
> >  Repository SLAVE is a mirror clone of ORIG which
NOTE.......................^^^^^^
>[ ... ] 
> Fetch only fetches commits. It doesn't update any local refs (other than
> FETCH_HEAD). If you want to switch HEAD to that new tag, use checkout.

 No, a fetch in a mirror, when fetching all the way
 to the HEAD (e.g., a simple `git fetch origin'),
 does update the branch.  (You can easily modify the
 script I included to prove this.)

>[ ... ]
> Is SLAVE a bare repo?  [ ... ]

 Yes it is bare (because it's a mirror), as per the
 description, subject, and posted script.
cheers!
	-blf-
