From: Abdelrazak Younes <younes@lyx.org>
Subject: Re: [QGIT PATCH/RFC]
Date: Thu, 05 Nov 2009 10:50:42 +0100
Organization: LyX
Message-ID: <4AF29FF2.1010000@lyx.org>
References: <4AF19630.2070402@lyx.org> <e5bfff550911050141t751d45a0r4e340fa0d10af366@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 10:50:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5yzV-0003Fe-73
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 10:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbZKEJum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 04:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750848AbZKEJum
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 04:50:42 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:40197 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbZKEJul (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 04:50:41 -0500
Received: by ewy3 with SMTP id 3so4051498ewy.37
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 01:50:45 -0800 (PST)
Received: by 10.213.23.201 with SMTP id s9mr3097867ebb.72.1257414644998;
        Thu, 05 Nov 2009 01:50:44 -0800 (PST)
Received: from ?192.168.4.216? ([62.161.104.182])
        by mx.google.com with ESMTPS id 5sm5819214eyh.2.2009.11.05.01.50.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Nov 2009 01:50:43 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <e5bfff550911050141t751d45a0r4e340fa0d10af366@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132219>

Marco Costalba wrote:
> Hi Abdel,
>
> On Wed, Nov 4, 2009 at 15:56, Abdelrazak Younes <younes@lyx.org> wrote:
>   
>> Hello Marco,
>>
>> While recompiling latest qgit4, I stumbled accross this. I am not quite sure
>> you used a QLatin1String instead of a QByteArray but the attached seems to
>> work fine...
>>
>>     
>
> Unfortunatly I cannot say the same here ;-)
>
>
>   
>> -class ShaString;
>> +typedef QByteArray ShaString;
>>     
>
> ...... cut ......
>
>   
>>  uint qHash(const ShaString& s) { // fast path, called 6-7 times per
>> revision
>>
>>     
>
> Function:
>
> uint qHash(const QByteArray&);
>
> is already defined in the Qt Core libraries, so I have a link error
> with your patch.
>   

Weird... it links just fine here... anyway this can be solved by 
renaming your version. Or just using the Qt version if that does the 
same thing ;-)

> BTW I don't think I have understood the reason of your patch. Do you
> have a compile error or something ?
>   

No, I had some warnings so I looked at the code and I just thought that 
QLatin1String was not appropriate here and overkill. And QByteArray 
should be faster...

Anyway, this was just FYI, I don't think this patch is important at all :-)

Abdel.
