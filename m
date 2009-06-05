From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: ssh git-pull fails
Date: Fri, 5 Jun 2009 11:47:18 +0200
Message-ID: <AE04C818-3B23-49BC-9EF2-2C9B8BAB3B28@dbservice.com>
References: <765581.84306.qm@web38806.mail.mud.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: kenet3@yahoo.com
X-From: git-owner@vger.kernel.org Fri Jun 05 11:48:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCW1o-0000Xz-Pv
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 11:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479AbZFEJrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 05:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751672AbZFEJrd
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 05:47:33 -0400
Received: from office.neopsis.com ([78.46.209.98]:36886 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbZFEJrd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 05:47:33 -0400
Received: from [10.3.112.145] ([147.88.200.112])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES128-SHA (128 bits));
	Fri, 5 Jun 2009 11:47:32 +0200
In-Reply-To: <765581.84306.qm@web38806.mail.mud.yahoo.com>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120766>


On Jun 5, 2009, at 11:37 AM, kenet3@yahoo.com wrote:

>
> Hi everyone,
>
> Can anybody please help me with this problem?
>
> I have trouble pulling from an external Git repository through ssh.
>
> Here is the command I use:
> $ git-pull ssh://myusername@external.host:/path/to/git/dir
>
> This error comes up:
> ssh: external.host:: Name or service not known
> fatal: The remote end hung up unexpectedly

try:
$ git pull ssh://myusername@external.host/path/to/git/dir
(note the lack of colon after the hostname)

>
> I've set core.sharedRepository to true in another.host's Git  
> repository.
> Also, umask is set to 27.
>
> If I can manually ssh to external.host with no problem.
>
> Please bear with me as I'm new with this.

tom
