From: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: How can I figure out what commits relate to a given diff?
Date: Thu, 22 May 2008 16:53:41 -0400
Message-ID: <4835DD55.8080500@harris.com>
References: <48358F7E.6030401@harris.com> <20080522154859.GM27724@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Steven A. Falco" <sfalco@harris.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 22 22:55:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzHoU-000773-T1
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 22:55:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755629AbYEVUyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 16:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752682AbYEVUyI
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 16:54:08 -0400
Received: from mlbe2k1.cs.myharris.net ([137.237.90.88]:31183 "EHLO
	mlbe2k1.cs.myharris.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755318AbYEVUyG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 16:54:06 -0400
Received: from mail pickup service by mlbe2k1.cs.myharris.net with Microsoft SMTPSVC;
	 Thu, 22 May 2008 16:53:43 -0400
Received: from saf.cs.myharris.net ([137.237.94.251]) by mlbe2k1.cs.myharris.net with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 22 May 2008 16:53:42 -0400
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <20080522154859.GM27724@genesis.frugalware.org>
X-OriginalArrivalTime: 22 May 2008 20:53:42.0570 (UTC) FILETIME=[EB4488A0:01C8BC4D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82652>

Miklos Vajna wrote:
> On Thu, May 22, 2008 at 11:21:34AM -0400, "Steven A. Falco" <sfalco@harris.com> wrote:
>> Is there a way to map a blob SHA1 to a commit?  In this example, I'd
>> like to map 9ceadaa and ad31bc6 to their commits.  It seems easy to go
>> the other way, seeing what is in a commit, but I've not been able to
>> find a method for going "backwards" from a blob to a commit.
> 
> Something like:
> 
> for i in `git rev-list HEAD`
> do
>         git ls-tree -r $i|grep -q cb4e8ed && echo "$i contains cb4e8ed"
> done
> 
> could do it for you.
> 
> I don't think there is a --contains for blobs, like git branch
> --contains works for commits.

Thanks!  It found the commit I needed.

	Steve
