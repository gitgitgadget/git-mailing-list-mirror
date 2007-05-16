From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Losing branches (whee, data loss)
Date: Wed, 16 May 2007 01:54:35 -0400
Message-ID: <464A9C9B.70904@garzik.org>
References: <464A940C.3080906@garzik.org> <8c5c35580705152248w254e4201w65da1e1ad229f6ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 16 07:54:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoCTC-00044M-U2
	for gcvg-git@gmane.org; Wed, 16 May 2007 07:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755221AbXEPFyi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 01:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757804AbXEPFyi
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 01:54:38 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:53711 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755221AbXEPFyh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 01:54:37 -0400
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HoCT6-0006Ea-6w; Wed, 16 May 2007 05:54:36 +0000
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
In-Reply-To: <8c5c35580705152248w254e4201w65da1e1ad229f6ee@mail.gmail.com>
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.8 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47413>

Lars Hjemli wrote:
> On 5/16/07, Jeff Garzik <jeff@garzik.org> wrote:
>> [jgarzik@pretzel libata-dev]$ git branch -m upstream-fixes tmp
>> error: Could not open config file!
>> fatal: Branch rename failed
> 
> This should have been fixed in v1.5.1.1, what version do you run?

[jgarzik@core ~]$ rpm -q git-core
git-core-1.5.0.6-1.fc6


>> [jgarzik@pretzel libata-dev]$ git-branch -m upstream-fixes tmp
>> fatal: A branch named 'tmp' already exists.
>>
>> [jgarzik@pretzel libata-dev]$ git branch -D tmp
>> Deleted branch tmp.
> 
> Could you try to run "git log -g" and see if it finds your lost branch?

Doesn't seem to..

Thanks,

	Jeff
