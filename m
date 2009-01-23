From: Stephen Bannasch <stephen.bannasch@deanbrook.org>
Subject: Re: egit problem with sym linked eclipse project dirs
Date: Thu, 22 Jan 2009 20:56:16 -0500
Message-ID: <p06240812c59ed365d694@[192.168.1.106]>
References: <p0624081cc5928e2885fd@[192.168.1.114]> <200901132237.11946.robin.rosenberg.lists@dewire.com>
 <p0624085fc592d385c7fb@[192.168.1.114]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 23 02:57:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQBIs-0004Dr-2o
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 02:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756098AbZAWB4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 20:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755783AbZAWB4Z
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 20:56:25 -0500
Received: from deanbrook.org ([72.52.70.192]:55123 "HELO deanbrook.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753796AbZAWB4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 20:56:24 -0500
Received: from ::ffff:71.161.144.33 ([71.161.144.33]) by deanbrook.org for <git@vger.kernel.org>; Thu, 22 Jan 2009 17:56:23 -0800
In-Reply-To: <p0624085fc592d385c7fb@[192.168.1.114]>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106822>

At 6:27 PM -0500 1/13/09, Stephen Bannasch wrote:
>At 10:37 PM +0100 1/13/09, Robin Rosenberg wrote:
>>  > To hack around Eclipse's problem with projects in nested directories
>>>  I clone a repo and then create a new top-level dir that just has
>>>  symbolic links to all the project directories.
>>>
>>>  However when I Team/Share with git using egit the resources become
>>>  untracked when displayed in Eclipse -- they still are tracked however
>>>  when I check from the command line.
>>
>>I've seen this too, but so far not got myself to actually fix it. I 
>>think it has do with
>>that we ask eclipse project for it's path end there we gets off track. Thanks
>>for providing a good example that help "someone" to fix it.
>>
>>Could you add an issue at http://code.google.com/p/egit/issues/list and maybe
>>include a tar  ball with a simple project displaying this 
>>behaviour? (with a note
>>that the symlinks makes this impossible to recreate on Windows).
>
>Done: http://code.google.com/p/egit/issues/detail?id=52
>
>Fxing this will make using Eclipse and Git together SO much nicer!

Robin and Shawn,

Can you suggest where in the egit code I should look to see if I can fix this?
