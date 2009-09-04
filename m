From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Deleted folder keeps showing up?
Date: Fri, 04 Sep 2009 09:41:22 +0200
Message-ID: <4AA0C4A2.5040405@drmicha.warpmail.net>
References: <34230C98-81B8-4DC8-846F-8B6FA2A022DA@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Benjamin Buch <benni.buch@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 04 09:41:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjTQU-0004bh-0f
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 09:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbZIDHld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 03:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbZIDHlc
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 03:41:32 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37598 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932185AbZIDHlc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Sep 2009 03:41:32 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4B60D61EA6;
	Fri,  4 Sep 2009 03:41:34 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 04 Sep 2009 03:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Z1xE8hONQXYcL2lFq2G3rIRx2jQ=; b=ihW8wwUKJKwIK48araUxmOsj/Oiw+ai2NKdQOhNsiRsjzcKpHU7ssHmKU4suGj1Gmr+2+I47L2U6IV7u5qUS3zE8puRIWNF+MfgZ8PStcCxK2PfNEOfPXxpaZpz0qM/MLZn5JYDThozksBhqTo2LgmMGpNnXdPhrNhH2qYlbubI=
X-Sasl-enc: EKmPcEBhF2P//57PwEnMHWNVFhrajQqrME8HmQpQGnY3 1252050093
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A72321E87F;
	Fri,  4 Sep 2009 03:41:33 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20090902 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <34230C98-81B8-4DC8-846F-8B6FA2A022DA@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127692>

Benjamin Buch venit, vidit, dixit 03.09.2009 18:59:
> I made a branch and deleted a folder there with git rm -rf foldername.
> So now i have to branches, A with the folder and B without the folder.
> 
> I'm on B, the folder is not there.
> Then I check out A, the folder shows up like it should.
> When I check out B again, the folder is still there.
> 
> A git rm -rf folder gives me:
> 
> 	fatal: pathspec 'folder/' did not match any files
> 
> , so git is not tracking the folder.
> 
> I can rm -rf the filder without git and start the whole game from the  
> beginning,
> but there has to be a better way?
> 
> Strange enough this happens just to two folders I removed,
> with others there is no problem.

What does "git status" say when you've checked out B? Could some
contents of folder/ possibly be being ignored (.git/info/excludes etc.)?

Michael
