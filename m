From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Unable to convert a subversion repo to git
Date: Fri, 18 Jan 2013 17:48:03 +0100
Message-ID: <50F97CC3.2000906@drmicha.warpmail.net>
References: <CAO2=c4nr8PsbHmyKptWewQMmpqWP=YasKZSnCuB9CCkExpSF8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Timothy Kretschmer <timothykretschmer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 17:48:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwF7D-0006J8-41
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 17:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542Ab3ARQsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 11:48:05 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:35140 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751052Ab3ARQsE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jan 2013 11:48:04 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 241D020EFA;
	Fri, 18 Jan 2013 11:48:03 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 18 Jan 2013 11:48:03 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=BOCBcSnes0Lr9h3JFmNHFy
	nONFs=; b=kQxjJjdOnYfLqfnk4JgjtR+xpdKaPrVBGvR9ZpCm3sZGrgDuEAD685
	f4FtaKqJ6pWbej9/yaqYYpcyMyCFUfuIEYO4bXA+lp2xLG/qbzrd0jKb3kuxWpqs
	myGqs3TlSnWVDlo5ynWNBQ3ag+ijhPFKbWyYBOMzdByufZvqztqY4=
X-Sasl-enc: LGXkkX7w7VzC4NIdEOBoAnv2qB2t252IzClFwmDDMM0C 1358527682
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 353C4482554;
	Fri, 18 Jan 2013 11:48:02 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <CAO2=c4nr8PsbHmyKptWewQMmpqWP=YasKZSnCuB9CCkExpSF8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213915>

Timothy Kretschmer venit, vidit, dixit 16.01.2013 15:06:
> I am seeing the following output while converting a subversion repo to git.
> 
>  >Found possible branch point: <repo-url>/trunk =>
> <repo-url>/branches/CMT_PHASE3, 18441
>> fatal: Not a valid object name refs/remotes/BlueSimViewer 5.0 20110316 Branch
>> cat-file commit refs/remotes/BlueSimViewer 5.0 20110316 Branch: command returned error: 128
> 
> The command I am running to convert the repo is
> 
>> git svn clone <repo-url> -A authors-transform.txt --stdlayout bluebox-git > svnlist
> 
> I am running git version 1.8.1.1 on an Ubuntu 12.10 server. I am happy
> to provide any other information that would be helpful.
> 
> I appreciate any assistance you can provide in this matter,
>   -Tim

git-svn should cope with funky branch names. What is the exact name of
the "CMT..." and "BlueSimViewer..." branches? Are you using a case
challenged file system or just some standard linux fs?

Michael
