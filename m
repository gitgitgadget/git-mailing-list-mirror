From: Christian Jaeger <christian@jaeger.mine.nu>
Subject: Re: retrieving a diff from git
Date: Wed, 15 Oct 2008 12:12:40 +0200
Message-ID: <48F5C218.3080807@jaeger.mine.nu>
References: <20081014145112.GR22427@vanheusden.com> <81b0412b0810141001w46227afam70123237025a2d4d@mail.gmail.com> <20081014172048.GW22427@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Folkert van Heusden <folkert@vanheusden.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 12:20:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq3Ud-0006qs-1n
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 12:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbYJOKT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 06:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbYJOKT1
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 06:19:27 -0400
Received: from ethlife-a.ethz.ch ([129.132.49.178]:36770 "HELO ethlife.ethz.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751096AbYJOKT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 06:19:26 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Oct 2008 06:19:26 EDT
Received: (qmail 1132 invoked from network); 15 Oct 2008 10:12:41 -0000
Received: from unknown (HELO elvis-jaeger.mine.nu) (127.0.0.1)
  by localhost with SMTP; 15 Oct 2008 10:12:41 -0000
Received: (qmail 22420 invoked from network); 15 Oct 2008 10:12:41 -0000
Received: from unknown (HELO ?127.0.0.1?) (10.0.5.1)
  by elvis-jaeger.mine.nu with SMTP; 15 Oct 2008 10:12:41 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <20081014172048.GW22427@vanheusden.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98263>

Folkert van Heusden wrote:
>> Well, you can of course just click on "commitdiff" (and "raw" afterwords)
>> for every commit,
>>     
>
> Hmmm the outcome does not apply cleanly to 2.6.27.
>
>   
>> but ... Have you considered using Git for that?
>>     
>
> and check out the whole tree using Git? I did consider but then I would
> not have all bells and whistles to generate a Debian kernel package.
>   

I'm tempted to think that you should move (merge / cherry-pick or 
rebase) the relevant changes onto 2.6.27 using Git, and then take the 
diff from there (on the theory that Git could reduce the number of 
conflicts that you would have to resolve manually, although I'm not sure 
how much this is the case); the resulting diff will then apply cleanly 
to a 2.6.27 tarball without using Git.

Christian.
