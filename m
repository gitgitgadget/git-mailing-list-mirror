From: Mike <fromlists@talkingspider.com>
Subject: Re: I don't want the .git directory next to my code.
Date: Tue, 15 Jan 2008 23:07:22 -0500
Message-ID: <478D82FA.2030404@talkingspider.com>
References: <478D79BD.7060006@talkingspider.com> <86hcheig3n.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 05:07:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEzZA-0000jW-S7
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 05:07:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756359AbYAPEHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 23:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757217AbYAPEHY
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 23:07:24 -0500
Received: from relay00.pair.com ([209.68.5.9]:4879 "HELO relay00.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756359AbYAPEHY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 23:07:24 -0500
Received: (qmail 36393 invoked from network); 16 Jan 2008 04:07:23 -0000
Received: from unknown (HELO ?192.168.1.100?) (unknown)
  by unknown with SMTP; 16 Jan 2008 04:07:23 -0000
X-pair-Authenticated: 72.225.213.70
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <86hcheig3n.fsf@blue.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70618>



Randal L. Schwartz wrote:
>>>>>> "Mike" == Mike  <fromlists@talkingspider.com> writes:
> 
> 
> Sounds like you need an installer... something that copies your repo into the
> live location with things you don't want included left out, and all the
> permissions and ownership correct.

If you mean copying files from the development webserver to the live 
server, then the only reason we'd need an installer is because of the 
.git directory, it's the only thing we "don't want included".  And as 
for permissions and ownership, rsync takes care of that.

> 
> git archive --help
>

I got:

$ git archive --help
No manual entry for git-archive

Did I install it wrong?  I have CentOS 5, and I did:

su
yum install git

thanks,
m
