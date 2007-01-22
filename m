From: Bill Lear <rael@zopyra.com>
Subject: Re: git-push through git protocol
Date: Sun, 21 Jan 2007 18:03:07 -0600
Message-ID: <17843.65339.528621.549961@lisa.zopyra.com>
References: <17843.29798.866272.414435@lisa.zopyra.com>
	<46a038f90701211549v1e3dbb9dgf4eb810c8756b5d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 01:03:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8meg-00080W-N7
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 01:03:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbXAVADT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 19:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbXAVADT
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 19:03:19 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60062 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751800AbXAVADS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 19:03:18 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0M03GN07288;
	Sun, 21 Jan 2007 18:03:16 -0600
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90701211549v1e3dbb9dgf4eb810c8756b5d7@mail.gmail.com>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37367>

On Monday, January 22, 2007 at 12:49:02 (+1300) Martin Langhoff writes:
>On 1/22/07, Bill Lear <rael@zopyra.com> wrote:
>> 2) we have run into problems
>> with developers having different umasks ---
>
>This is a non-issue. Just do git-repo-config core.sharedrepository 1
>on each repo.

Does this have the same effect as 'git --bare init-db --shared'?
If so, I thought that was the way we initialized our company repo,
though our config file reads:

[core]
        repositoryformatversion = 0
        filemode = true

I also note that our company repo does not have this:

[receive]
        denyNonFastforwards = true

which now makes me nervous.  I would assume this would be a good thing
to have, no?


Bill
