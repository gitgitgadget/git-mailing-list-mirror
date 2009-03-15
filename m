From: "John M. Dlugosz" <ngnr63q02@sneakemail.com>
Subject: Re: setting up tracking on push
Date: Sat, 14 Mar 2009 22:28:36 -0500
Message-ID: <4845-91917@sneakemail.com>
References: <buofxhr2vta.fsf@dhlpc061.dev.necel.com>	 <gp9jp7$uc3$1@ger.gmane.org>	 <76718490903111758l4e4bd29et379e975deb8e99bd@mail.gmail.com> <76718490903111814t1ab90a39h9252d0ccf8af05c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 15 04:56:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LihSx-0007q8-2g
	for gcvg-git-2@gmane.org; Sun, 15 Mar 2009 04:56:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757145AbZCODzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2009 23:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754937AbZCODzM
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 23:55:12 -0400
Received: from sneakemail.com ([38.113.6.61]:43837 "HELO sneak1.sneakemail.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1753236AbZCODzL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2009 23:55:11 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Mar 2009 23:55:10 EDT
Received: (qmail 8498 invoked by uid 508); 15 Mar 2009 03:48:29 -0000
Received: (sneakemail censored 4845-91917 #1); 15 Mar 2009 03:48:28 -0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.19) Gecko/20081209 Thunderbird/2.0.0.19 Mnenhy/0.7.5.666
In-Reply-To: <76718490903111814t1ab90a39h9252d0ccf8af05c4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113274>

Jay Soffian jaysoffian-at-gmail.com |git| wrote:
> - The branches under refs/remotes (those shown by "git branch -r") are
> remote tracking branches. 
 > So that tells git fetch where to fetch from, which remote branches to
> fetch, and where to store those branches locally. In this case, each
> branch under refs/heads/ on git://git.kernel.org/pub/scm/git/git.git
> will be fetched and stored locally as refs/remotes/origin/. Locally
> the branches are called "remote tracking branches".
>
>   


Things under refs/remotes are remote tracking branches, and local 
branches (under refs/heads) that automatically updated based on a fetch 
("store locally" means merge or rebase, right?) are also called remote 
tracking branches.

I think that's why some of us are confused.

--John
