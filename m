From: Steven Cole <elenstev@mesatop.com>
Subject: Re: I'm missing isofs.h
Date: Wed, 27 Apr 2005 11:40:50 -0600
Message-ID: <426FCEA2.5000708@mesatop.com>
References: <20050426214338.32e9ac27.akpm@osdl.org> <426FB03B.9090509@mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andrew Morton <akpm@osdl.org>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 19:40:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQqVL-0002uu-Vj
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 19:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVD0Rn4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 13:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbVD0RnU
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 13:43:20 -0400
Received: from mailwasher.lanl.gov ([192.65.95.54]:40099 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S261841AbVD0RlA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 13:41:00 -0400
Received: from w-mail.lanl.gov (w-mail.lanl.gov [128.165.4.47])
	by mailwasher-b.lanl.gov (8.12.11/8.12.11/(ccn-5)) with ESMTP id j3RHetp6025034
	for <git@vger.kernel.org>; Wed, 27 Apr 2005 11:40:55 -0600
Received: from [128.165.67.197] (spc7.esa.lanl.gov [128.165.67.197])
	by w-mail.lanl.gov (8.12.11/8.12.11/(ccn-5)) with ESMTP id j3RHeoIg024223;
	Wed, 27 Apr 2005 11:40:51 -0600
User-Agent: Thunderbird 1.0 (Multics)
X-Accept-Language: en-us, en
To: Steven Cole <elenstev@mesatop.com>
In-Reply-To: <426FB03B.9090509@mesatop.com>
X-PMX-Version: 4.7.0.111621
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Steven Cole wrote:
> Andrew Morton wrote:
> 
>> In a current tree, using git-pasky-0.7:
>>
>> bix:/usr/src/git26> cat .git/tags/v2.6.12-rc3 
>> a2755a80f40e5794ddc20e00f781af9d6320fafb
>> bix:/usr/src/git26> git diff -r v2.6.12-rc3|grep isofs.h
>> +#include "isofs.h"
>>  #include "zisofs.h"
>> +#include "isofs.h"
>> +#include "isofs.h"
>> +#include "isofs.h"
>>  #include "zisofs.h"
>> +#include "isofs.h"
>> +#include "isofs.h"
>> +#include "isofs.h"
>> +#include "isofs.h"
>>
>>
>> That diff should have included the addition of the new isofs.h, but it
>> isn't there.
>>
> 
> I'm seeing unexplained behaviour using the above technique, and I'm
> also seeing fs/isofs/isofs.h as missing, along with seven other changes.
> 

Jan Harkes has found the problem to be a missing ':' at the end of the tag.

Steven
