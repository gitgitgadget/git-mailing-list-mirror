From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: Not pushing all branches?
Date: Fri, 13 Mar 2009 12:38:56 +0100
Message-ID: <20090313113856.GA26726@pvv.org>
References: <alpine.DEB.2.00.0903130846410.17450@perkele.intern.softwolves.pp.se> <7bfdc29a0903130112w17d40473s14a895d518dbf8ae@mail.gmail.com> <alpine.DEB.2.00.0903131043510.17450@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Imran M Yousuf <imyousuf@gmail.com>, git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Mar 13 12:41:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li5l5-0007Ee-IL
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 12:41:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792AbZCMLjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 07:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbZCMLi7
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 07:38:59 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:49088 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbZCMLi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 07:38:59 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1Li5j6-0002ky-Hd; Fri, 13 Mar 2009 12:38:56 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0903131043510.17450@perkele.intern.softwolves.pp.se>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113174>

On Fri, Mar 13, 2009 at 10:44:49AM +0100, Peter Krefting wrote:
> Imran M Yousuf:
>
>> Just try -
>> git push remote branch :)
>
> That is what I do. Unfortunately, the times I forged to name the branch, 
> it pushes my master branch, which is different from the remote's, and I 
> have to go to the other repository and reset it manually...

I sent a patch series a few days ago to fix this in various ways,
adding a configuration variable push.default, and also indicating that
pushing nothing rather than pushing all matching branches is a safer
(and saner) default.

As you have also discovered, it is very easy to accidentally push
master to the wrong remote with the current default behavior.

- Finn Arne
