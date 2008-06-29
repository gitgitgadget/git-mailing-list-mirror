From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: Is there a way to diff between a local repository and a remote
 one?
Date: Sun, 29 Jun 2008 14:55:40 +0300
Message-ID: <4867783C.1010408@panasas.com>
References: <ce513bcc0806290429r1982fbf2i4c9a8258bc8db3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Erez Zilber <erezzi.list@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 13:57:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCvWg-0008V2-1z
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 13:57:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379AbYF2L4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 07:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752333AbYF2L4F
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 07:56:05 -0400
Received: from gw-colo-pa.panasas.com ([66.238.117.130]:1110 "EHLO
	natasha.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752298AbYF2L4E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 07:56:04 -0400
Received: from daytona.int.panasas.com (daytona.int.panasas.com [172.17.28.41])
	by natasha.panasas.com (8.13.1/8.13.1) with ESMTP id m5TBtwSo012711;
	Sun, 29 Jun 2008 07:55:58 -0400
Received: from bh-buildlin2.bhalevy.com ([172.17.28.133]) by daytona.int.panasas.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 29 Jun 2008 07:55:42 -0400
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <ce513bcc0806290429r1982fbf2i4c9a8258bc8db3c@mail.gmail.com>
X-OriginalArrivalTime: 29 Jun 2008 11:55:42.0768 (UTC) FILETIME=[0EB42300:01C8D9DF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86796>

Erez Zilber wrote:
> I could clone the remote repository and use Linux's diff, but I prefer
> to do it the right way (if possible).
> 
> Thanks,
> Erez
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

I use git-remote add

and git-diff that_remote/that_branch

then from time to time "git-remote update" to update on remote progress

Boaz
