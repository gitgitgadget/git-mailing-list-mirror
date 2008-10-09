From: Samuel Lucas Vaz de Mello <samuellucas@datacom.ind.br>
Subject: Re: Git newbie question: permissions
Date: Thu, 09 Oct 2008 18:05:54 -0300
Organization: DATACOM
Message-ID: <48EE7232.5080107@datacom.ind.br>
References: <1b5a37350810091320l72ae0a86m39db4258c9f4827e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 09 23:31:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ko36C-0007xN-SQ
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 23:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755585AbYJIV3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 17:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757386AbYJIV3l
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 17:29:41 -0400
Received: from mail.datacom-telematica.com.br ([200.213.13.18]:49303 "EHLO
	mail.datacom-telematica.com.br" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757355AbYJIV3k (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Oct 2008 17:29:40 -0400
X-Greylist: delayed 1401 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Oct 2008 17:29:40 EDT
Received: by mail.datacom-telematica.com.br (Postfix, from userid 65)
	id F38E332AE1; Thu,  9 Oct 2008 18:35:56 -0300 (BRST)
Received: from [10.1.3.11] (unknown [10.1.3.11])
	by mail.datacom-telematica.com.br (Postfix) with ESMTP id 9542032AD6
	for <git@vger.kernel.org>; Thu,  9 Oct 2008 18:35:56 -0300 (BRST)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
In-Reply-To: <1b5a37350810091320l72ae0a86m39db4258c9f4827e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97889>

Ed Schofield wrote:
> I don't think I specified "--shared=group" when initializing the
> repository. Afterwards I manually set all files to have 660
> permissions, dirs as 770, and set the group ownership to "webdev", but
> I probably made a mistake by not setting the setgid bit on
> directories. Now there are some objects directories with 755
> permissions and different group ownership (the default groups of the
> other users).
>   
Hi Ed!

I'm also a newbie here and I have a very similar setup to yours.

The only difference is that my repository was created using 
git-cvsimport and afterwards I used git-config to set 
core.sharedrepository=1 and manually set up the permissions.

I also got objects created with the users' default group, but for now I 
just changed the deafault group for those users until I find a better 
solution.

Another issue with this setup: if I run git-gc in the shared repo, it 
recreate the files in logs/refs/heads with 644 permissions, which 
prevents users to push until I manually fix the permissions.

Someone else have faced these kind of problems?

Regards,

 - Samuel
