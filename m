From: Ian Hobson <ian@ianhobson.co.uk>
Subject: Re: Strange permission problem - advice needed
Date: Wed, 28 Apr 2010 14:09:54 +0100
Message-ID: <4BD833A2.2060304@ianhobson.co.uk>
References: <4BD8185B.5060706@ianhobson.co.uk> <4BD82A6A.7080502@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Apr 28 15:10:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O771g-0008FI-62
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 15:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754095Ab0D1NJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 09:09:56 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:62271 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751370Ab0D1NJ4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Apr 2010 09:09:56 -0400
Received: from aamtaout04-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20100428130954.OJXZ14666.mtaout01-winn.ispmail.ntl.com@aamtaout04-winn.ispmail.ntl.com>
          for <git@vger.kernel.org>; Wed, 28 Apr 2010 14:09:54 +0100
Received: from jupiter.ianhobson.co.uk ([86.12.69.89])
          by aamtaout04-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20100428130954.YGWR11021.aamtaout04-winn.ispmail.ntl.com@jupiter.ianhobson.co.uk>
          for <git@vger.kernel.org>; Wed, 28 Apr 2010 14:09:54 +0100
Received: (qmail 22417 invoked by uid 453); 28 Apr 2010 13:09:52 -0000
X-Virus-Checked: Checked by ClamAV on ianhobson.co.uk
Received: from bobgriffiths.mars.hcs (HELO [192.168.0.13]) (192.168.0.13)
    by ianhobson.co.uk (qpsmtpd/0.40) with ESMTP; Wed, 28 Apr 2010 14:09:52 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.1.9) Gecko/20100317 Lightning/1.0b1 Thunderbird/3.0.4 ThunderBrowse/3.2.8.1
In-Reply-To: <4BD82A6A.7080502@viscovery.net>
X-Cloudmark-Analysis: v=1.1 cv=ZtHxNT4mZm3rCuM0SmWmgWxeBwJsziC8EqOrwwVkrhA= c=1 sm=0 a=BAbEzbdQzvIA:10 a=8nJEP1OIZ-IA:10 a=8GlCPkqGuturoxpA4WEA:9 a=krEB4LZfGGlzMTxhRfcA:7 a=4szP_HhNh8oK9Yk80SegtL_ngH0A:4 a=wPNLvfGTeEIA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145995>

On 28/04/2010 13:30, Johannes Sixt wrote:
> Am 4/28/2010 13:13, schrieb Ian Hobson:
>    
>> I'm using git on windows (XP) ...
>>      
>    
>> $ git gc
>> Counting objects: 398, done.
>> Compressing objects: 100% (205/205), done.
>> Writing objects: 100% (398/398), done.
>> Total 398 (delta 191), reused 398 (delta 191)
>> rm: cannot unlink `pack-6f07bacdef764f32f12af14877b307d2cb36a1e4.pack':
>> Permission denied
>> rm: cannot unlink `pack-6f07bacdef764f32f12af14877b307d2cb36a1e4.idx':
>> Permission denied
>> rm: cannot unlink `pack-cba55771937a4549af73c09c17b10cfceb1320df.pack':
>> Permission denied
>> rm: cannot unlink `pack-cba55771937a4549af73c09c17b10cfceb1320df.idx':
>> Permission denied
>> Removing duplicate objects: 100% (256/256), done.
>>      
> Chances are that you have a hung git process that has the files open. Kill
> it and retry.
>
> -- Hannes
> --
>    
Thanks Hannes,

Your were completely correct.

All sorted now.
Regards
Ian
