From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [PATCHv2 GSoC] gitweb: Move static files into seperate subdirectory
Date: Mon, 10 May 2010 18:31:44 +0530
Message-ID: <4BE803B8.4090607@gmail.com>
References: <p2ze72faaa81005090656j593c3464v9ee1bb6432461efc@mail.gmail.com> <m3bpcoenci.fsf@localhost.localdomain> <AANLkTim2rIFDBRChBxTiWZCNmd8ozwKQzM3RZOEr3mgp@mail.gmail.com> <201005101455.50633.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 15:02:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBScb-0001zZ-Ee
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 15:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992Ab0EJNCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 09:02:04 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:50437 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011Ab0EJNCB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 09:02:01 -0400
Received: by pvh11 with SMTP id 11so119451pvh.19
        for <git@vger.kernel.org>; Mon, 10 May 2010 06:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=cH3eejcFkY+Y/q5wcVEfUMDMlmls+sgNJ/31ZM3+ZkI=;
        b=YYTq9cPIRET/BVR+a1qlHWLGuvur3FO33ADrTMqELPcCVXtuYFm9xKj/oiJEPm+zHm
         YQBAE8Kgrlw5a5Ao2FGuxBZyXhgpUOmn2PIKqPZUFMPVJEe5L3Edzxxg1Cgi4UeqAnr8
         LBqGW62fuuSb9kBi91ymj/6uOSRIHLfx2P7rk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=fW42jb/eK4TQYBp+v4oTCjjiGdkRIjbIJOqUS5OAznAgvuRKc2VtVEvQEH5mbjP0pP
         ifBYhvpk9GoZBJFX/HrpTatO0if2M208QIfzALE2+mZeyjr8JlLWmJ6autF8uluG7UCv
         RGPXomiTnqcssR80yxnlOYhLq6mVJzzI7ZW+E=
Received: by 10.114.253.4 with SMTP id a4mr3092525wai.132.1273496520101;
        Mon, 10 May 2010 06:02:00 -0700 (PDT)
Received: from [172.16.19.166] ([202.63.112.23])
        by mx.google.com with ESMTPS id c14sm25783370waa.1.2010.05.10.06.01.55
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 06:01:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <201005101455.50633.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146809>

On Monday 10 May 2010 06:25 PM, Jakub Narebski wrote:
> Only minor comments about submission itself.  Patch I think is now
> all right with added required changes to main Makefile.
>
>
> On Mon, 10 May 2010, Pavan Kumar Sunkara wrote:
>
>    
>> Gitweb: Move static files into seperate subdirectory
>>      
> This should be the subject of an email, like now is (only without
> "Re:"), and this line should be missing from email body.
>
> Or you need to use
>
>    Subject: gitweb: Move static files into seperate subdirectory
>
> It is customary to start subsystem prefix with lowercase.
>
>    
>> Create a new subdirectory called 'static' in gitweb/, and move
>> all static files required by gitweb.cgi when running, which means
>> styles, images and Javascript code. This should make gitweb more
>> readable and easier to maintain.
>>
>> Update t/gitweb-lib.sh to reflect this change.  The default is
>> now to install static files also in 'static' subdirectory in target
>> directory: update Makefile, gitweb's INSTALL, README and Makefile
>>
>> Signed-off-by: Pavan Kumar Sunkara<pavan.sss1991@gmail.com>
>> ---
>>      
> The comments about patch itself should be put *here*, between "---\n"
> and diffstat.
>
>    
>> This is the new patch which includes the changes suggested by Jakub.
>>
>> Regarding wordwrap, all the mailing ports in my university are closed
>> which leaves me only the gmail web cient which don't have any option
>> to disable wordwrap. I will try to find a workaround for this. Please
>> bear with my wordwrap until then.
>>
>> Thanks
>> -Pavan
>>      
>
> Like this.
>
>    
>>   Makefile                            |   20 ++++++++++----------
>>   gitweb/INSTALL                      |   20 ++++++++++----------
>>   gitweb/Makefile                     |   20 ++++++++++----------
>>   gitweb/README                       |   13 +++++++------
>>   gitweb/{ =>  static}/git-favicon.png |  Bin 115 ->  115 bytes
>>   gitweb/{ =>  static}/git-logo.png    |  Bin 207 ->  207 bytes
>>   gitweb/{ =>  static}/gitweb.css      |    0
>>   gitweb/{ =>  static}/gitweb.js       |    0
>>   t/gitweb-lib.sh                     |    6 +++---
>>   9 files changed, 40 insertions(+), 39 deletions(-)
>>   rename gitweb/{ =>  static}/git-favicon.png (100%)
>>   rename gitweb/{ =>  static}/git-logo.png (100%)
>>   rename gitweb/{ =>  static}/gitweb.css (100%)
>>   rename gitweb/{ =>  static}/gitweb.js (100%)
>>      
> [...]
>    

Ok. I will follow this format from next time onwards.

And thanks to ramkumar I found a solution to use email clients on ports.

I would like to know when this patch will be merged.

Thanks
- Pavan
