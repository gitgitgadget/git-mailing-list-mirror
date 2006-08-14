From: David Lang <dlang@digitalinsight.com>
Subject: Re: Compression and dictionaries
Date: Mon, 14 Aug 2006 10:34:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608141033080.14796@qynat.qvtvafvgr.pbz>
References: <9e4733910608132037t4297c3bbq9b0cd6ebaa03b979@mail.gmail.com> 
 <Pine.LNX.4.63.0608141415560.10541@wbgn013.biozentrum.uni-wuerzburg.de> 
 <9e4733910608140708i45e3d6day6b87676783fd6511@mail.gmail.com> 
 <Pine.LNX.4.63.0608141641330.28360@wbgn013.biozentrum.uni-wuerzburg.de> 
 <9e4733910608140915i728004c1p216bf3d74fcc6ab7@mail.gmail.com> 
 <Pine.LNX.4.63.0608140930380.14796@qynat.qvtvafvgr.pbz>  <ebq9tc$3gl$1@sea.gmane.org>
 <44E0AFCB.10908@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 14 19:35:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCgLP-0001TA-IV
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 19:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWHNRfP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 13:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbWHNRfP
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 13:35:15 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:6334 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932122AbWHNRfN
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 13:35:13 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Mon, 14 Aug 2006 10:35:13 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Mon, 14 Aug 2006 10:35:03 -0700
X-X-Sender: dlang@dlang.diginsite.com
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <44E0AFCB.10908@garzik.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25369>

On Mon, 14 Aug 2006, Jeff Garzik wrote:

> Date: Mon, 14 Aug 2006 13:15:55 -0400
> From: Jeff Garzik <jeff@garzik.org>
> To: Jakub Narebski <jnareb@gmail.com>
> Cc: git@vger.kernel.org
> Subject: Re: Compression and dictionaries
> 
> Jakub Narebski wrote:
>> David Lang wrote:
>> 
>>> the other factor that was mentioned was that a single-bit corruption in 
>>> the dictionary would make the entire pack file useless. if this is really 
>>> a concern then just store multiple copies of the dictionary. on a pack 
>>> with lots of files in it it can still be a significant win.
>> 
>> Or use some error-correcting code for storing dictionary.
>
> Error-correcting code?  We have sha1 hash to determine validity...

that would only tell you that what you have is garbage (and you need to restore 
from backup(, useing a ECC costs some space, but lets you recover from some 
errors without having to resort to backups.

David Lang
