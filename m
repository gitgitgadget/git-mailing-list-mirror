From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Fix 'git add' with .gitignore (Re: git-add ignores .gitignore)
Date: Sat, 30 Dec 2006 09:50:03 -0500
Message-ID: <497AFE26-3192-4265-820D-EED80B3452DC@silverinsanity.com>
References: <033682AF-B324-4049-B331-8A8AF2335E4D@silverinsanity.com> <7vpsa2msx2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 30 15:50:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0fXP-0003sB-6e
	for gcvg-git@gmane.org; Sat, 30 Dec 2006 15:50:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755115AbWL3OuF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 09:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755131AbWL3OuF
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 09:50:05 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:36676 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755115AbWL3OuE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 09:50:04 -0500
Received: from [192.168.0.2] (cpe-69-204-218-82.stny.res.rr.com [69.204.218.82])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 358D41FFD321;
	Sat, 30 Dec 2006 14:50:03 +0000 (UTC)
In-Reply-To: <7vpsa2msx2.fsf@assigned-by-dhcp.cox.net>
To: Junio C Hamano <junkio@cox.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35620>


On Dec 29, 2006, at 1:57 PM, Junio C Hamano wrote:

> Thanks for noticing.
>
> The commit 4888c534 tried to mark the path it returns so that
> the caller can tell if it is ignored or not, but botched the
> case where a directory is ignored.  It should have marked the
> contents as ignored if higher level directory was.
>
> But I think the approach that change makes is more expensive
> than the original code and is not necessary.  How about this
> patch, after you revert that commit?

Tried it and it works for me!  Thanks.

~~ Brian
