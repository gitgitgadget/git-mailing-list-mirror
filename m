From: Christoph Duelli <duelli@melosgmbh.de>
Subject: Re: git mv + git pull issue
Date: Mon, 09 Jun 2008 10:45:12 +0200
Message-ID: <484CED98.3070506@melosgmbh.de>
References: <4848EDDF.7090906@melosgmbh.de> <alpine.DEB.1.00.0806061639390.1783@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 09 10:59:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5dDz-0004ow-Gh
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 10:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757338AbYFII6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 04:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757324AbYFII6m
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 04:58:42 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:33788 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757137AbYFII6h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 04:58:37 -0400
X-Greylist: delayed 693 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Jun 2008 04:58:37 EDT
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: hvKqOO6Ph79JHUJJIwMxXgzUdNi1LqfccsoS0yxp1bU6IJpbRdTLsu3mhpkbx1Gw0AnIAdA=
Received: from mail.melosgmbh.de
	(p5B07A8B4.dip0.t-ipconnect.de [91.7.168.180])
	by post.webmailer.de (mrclete mo27) (RZmta 16.42)
	with ESMTP id k03f7ek597dhTN ; Mon, 9 Jun 2008 10:47:02 +0200 (MEST)
	(envelope-from: <duelli@melosgmbh.de>)
X-Spam-Status: No, hits=0.0 required=4.0
	tests=AWL: 0.033,BAYES_00: -1.665,TOTAL_SCORE: -1.632
X-Spam-Level: 
Received: from [172.27.1.229] ([172.27.1.229])
	(authenticated user duelli@melosgmbh.de)
	by mail.melosgmbh.de (Kerio MailServer 6.4.1 patch 1);
	Mon, 9 Jun 2008 10:47:02 +0200
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <alpine.DEB.1.00.0806061639390.1783@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84372>

Johannes Schindelin schrieb:
> Hi,
> 
> On Fri, 6 Jun 2008, Christoph Duelli wrote:
> 
>> cd ../gitmv
>> git mv afile newname
>> # do not commit
>> # now: afile is not in the directory anymore
>> # oh, I need those changes my colleague made...
>> git pull ../gitmv-clone/
>> # now: both(!) afile and newname are in the directory
> 
> What is so surprising there?  We _always_ recommend to commit before 
> pulling.
Well, when I modify a file, and pull afterwards: my 'modification' is 
never lost (the pull might fail, though).
If we consider the removal of a file as a kind of modification, one 
would expect a similar behaviour.

I do agree that this is not (nec.) a bug, still I thought it worthwhile 
to bring the matter up.
In our repository we get duplicates now and then because of it.

Regards
-- 
Christoph Duelli
