From: Mike <fromlists@talkingspider.com>
Subject: Re: I don't want the .git directory next to my code.
Date: Wed, 16 Jan 2008 01:00:00 -0500
Message-ID: <478D9D60.9070807@talkingspider.com>
References: <478D79BD.7060006@talkingspider.com> <478D8062.3090506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 07:00:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF1KC-0003dP-Tz
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 07:00:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbYAPGAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 01:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbYAPGAE
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 01:00:04 -0500
Received: from relay02.pair.com ([209.68.5.16]:1410 "HELO relay02.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751172AbYAPGAD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 01:00:03 -0500
Received: (qmail 67257 invoked from network); 16 Jan 2008 06:00:01 -0000
Received: from unknown (HELO ?192.168.1.100?) (unknown)
  by unknown with SMTP; 16 Jan 2008 06:00:01 -0000
X-pair-Authenticated: 72.225.213.70
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <478D8062.3090506@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70636>



Dan McGee wrote:
> On 01/15/2008 09:27 PM, Mike wrote:
>> How do I make the repository dir live somewhere else, the hell away from
>> my code? Thanks
> 
> mv .git <location to move to>
> ln -s <location moved to> .git
> 
> Did you try this before you sent your email?

No, good idea. But it didn't work.  When I git commit -a, I get "fatal: 
Not a git repository"

(And also even if that worked, it wouldn't work on an NTFS partiton, 
right...)
