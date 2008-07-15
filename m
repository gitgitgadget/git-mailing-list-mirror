From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: applying and committing patches in a single git command
Date: Tue, 15 Jul 2008 11:53:50 +0300
Message-ID: <487C659E.60606@panasas.com>
References: <ce513bcc0807150150l783e9ff1kd7780dc59f4b5a3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Erez Zilber <erezzi.list@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 10:55:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIgJc-0007AR-Ij
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 10:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754336AbYGOIyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 04:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755289AbYGOIyW
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 04:54:22 -0400
Received: from gw-colo-pa.panasas.com ([66.238.117.130]:30728 "EHLO
	natasha.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754223AbYGOIyV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 04:54:21 -0400
Received: from daytona.int.panasas.com (daytona.int.panasas.com [172.17.28.41])
	by natasha.panasas.com (8.13.1/8.13.1) with ESMTP id m6F8s9oA010056;
	Tue, 15 Jul 2008 04:54:09 -0400
Received: from bh-buildlin2.bhalevy.com ([172.17.28.136]) by daytona.int.panasas.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 15 Jul 2008 04:53:20 -0400
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <ce513bcc0807150150l783e9ff1kd7780dc59f4b5a3d@mail.gmail.com>
X-OriginalArrivalTime: 15 Jul 2008 08:53:20.0948 (UTC) FILETIME=[3B7AE740:01C8E658]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88542>

Erez Zilber wrote:
> Hi,
> 
> Someone created a patch with git-format-patch and sent it to me. I
> would like to apply & commit the patch. If I use git-apply, it only
> patches my tree without committing it. Now, I need to copy the commit
> log, run git-commit and paste the commit log there. Is there a more
> intelligent way to do that?
> 
> Thanks,
> Erez
> 
git-am, can take all bunch of them at once

Boaz
