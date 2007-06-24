From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] transplant: move a series of commits to a different parent
Date: Sun, 24 Jun 2007 08:55:35 +0200
Message-ID: <F2287087-FE29-4858-A273-49BC5A1C2894@zib.de>
References: <1BD13366-B4BD-4630-9046-49567A345CBC@zib.de> <11826268772950-git-send-email-prohaska@zib.de> <Pine.LNX.4.64.0706232151480.4059@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 24 08:54:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2LzU-0005ZD-C0
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 08:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753769AbXFXGyb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 02:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753702AbXFXGyb
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 02:54:31 -0400
Received: from mailer.zib.de ([130.73.108.11]:54334 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752653AbXFXGya (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 02:54:30 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l5O6sSpk004471;
	Sun, 24 Jun 2007 08:54:28 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db104ed.pool.einsundeins.de [77.177.4.237])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l5O6sRHX025302
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 24 Jun 2007 08:54:28 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0706232151480.4059@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50771>


On Jun 23, 2007, at 10:54 PM, Johannes Schindelin wrote:

>> git-transplant.sh <onto> <from> <to>
>>
>> transplant starts with the contents of <onto> and puts on top of
>> it the contents of files if they are touched by the series of
>> commits <from>..<to>.
>
> This reeks of rebase.
>
> IOW, I suspect that it does almost the same as
>
> 	git checkout <to>
> 	git rebase -s ours --onto <onto> <from>^

It doesn't do anything useful for me. In fact it seems as if it
did nothing.

I tried your proposal:
  - rebase says 'Changes from <onto> to <onto>',
  - then it rewinds to <onto>,
  - next it says several time 'Already applied: ...' with increasing
    patch numbers,
  - then 'All done',
  - The result is the same as if I executed 'git reset --hard <onto>'.

I thought about something similar before I wrote transplant.
Honestly, I didn't understand what rebase would do combined with ours.

	Steffen
