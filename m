From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: Newbie / git / gitosis question
Date: Wed, 26 Aug 2009 10:46:46 +0100
Message-ID: <26ae428a0908260246p71f16b19y5e9d9d6ed63b61b4@mail.gmail.com>
References: <26ae428a0908260227k7ac6aeden9a4eae7ee95d4d45@mail.gmail.com>
	 <d2e97e800908260238p28bd6d27o6377f395df32b03c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Wookey <michaelwookey@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 11:47:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgF62-0001Tr-Rh
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 11:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756659AbZHZJqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 05:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756607AbZHZJqq
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 05:46:46 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:54321 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756551AbZHZJqp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 05:46:45 -0400
Received: by ewy2 with SMTP id 2so1218036ewy.17
        for <git@vger.kernel.org>; Wed, 26 Aug 2009 02:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=h8/KMrDChDJuBUWx4AnxSob7kG6piTNXXQlyEGT1mho=;
        b=vwMQgOCX7O/7jWANrFKocTnJIy79hP6e/PsiShGbGSXIQCgWY5J+XLll7tQHQhUaE4
         0lIwqlZtm2r2lEslKgcxrQKFwp2MD/6+PJ1J/U4GLDV88u/ighY3Fr6FpYpN23CusjJ4
         fucCfw+W3gY5A/ZTvzb72cClRiPeYe4prSEPk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=Lwni7E/4Pdq6CXoRTjT9ehcJ/wXOWbBgmWtFIgdrcgXEZqVvQf5RmzX0WMXOJRh52/
         wLznhwNpDw0xtC3EuBHq1BLKCb6qU9LmgDKmKnsGNq5aUT7hhUzX6osvrH8o5t71bo4u
         PHJeoku6pQutjFSFxjPlyzRfzJqEX5Kq40Oy4=
Received: by 10.216.28.193 with SMTP id g43mr1528032wea.192.1251280006309; 
	Wed, 26 Aug 2009 02:46:46 -0700 (PDT)
In-Reply-To: <d2e97e800908260238p28bd6d27o6377f395df32b03c@mail.gmail.com>
X-Google-Sender-Auth: a1f4505170d62dc5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127082>

Mmm...

I think I see what's happening  - vaguely - but I'm not sure I understand why!

Why does gitosis require you to be this specific? Why can't I just do
a 'straight' push?

Howard

2009/8/26 Michael Wookey <michaelwookey@gmail.com>:
> 2009/8/26 Howard Miller <howard@e-learndesign.co.uk>:
>> I've been working away at Gitosis and it's mostly fair enough but
>> there's one bit that's unclear to me...
>>
>> git push origin master:refs/heads/master
>>
>> Would somebody kindly explain (or point to docs) what
>> refs/heads/master means? How is this different from just 'git push
>> origin master' or even 'git push origin master:master'?
>>
>> Any insights much appreciated.
>
> You might find some insight here - http://progit.org/book/ch9-5.html
>
