From: Tom Koelman <tkoelman@xs4all.nl>
Subject: Re: Checkout fails when one branch contains a directory with the
 name of a file in the other branch
Date: Mon, 07 May 2007 13:32:46 +0200
Message-ID: <463F0E5E.6000204@xs4all.nl>
References: <ubqgw51tf.fsf@assurancetourix.xs4all.nl> <Pine.LNX.4.64.0705071329170.4167@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 07 13:32:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl1SX-0002ZA-G4
	for gcvg-git@gmane.org; Mon, 07 May 2007 13:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933223AbXEGLcu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 07:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933235AbXEGLcu
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 07:32:50 -0400
Received: from smtp-vbr13.xs4all.nl ([194.109.24.33]:2680 "EHLO
	smtp-vbr13.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933223AbXEGLcu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 07:32:50 -0400
Received: from [10.48.12.82] (stugw.infor.com [194.99.90.2])
	(authenticated bits=0)
	by smtp-vbr13.xs4all.nl (8.13.8/8.13.8) with ESMTP id l47BWlHW072489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 7 May 2007 13:32:47 +0200 (CEST)
	(envelope-from tkoelman@xs4all.nl)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <Pine.LNX.4.64.0705071329170.4167@racer.site>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46449>

Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 7 May 2007, Tom Koelman wrote:
> 
>> I am not sure whether this is intentional or not. I am wondering why
>> this scenario fails, and if it is by design, how I should handle this
>> situation:
>>
>> [...]
>>
>> $ git checkout master
>> fatal: Untracked working tree file 'aFile' would be overwritten by merge.
> 
> I tried to reproduce this behaviour, but it worked here. What Git version 
> do you use? Mine says "git version 1.5.2.rc2.2435.ge5a9b".
> 
> Hth,
> Dscho

I tried 1.5.1.3 under cygwin and 1.5.0.6 under Linux FC5.

Regards,
Tom Koelman
