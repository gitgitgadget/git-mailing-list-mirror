From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: gitk with submodules does not show new commits on other branches
Date: Sun, 22 Jun 2014 17:42:48 +0200
Message-ID: <53A6F978.4010005@web.de>
References: <lo6o2h$vva$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Stephen Kelly <steveire@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 22 17:43:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wyjv7-0004Di-DC
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jun 2014 17:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbaFVPm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2014 11:42:59 -0400
Received: from mout.web.de ([212.227.17.12]:62951 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966AbaFVPm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2014 11:42:58 -0400
Received: from [192.168.178.41] ([84.132.135.9]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0Md4V8-1XFiq239gA-00IGNz; Sun, 22 Jun 2014 17:42:56
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <lo6o2h$vva$1@ger.gmane.org>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:sP1LutPjKoNUMpJirRdrJeKTPaWLNeXyEcgVvWc30F83//SzxlJ
 j5Jjj1SpHEgy/1oXNBikjsvcvJA42IxrikqQAP+wzgag12EWbAzOeAv8eIDAGVey+Qp4EwH
 A+dEA2sBs8dhSTlEbn/OH6/lAXyCHmS1E7QUyHJkBjIuqX115dyRw8yN1fX4XMp44LA3ZtW
 v3b9yDIYX1RFpM8j9G/qQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252310>

Am 22.06.2014 16:09, schrieb Stephen Kelly:
> 
> Hello,
> 
> boost.git, is using submodules. 
> 
> If I run gitk after a pull, there are some messages along the lines of 
> 
> 
>     Update preprocessor from develop.
> 
>   Submodule libs/preprocessor 9d2d1ff..1422fce:
>     Merge branch 'master' into develop
> 
> 
> That is, it shows only the merge. 
> 
> If I then run 
> 
>  git log --oneline 9d2d1ff..1422fce 
> 
> I can see the commits which were made on master and then merged into 
> develop. Please show the same information (ie all commits newly reachable 
> from develop) in the submodule gitk output.

This should not happen by default. If you have a feature branch based
workflow, the merge is just what you want to see. And "git submodule
summary" is giving you the exact same information.

But I agree that this is suboptimal for your workflow. What about adding
a "Visualize These Changes In The Submodule" menu entry for the context
menu of a change in gitk just like the one git gui already has? Then the
user could examine the merges in more detail if he wants.
