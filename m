From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] Use a 16-tree instead of a 256-tree for storing notes
Date: Wed, 26 Aug 2009 15:27:22 +0200
Message-ID: <4A95383A.4080104@op5.se>
References: <1248834326-31488-1-git-send-email-johan@herland.net>	 <200908261231.01616.johan@herland.net>	 <81b0412b0908260505m233d9a5cmefdd81e1ef51a299@mail.gmail.com>	 <200908261456.55906.johan@herland.net> <81b0412b0908260624v30d32cc1m96e798076b51cbc9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com, trast@student.ethz.ch,
	tavestbo@trolltech.com, git@drmicha.warpmail.net,
	chriscool@tuxfamily.org, spearce@spearce.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 15:27:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgIXK-0006Iv-4z
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 15:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757168AbZHZN13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 09:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757053AbZHZN13
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 09:27:29 -0400
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:55780 "HELO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756368AbZHZN12 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Aug 2009 09:27:28 -0400
Received: from source ([209.85.219.215]) by na3sys009aob102.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSpU4QVESslwi53EpI6Ty6FMyeUb9RxGv@postini.com; Wed, 26 Aug 2009 06:27:31 PDT
Received: by mail-ew0-f215.google.com with SMTP id 11so148381ewy.11
        for <git@vger.kernel.org>; Wed, 26 Aug 2009 06:27:29 -0700 (PDT)
Received: by 10.216.85.195 with SMTP id u45mr1529054wee.14.1251293249398;
        Wed, 26 Aug 2009 06:27:29 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 10sm1747977eyd.0.2009.08.26.06.27.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 Aug 2009 06:27:25 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <81b0412b0908260624v30d32cc1m96e798076b51cbc9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127096>

Alex Riesen wrote:
> On Wed, Aug 26, 2009 at 14:56, Johan Herland<johan@herland.net> wrote:
>> On Wednesday 26 August 2009, Alex Riesen wrote:
>>> On Wed, Aug 26, 2009 at 12:31, Johan Herland<johan@herland.net> wrote:
>>>> The 256-tree structure is considerably faster than storing all
>>>> entries in a
>>> This part is confusing. Was 256-tree better (as in "faster") then?
>> 256-tree is faster than the everything-in-hash_map draft.
>> 16-tree is slightly faster than 256-tree
>>
>> 256-tree uses more memory (in the worst case) that the
>> everything-in-hash-map draft.
>> 16-tree uses less memory than both.
>>
>> Makes sense?
> 
> Oh, it does, it is just confusingly presented. How about:
> 
> The 16-tree is both faster and has lower footprint then 256-tree
> code, which in its turn is noticably faster and smaller then existing
> hash_map implementation. ...

If it's to be squashed in, why mention the 256-tree at all (except
for possibly as something to compare with at the end)?
If it goes on top, why mention the hash_map at all?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
