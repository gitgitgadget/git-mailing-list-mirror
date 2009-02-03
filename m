From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] t3411: Fix test 1 for case-insensitive file systems
Date: Tue, 3 Feb 2009 12:11:01 -0500
Message-ID: <2D4586A6-ADAC-4B6E-8B42-2CBD76E0304C@silverinsanity.com>
References: <1233244816-67565-1-git-send-email-benji@silverinsanity.com> <7vocxqf2sf.fsf@gitster.siamese.dyndns.org> <673CE949-5DF9-4970-A739-AA09FCD26D24@silverinsanity.com> <1E104E1B-BFCC-4CFC-9D53-CE89299C9600@silverinsanity.com> <alpine.DEB.1.00.0902031752230.6573@intel-tinevez-2-302>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 03 18:12:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUOp6-0006GD-OY
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 18:12:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754347AbZBCRLH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 12:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754168AbZBCRLG
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 12:11:06 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:50451 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965AbZBCRLE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 12:11:04 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id E698F1FFC27F; Tue,  3 Feb 2009 17:10:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=4.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.7-deb3
Received: from [192.168.5.44] (nmd.sbx07360.rocheny.wayport.net [98.98.50.102])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 514EB1FFC271;
	Tue,  3 Feb 2009 17:10:58 +0000 (UTC)
In-Reply-To: <alpine.DEB.1.00.0902031752230.6573@intel-tinevez-2-302>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108219>


On Feb 3, 2009, at 11:53 AM, Johannes Schindelin wrote:

> On Tue, 3 Feb 2009, Brian Gernhardt wrote:
>
>> This change appears to have been forgotten, but does fix the  
>> problems I
>> was having.  Junio, can this make it into the official repo instead  
>> of
>> floating around in my local?  I'd send in a patch, but it was your  
>> code
>> and I don't want to take credit for it.
>
> Top-poster!

Well, yes.  I wasn't replying to anything in the e-mail, I just wanted  
to bring it back to attention.

> Besides, I think that my latest comment still stands there: testing  
> is not
> good enough, code inspection is required if something expects the file
> names as they used to be.

As far as I can tell, no test relies on the auto-generated name of the  
test file.  In fact, only t3411 uses that feature at all and it only  
performs operations on commits.  All other uses of test_commit give a  
filename (even though many of them don't appear to use the file).

~~ Brian
