From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: Reverting to old commit
Date: Tue, 27 May 2008 15:43:52 -0500
Message-ID: <6IRlPIxadiyIIPsto-MFx6wInl0VvCRxVSaI3-OglmCjLt5obfbiww@cipher.nrlssc.navy.mil>
References: <8345bd80805271050q7412917bt292a276fbbe6aed3@mail.gmail.com> <m3bq2r39gh.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marcus <prima@wordit.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 22:45:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K162J-000272-HZ
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 22:44:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758241AbYE0Un4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 16:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758215AbYE0Un4
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 16:43:56 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:51689 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757505AbYE0Unz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 16:43:55 -0400
Received: by mail.nrlssc.navy.mil id m4RKhrBx009313; Tue, 27 May 2008 15:43:53 -0500
In-Reply-To: <m3bq2r39gh.fsf@localhost.localdomain>
X-OriginalArrivalTime: 27 May 2008 20:43:53.0639 (UTC) FILETIME=[604D8B70:01C8C03A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83047>

Jakub Narebski wrote:
> Marcus <prima@wordit.com> writes:
> 
>> Newbie question: What's the simplest way to find an old commit and revert?
>>
>> Say you have a version from yesterday which worked and today's
>> experiments failed, so you want to go back to that working version.
>> Unfortunately, it's not tagged. Instead you need to actually view the
>> code to identify the version you want. I thought maybe gitk might
>> help, but I can't find my way with gitk. I hoped you could browse
>> revisions easier in a GUI and tell gitk or git-gui to revert?
> 
> Errr... isn't it what git-bisect is for?
> 
> If it is not, viewing git-log, or git-reflog output should help...

Shouldn't we be encouraging the use of 'git log -g' rather than 'git reflog'?
git-reflog seems more like plumbing than porcelain to me.

-brandon
