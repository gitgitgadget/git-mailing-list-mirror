From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: Git improvement for line feed processing: LF versus CR-LF
Date: Mon, 08 Sep 2014 11:29:41 +0200
Message-ID: <540D7705.4000405@web.de>
References: <540D6EEB.2040101@orange.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Francis ANDRE <francis.andre.kampbell@orange.fr>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 08 11:32:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQvJ6-0007Th-7J
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 11:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753719AbaIHJcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2014 05:32:14 -0400
Received: from mout.web.de ([212.227.17.12]:60006 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753706AbaIHJcM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2014 05:32:12 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0Lj2I6-1XxVhM1P4w-00dDAr; Mon, 08 Sep 2014 11:32:10
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Icedove/24.6.0
In-Reply-To: <540D6EEB.2040101@orange.fr>
X-Provags-ID: V03:K0:UfL8lzTZv4Jl0iCas98aWXsHSI3GcsZK/4krO+FsUXdiyJVGcKU
 qpAqkfZaM+JKKI+nXw/1Lhtu7+7oD3oEtXe5nFgag9fSNFRZEMbsCN/MBlrEfKSxDdYebA7
 z+iLsiosJighHoKaNDx0f/yj1tDCjhYxzmTkluamJhPIt1IO29HWo7kXxdrxx1KbHniivuq
 ZVq5aqbvKIswC7DQ2AVvA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256637>

On 09/08/2014 10:55 AM, Francis ANDRE wrote:
> Hi
> []
> All text file line endings in the repository must be Unix-style (LF). 
> This includes Visual Studio project and solution files (.sln, .vcproj, 
> .vcxproj, .vcxproj.filters).
>
> But git-gui translates states:
> warning: LF will be replaced by CRLF in file.txt. The file will have 
> its original line endings in your working directory.
>
> Could you add a option to git-gui to specify to translate or not the 
> end of line of the cloned repository so that my fixes be accepted by 
> the owner of the repository.
>
> Thanks
Unless I'm completely wrong, such an option already exists, please see

http://git-htmldocs.googlecode.com/git/gitattributes.html
