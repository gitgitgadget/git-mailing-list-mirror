From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: [PATCH] Teach git diff about Objective-C syntax
Date: Wed, 17 Sep 2008 16:31:17 +0100
Message-ID: <57518fd10809170831x6d84aeb0m9b0b2c4095a1de70@mail.gmail.com>
References: <57518fd10809170526i5c1e7dadgc38bb00e8073ba55@mail.gmail.com>
	 <1221658141-75698-1-git-send-email-jon.delStrother@bestbefore.tv>
	 <48D11C3C.5070707@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, vmiklos@frugalware.org,
	Johannes.Schindelin@gmx.de
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Sep 17 17:33:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfz1R-0006Pp-Ah
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 17:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754602AbYIQPbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 11:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754570AbYIQPbU
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 11:31:20 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:42464 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754516AbYIQPbT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 11:31:19 -0400
Received: by gxk9 with SMTP id 9so29755970gxk.13
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 08:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=tpUsZRDOuP0e0XArrrbrmlkboUbaasNGegs/ITM+Qvc=;
        b=e24/xCgoX6DM42OFA1RrWIPKWqNwWJ76iGypNk+IoZxd8FDaxRLN9pm2J7X483sGfU
         XIjxnMXUMmvtmVVXC3jvHd9xzAm5fHY3yBdK2ZTtMaxkuXyCnThQ3KEoRtKOd7oOLvHi
         dwwKfIZhEzEstm2I6FJZbgTHrJhgzkBZJtK/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=sJ1nEFK0JxPrYID9vC+/DzdJgFzdbbBRC61cXByAlSmgxbLb17QBnZxf+YTq1+q6TC
         6ys+TpWxyR5I+4DkZojxwcIvaJ/yZc6mFIG8zAzgjRYreQPOuDVRpmkapzsDYF372BPY
         fsi8XdLoQVqLdw6vCEbf2bVVefU0V4oB5/69A=
Received: by 10.142.50.5 with SMTP id x5mr913666wfx.162.1221665477488;
        Wed, 17 Sep 2008 08:31:17 -0700 (PDT)
Received: by 10.143.6.3 with HTTP; Wed, 17 Sep 2008 08:31:17 -0700 (PDT)
In-Reply-To: <48D11C3C.5070707@op5.se>
Content-Disposition: inline
X-Google-Sender-Auth: c7f9b2d48e97fdf7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96121>

On Wed, Sep 17, 2008 at 4:03 PM, Andreas Ericsson <ae@op5.se> wrote:
> Jonathan del Strother wrote:
>>        { "pascal", "^\\(\\(procedure\\|function\\|constructor\\|"
>>                        "destructor\\|interface\\|implementation\\|"
>>                        "initialization\\|finalization\\)[ \t]*.*\\)$"
>>                        "\\|"
>> -                       "^\\(.*=[ \t]*\\(class\\|record\\).*\\)$"
>> -                       },
>> +                       "^\\(.*=[ \t]*\\(class\\|record\\).*\\)$"},
>> +
>
> This last change is just pure nonsense. Please remove it altogether.
>


I was changing it to match the style in the existing java pattern (and
my objc pattern).  You think the java one should be changed to match
the pascal one, then?
