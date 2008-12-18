From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: is it possible filter the revision history of a single file into another repository?
Date: Thu, 18 Dec 2008 15:15:04 +0100
Message-ID: <bd6139dc0812180615v34d9aa7dj4b24ddf049b5615e@mail.gmail.com>
References: <8ec76080812180551p8c97a0dqa2025e67792946c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Whit Armstrong" <armstrong.whit@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 15:16:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDJfu-000412-8M
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 15:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbYLROPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 09:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbYLROPJ
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 09:15:09 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:46626 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbYLROPI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 09:15:08 -0500
Received: by bwz14 with SMTP id 14so1622688bwz.13
        for <git@vger.kernel.org>; Thu, 18 Dec 2008 06:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=Yxo3hmffpfE/nybhUPr+77W9roGzK2qhU7RYoIFvbUk=;
        b=NFUuwVBRp0P10IL3xSjPq155y6IY6bHz9f/sZGX87docY0xlUBhST0B/geRgGrfmzn
         +ICSms8c2/GveGrj6DGsBAx4UjI4ylJasGBUUJ9j2flRqms6JCgqShABvA16wllGZulE
         6hL1dFJYS8nwh1fd+IdvuXPdyATh1XQG8269Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=Zh3N1Y0X9e02ie2V6bEPuFK4wrgHaWp/kLuZPcYrWFNalm5eS61rqv9BUQ5b5W7Qdd
         V/3F9z2lnaVbf+JMFmqB0lBZdBPWj00Fi6Mf52Fe1iC6C9b4AKDdZXtw9wKZfN4UstqD
         TECRBRxLt6aXLYZ891PtprcfQc/gzWnL5ljbw=
Received: by 10.223.109.199 with SMTP id k7mr1706419fap.45.1229609704222;
        Thu, 18 Dec 2008 06:15:04 -0800 (PST)
Received: by 10.223.103.142 with HTTP; Thu, 18 Dec 2008 06:15:04 -0800 (PST)
In-Reply-To: <8ec76080812180551p8c97a0dqa2025e67792946c7@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: b6887df3cc9214e5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103464>

On Thu, Dec 18, 2008 at 14:51, Whit Armstrong <armstrong.whit@gmail.com> wrote:
> For instance, if my repository contains foo.c, and 100 other files.
>
> I would like to create a new and separate repository containing only
> the revision history of foo.c.
>
> Would someone mind pointing me at some documentation for this
> procedure if it exists?

I think "git filter-branch" is what you need. Have it filter out
changes to files but foo.c, and then remove all empty commits.

-- 
Cheers,

Sverre Rabbelier
