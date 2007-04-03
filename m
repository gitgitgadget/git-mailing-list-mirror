From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: StGit patchname numeric prefix?
Date: Tue, 03 Apr 2007 15:37:42 +0100
Message-ID: <tnx648d5xs9.fsf@arm.com>
References: <87odm5r833.fsf@gmail.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jamie Border <jborder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 16:38:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYk93-0003Cb-TE
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 16:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966179AbXDCOh7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 10:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966188AbXDCOh7
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 10:37:59 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:48012 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966179AbXDCOh6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Apr 2007 10:37:58 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id l33EbiJN007272;
	Tue, 3 Apr 2007 15:37:44 +0100 (BST)
Received: from localhost.localdomain ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Tue, 3 Apr 2007 15:37:43 +0100
In-Reply-To: <87odm5r833.fsf@gmail.com> (Jamie Border's message of "Tue, 03
 Apr 2007 12:49:36 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 03 Apr 2007 14:37:44.0077 (UTC) FILETIME=[A3ED6BD0:01C775FD]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43622>

Jamie Border <jborder@gmail.com> wrote:
> Is there a switch to have stgit prepend a numeric prefix to the
> patch name?
>
> I'm trying to stg uncommit -n <large_number> from a repository, and
> due to the excellent log messages, half of the patches get called
> 'empty-log-message'.
>
> I'm sure when I played with stg a while ago I found a switch to do
> that.

It automatically adds a suffix if a patch with the same name already
exists, i.e. empty-log-message-0, -1, ..., -n. No extra switch is
needed.

What StGIT version are you using?

-- 
Catalin
