From: Hannu Koivisto <azure@iki.fi>
Subject: Re: git rebase -i (and gitk) problem in Windows/Cygwin
Date: Tue, 07 Apr 2009 17:53:26 +0300
Message-ID: <83ws9wh5w9.fsf@kalahari.s2.org>
References: <831vs4im37.fsf@kalahari.s2.org>
	<alpine.DEB.1.00.0904071624250.6897@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 07 17:29:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrDF9-00053K-M0
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 17:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761471AbZDGP0n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 11:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761574AbZDGP0m
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 11:26:42 -0400
Received: from s2.org ([195.197.64.39]:50372 "EHLO kalahari.s2.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761551AbZDGP0l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 11:26:41 -0400
X-Greylist: delayed 1993 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Apr 2009 11:26:40 EDT
Received: from azure by kalahari.s2.org with local (Exim 4.69)
	(envelope-from <azure@iki.fi>)
	id 1LrCg2-0000Z8-7N; Tue, 07 Apr 2009 17:53:26 +0300
In-Reply-To: <alpine.DEB.1.00.0904071624250.6897@intel-tinevez-2-302>
	(Johannes Schindelin's message of "Tue, 7 Apr 2009 16:25:16 +0200
	(CEST)")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/22.2 (gnu/linux)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: azure@iki.fi
X-SA-Exim-Scanned: No (on kalahari.s2.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115963>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Tue, 7 Apr 2009, Hannu Koivisto wrote:
>
>> * I change a file in workspace.
>> * I "Update" in gitk - I see the change.
>> * I undo the change.
>> * I "Update" in gitk - I see an empty change.
>> * "Reload" doesn't help - I still se an empty change.
>> * I run "git status" on the command line and then select "Update"
>>   in gitk -> now the change disappears.
>
> What does "git diff" say?  It may be an autocrlf issue or a file mode 
> issue.

It outputs only one line "diff --git a/path/to/file" (where the
file is the one I modified and then undid the modification).  After
I run "git status", it outputs absolutely nothing.

In my gitk problem case I have autocrlf and safecrlf toggled on for
the repository and crlf attribute forced for the file in question.
It was in this repository I also first saw the rebase problem but
when I ran the shown test case, autocrlf and safecrlf were off
(they are globally off and I just toggle them on for some
repositories).

I remember seeing and reporting a similar "spurious changes in
gitk" problem a long time ago and I recall back then Junio came up
with some file mode related modification.  I haven't seen the
problem since until now.

-- 
Hannu
