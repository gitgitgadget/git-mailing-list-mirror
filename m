From: Wolfgang Fischer <wf@wf227.com>
Subject: Re: t9200 still failing...
Date: Sat, 3 Feb 2007 17:17:50 +0100
Message-ID: <13848C22-6C0B-46F0-ABC5-1A94D0DB6B06@wf227.com>
References: <DBACB5AE-7C40-4D44-85BB-76F30BE96E36@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Sat Feb 03 17:18:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDNam-00062V-P4
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 17:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946484AbXBCQRx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 11:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946486AbXBCQRx
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 11:17:53 -0500
Received: from mail.wf227.com ([217.9.110.226]:33237 "EHLO mail.wf227.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946484AbXBCQRw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 11:17:52 -0500
Received: from [192.168.1.2] (ppp-82-135-8-101.dynamic.mnet-online.de [82.135.8.101])
	by mail.wf227.com (Postfix) with ESMTP id 41313BB450;
	Sat,  3 Feb 2007 16:17:51 +0000 (UTC)
In-Reply-To: <DBACB5AE-7C40-4D44-85BB-76F30BE96E36@silverinsanity.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38571>

On 03.02.2007, at 16:56, Brian Gernhardt wrote:
> What I don't understand is that there are no .gitignore files in  
> the test repo and the .git/info/exclude file only has comments.   
> This seems like it might actually be a subtle bug in git-add,  
> although I'm betting it's more OS X filesystem oddness.  I'm trying  
> to look into it, but thought that maybe someone with more  
> experience with the code might catch it first.

That was already discussed a lot. Any filename test on OSX with a HFS 
+ filesystem containing characters with a different UTF-8-NFC and  
UTF-8-NFD will make such a test fail. If you are using OSX, you might  
want to use UnicodeChecker to see the encoding difference for such  
characters. If you want to make such tests pass, either use  
characters with only one UTF-8 encoding or use a UFS partition to run  
such tests.

	Wolfgang
