From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH] de.po: Fixup one translation
Date: Tue, 23 Sep 2014 10:43:23 +0200
Message-ID: <542132AB.9030305@gmail.com>
References: <1411457847-10419-1-git-send-email-stefanbeller@gmail.com> <CAPig+cTFW7gEEezkEbRTu-N88Er26OEm6FE47M8c1XSh8Q_a7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: ralf.thielow@googlemail.com, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 11:11:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWLh3-0002Tx-Sa
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 10:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753411AbaIWInZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 04:43:25 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:43410 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533AbaIWInX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 04:43:23 -0400
Received: by mail-wi0-f172.google.com with SMTP id em10so4371462wid.11
        for <git@vger.kernel.org>; Tue, 23 Sep 2014 01:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ZxRbosPFB5D+E38cV0E/lzwTj9Lcl5HI52cBCjOFz9M=;
        b=TKI0tIUPJhws21qfZV4WALZ72rNXuZ7A+MNHRF599+mXxtyibaaWLuGw/h5Bq5lHP9
         VlDcVc4JBt7cTAu8DUjyV3B+IDRGQTAkSNflK7GvagTn+brHL/cGoeYvG65qcITfRFUz
         z4qZQpc2fDCp6Jm4KKtts1+Niq+XP47Ar933jLVhLUq2tEzi/AkkFW0tt87g63is49uN
         cB0/4h3nOPsvrVyO5gIiH4Kim9CugzgtQ7W7Fc7uM0Kgs00Dlju9Q/VWqHEnJQMLYrcx
         Eej55WrBRefi853lLHEvsLnm21DmMa0R2purvQA26Ocoqwo6fkjvk7v6UBV7EPnOpRWB
         NGeQ==
X-Received: by 10.181.13.105 with SMTP id ex9mr21259996wid.58.1411461802518;
        Tue, 23 Sep 2014 01:43:22 -0700 (PDT)
Received: from [192.168.1.7] (p5B095AC8.dip0.t-ipconnect.de. [91.9.90.200])
        by mx.google.com with ESMTPSA id q5sm15030359wja.49.2014.09.23.01.43.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Sep 2014 01:43:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <CAPig+cTFW7gEEezkEbRTu-N88Er26OEm6FE47M8c1XSh8Q_a7g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257407>

On 23.09.2014 10:06, Eric Sunshine wrote:
> On Tue, Sep 23, 2014 at 3:37 AM, Stefan Beller <stefanbeller@gmail.com> wrote:
>> English grammar with German words doesn't make it a German translation. ;)
>> We also need to fix the
> 
> Sentence fragment.

Yeah, originally I intended to just fix the singular form and let the
plural form slip. But then I did both singular and plural form and
forgot about the already started commit message.

Anyways I'd assume Ralf will incorporate this patch in a larger patch
for the German translation, so the commit message for this particular
patch is of minor relevance.

Thanks,
Stefan

> 
>> Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
>> ---
>>  po/de.po | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/po/de.po b/po/de.po
>> index e5d2b25..bae3723 100644
>> --- a/po/de.po
>> +++ b/po/de.po
>> @@ -3463,13 +3463,13 @@ msgid_plural ""
>>  "\n"
>>  "%s\n"
>>  msgstr[0] ""
>> -"Warnung: Sie sind um %d Commit hinterher, nicht verbunden zu\n"
>> -"einem Ihrer Branches:\n"
>> +"Warnung: Sie sind um %d Commit hinterher, folgende Commits sind in\n"
>> +"keinem Ihrer Branches enthalten: \n"
>>  "\n"
>>  "%s\n"
>>  msgstr[1] ""
>> -"Warnung: Sie sind um %d Commits hinterher, nicht verbunden zu\n"
>> -"einem Ihrer Branches:\n"
>> +"Warnung: Sie sind um %d Commits hinterher, folgende Commits sind in\n"
>> +"keinem Ihrer Branches enthalten: \n"
>>  "\n"
>>  "%s\n"
>>
>> --
>> 2.1.0.238.gce1d3a9
