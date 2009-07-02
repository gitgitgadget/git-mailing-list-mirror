From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Documentation: update description of shell aliases
Date: Thu, 02 Jul 2009 09:21:31 +0200
Message-ID: <4A4C5FFB.90302@op5.se>
References: <2e24e5b90907010900r23ddc8dfl67dee569b508a4b7@mail.gmail.com>	 <7v7hysl0x8.fsf@alter.siamese.dyndns.org> <2e24e5b90907011757r498b8c52v4cf5dfb7016bf8b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 09:21:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMGc3-0005Rv-HF
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 09:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752454AbZGBHVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 03:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbZGBHVc
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 03:21:32 -0400
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:46458 "HELO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750849AbZGBHVc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jul 2009 03:21:32 -0400
Received: from source ([209.85.219.210]) by na3sys009aob113.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSkxf/uerJ+4UMKtQqiOfQX8Ha9VFMnUF@postini.com; Thu, 02 Jul 2009 00:21:36 PDT
Received: by mail-ew0-f210.google.com with SMTP id 6so1855729ewy.33
        for <git@vger.kernel.org>; Thu, 02 Jul 2009 00:21:34 -0700 (PDT)
Received: by 10.210.78.16 with SMTP id a16mr4984057ebb.66.1246519294126;
        Thu, 02 Jul 2009 00:21:34 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 5sm4459541eyf.12.2009.07.02.00.21.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Jul 2009 00:21:33 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <2e24e5b90907011757r498b8c52v4cf5dfb7016bf8b5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122626>

Sitaram Chamarty wrote:
> On Wed, Jul 1, 2009 at 11:51 PM, Junio C Hamano<gitster@pobox.com> wrote:
>> Sitaram Chamarty <sitaramc@gmail.com> writes:
>>
>>> Aliases that invoke shell commands start from the top-level directory,
>>> but this was not documented.
>> Could you please also think if it is worth mentioning what happens when
>> you do not even have a top-level directory?  I.e. in a bare repository.
> 
> Yes I thought about it.  I decided not to add that because
> it is:
> 
>   - not common enough (how many new users fiddle in bare
>     repos?)
> 

I do that quite a lot, but I can't recall ever using an alias
in a bare repo. It would be odd if I did, as the only alias I've
got is this:

   alias.wsfix=!git diff HEAD >P.diff && git reset --hard HEAD && git apply --whitespace=fix P.diff && rm -f P.diff

which isn't always doing the right thing even in a non-bare
repository, and never in a bare one.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
