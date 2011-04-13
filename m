From: Joshua Juran <jjuran@gmail.com>
Subject: Re: Gitbox
Date: Wed, 13 Apr 2011 12:24:11 -0700
Message-ID: <5F5479DB-511E-4ADC-8B71-5D7C801ECEAF@gmail.com>
References: <A2315DA1-780C-4024-B774-9AD5F9AA0DB6@medialab.com> <1302721187.21900.4.camel@drew-northup.unet.maine.edu> <1E5D7DCE-B3B3-4CC7-8F40-4ED48E76907D@gmail.com> <1302722214.22161.5.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Daniel Searles <dsearles@medialab.com>, git@vger.kernel.org,
	oleganza@gmail.com
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Wed Apr 13 21:24:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA5fo-0002vc-C8
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 21:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757757Ab1DMTYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 15:24:16 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61153 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757408Ab1DMTYP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 15:24:15 -0400
Received: by iyb14 with SMTP id 14so822400iyb.19
        for <git@vger.kernel.org>; Wed, 13 Apr 2011 12:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        bh=L5iBfZYAwpYKKrHIY6BMRE15OS76BtDfCewAxiZlFuA=;
        b=Ug2Nu5HriwQ95zMfZCZoj/x8QSF99PT6BLh5Qq8rwJnPn87CbfNMvLgOTJ4XRCN4yr
         8VM+82GAfDuLCo8xoE6KBrjxkBMw9J9hXciJntcdIQG7XBWpYjjPAnxlH4uy2KqPH0bW
         H4WEFGGoFTwUxMgyYS1bPBRhdr5IuAx3I7vrY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=uE7TiYgTFEq/v8Z5qH2jepkeqQyqoUwz5KkxrFwc0YX5Z8ZHDSRIhAHhZ7Gudt1KJw
         bP4ecpj3rz8/STltuSbzjLyChT4oILU05TpwVdapIfkYEiV8A1cWdAGDElt3iDE4vxYG
         tVuFW7Cc9Qn15eW614gXG62zuqWYS5lfYAOrM=
Received: by 10.42.147.3 with SMTP id l3mr13019558icv.353.1302722654678;
        Wed, 13 Apr 2011 12:24:14 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id 19sm621204ibx.18.2011.04.13.12.24.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Apr 2011 12:24:13 -0700 (PDT)
In-Reply-To: <1302722214.22161.5.camel@drew-northup.unet.maine.edu>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171477>

On Apr 13, 2011, at 12:16 PM, Drew Northup wrote:

> On Wed, 2011-04-13 at 12:09 -0700, Joshua Juran wrote:
>
>> On Apr 13, 2011, at 11:59 AM, Drew Northup wrote:
>>
>>> On Wed, 2011-04-13 at 11:16 -0700, Daniel Searles wrote:
>>
>>>
>>>> I'm curious if Gitbox is in violation of the Git's GPL.
>>>> http://www.gitboxapp.com/
>>>
>>> Well, it appears that he may have implemented "git" on his own, or  
>>> at
>>> the very least he's trying to imply that he did.
>>>
>>> http://www.gitboxapp.com/faq.html#gpl
>>
>> He very clearly says that he ships Git, not a reimplementation.
>
> He also clearly stated that he's not calling git command-line tools...

I wonder why he would ship them, then.

> "Gitbox neither links (statically or dynamically) against Git nor uses
> custom interfaces to interact with it. Git binaries are provided for
> your convenience only."

Calling execve() is not dynamic linking, that I'm aware of.

> I'm hoping he'll have a more complete statement for all of us.

I think you've misinterpreted his words, but I agree that a  
clarification to set minds at ease would be appropriate.

Josh
