From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [SCRIPT] chomp: trim trailing whitespace
Date: Sat, 27 May 2006 07:32:59 -0400
Message-ID: <447838EB.9060900@garzik.org>
References: <4477B905.9090806@garzik.org> <Pine.LNX.4.61.0605271212210.6670@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 27 13:33:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fjx2f-0005Ji-N7
	for gcvg-git@gmane.org; Sat, 27 May 2006 13:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbWE0LdE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 May 2006 07:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbWE0LdE
	(ORCPT <rfc822;git-outgoing>); Sat, 27 May 2006 07:33:04 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:50157 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751468AbWE0LdB (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 May 2006 07:33:01 -0400
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.99])
	by mail.dvmed.net with esmtpsa (Exim 4.60 #1 (Red Hat Linux))
	id 1Fjx2S-0001ed-IO; Sat, 27 May 2006 11:33:01 +0000
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
In-Reply-To: <Pine.LNX.4.61.0605271212210.6670@yvahk01.tjqt.qr>
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20848>

Jan Engelhardt wrote:
>> Attached to this email is chomp.pl, a Perl script which removes trailing
>> whitespace from several files.  I've had this for years, as trailing whitespace
>> is one of my pet peeves.
>>
>> Now that git-applymbox complains loudly whenever a patch adds trailing
>> whitespace, I figured this script may be useful to others.
>>
> 
> Pretty long script. How about this two-liner? It does not show 'bytes 
> chomped' but it also trims trailing whitespace.
> 
> #!/usr/bin/perl -i -p
> s/[ \t\r\n]+$//

Yes, it does, but a bit too aggressive for what we need :)

	Jeff
