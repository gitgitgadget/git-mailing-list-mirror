From: Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>
Subject: Re: GIT get corrupted on lustre
Date: Tue, 08 Jan 2013 11:11:38 -0500
Message-ID: <50EC453A.2060306@giref.ulaval.ca>
References: <50D861EE.6020105@giref.ulaval.ca> <50D870A0.90205@interlinx.bc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
X-From: git-owner@vger.kernel.org Tue Jan 08 17:12:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsbmR-0001uF-VX
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 17:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756323Ab3AHQLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 11:11:40 -0500
Received: from serveur.giref.ulaval.ca ([132.203.7.102]:56707 "EHLO
	mailhost.giref.ulaval.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754863Ab3AHQLj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 11:11:39 -0500
Received: from localhost (localhost [127.0.0.1])
	by mailhost.giref.ulaval.ca (Postfix) with ESMTP id 31840101FFA;
	Tue,  8 Jan 2013 11:11:39 -0500 (EST)
X-Virus-Scanned: amavisd-new at giref.ulaval.ca
Received: from mailhost.giref.ulaval.ca ([127.0.0.1])
	by localhost (mailhost.giref.ulaval.ca [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dc5sE-b14Fqa; Tue,  8 Jan 2013 11:11:38 -0500 (EST)
Received: from [132.203.7.22] (melkor.giref.ulaval.ca [132.203.7.22])
	by mailhost.giref.ulaval.ca (Postfix) with ESMTP id 42C321018C9;
	Tue,  8 Jan 2013 11:11:38 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <50D870A0.90205@interlinx.bc.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212972>

On 12/24/2012 10:11 AM, Brian J. Murrell wrote:
> Have you tried adding a "-q" to the git command line to quiet down git's
> "feedback" messages?
>

Ok, I have modified my crontab to use "-q" and I will wait to see if the 
problem occurs from now.

> I discovered other oddities with using git on Lustre which I described
> in this thread:
>
> http://thread.gmane.org/gmane.comp.version-control.git/208886
>
> I found that by simply disabling the feedback (which disables the
> copious SIGALRM processing) I could alleviate the issue.
>
> I wonder if your issues are more of the same.
>
> I filed Lustre bug LU-2276 about it at:
>
> http://jira.whamcloud.com/browse/LU-2276

Thank you for these informations.  I see the bug is unresolved!...

Eric
