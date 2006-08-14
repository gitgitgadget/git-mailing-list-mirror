From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Compression and dictionaries
Date: Mon, 14 Aug 2006 13:15:55 -0400
Message-ID: <44E0AFCB.10908@garzik.org>
References: <9e4733910608132037t4297c3bbq9b0cd6ebaa03b979@mail.gmail.com> <Pine.LNX.4.63.0608141415560.10541@wbgn013.biozentrum.uni-wuerzburg.de> <9e4733910608140708i45e3d6day6b87676783fd6511@mail.gmail.com> <Pine.LNX.4.63.0608141641330.28360@wbgn013.biozentrum.uni-wuerzburg.de> <9e4733910608140915i728004c1p216bf3d74fcc6ab7@mail.gmail.com> <Pine.LNX.4.63.0608140930380.14796@qynat.qvtvafvgr.pbz> <ebq9tc$3gl$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 14 19:16:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCg2l-0004C4-Jq
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 19:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbWHNRP7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 13:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWHNRP7
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 13:15:59 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:7323 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932487AbWHNRP6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Aug 2006 13:15:58 -0400
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.99])
	by mail.dvmed.net with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1GCg2f-0002QV-5d; Mon, 14 Aug 2006 17:15:57 +0000
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ebq9tc$3gl$1@sea.gmane.org>
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25368>

Jakub Narebski wrote:
> David Lang wrote:
> 
>> the other factor that was mentioned was that a single-bit corruption in the 
>> dictionary would make the entire pack file useless. if this is really a concern 
>> then just store multiple copies of the dictionary. on a pack with lots of files 
>> in it it can still be a significant win.
> 
> Or use some error-correcting code for storing dictionary.

Error-correcting code?  We have sha1 hash to determine validity...

	Jeff
