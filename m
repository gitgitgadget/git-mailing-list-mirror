From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [GUILT] Use git_editor
Date: Tue, 30 Sep 2008 20:14:15 +0100
Message-ID: <48E27A87.9060205@tuffmail.co.uk>
References: <48E27366.3080503@tuffmail.co.uk> <20080930190744.GO32444@josefsipek.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Tue Sep 30 21:16:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkkh3-0001Sh-Ok
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 21:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482AbYI3TOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 15:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753495AbYI3TOW
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 15:14:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:63125 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753830AbYI3TOU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 15:14:20 -0400
Received: by nf-out-0910.google.com with SMTP id d3so87589nfc.21
        for <git@vger.kernel.org>; Tue, 30 Sep 2008 12:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender;
        bh=/2Za+x4Dmf3P9R5RxuLFYFjTf6iUHPOt7R2egKELH6M=;
        b=PQfMrpCcnl7SawTOH1KITJ57YJdX6LMv9QgTO69EdaXnosZIoJM9VxrU04zoOonIm0
         lC1wbj74Gce9fymQGV0LlsAcjbDKAslLQM4GCeS6TeDeeeaibQrCQoq3DcR2yco+xIBv
         xMQTjvQa3BKhzh+XYePaGQ1wm88KlHdT/dA3g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender;
        b=cnWJSQHEmQmNR+uACkvkQD8v+jVqNLruaRWA6AETiZbgSehuxkP4Rhhl+l8Kgc51VR
         ED+EYJohHhvH0p83PHUbkEe9kQva5cqid2DkNlScbAIvJWQu2WD4oCAy4/BGarfK9J6a
         DgajuWwgM+tUN6gFuI571uLvYutcooPLjgUh8=
Received: by 10.210.50.5 with SMTP id x5mr469275ebx.34.1222802058972;
        Tue, 30 Sep 2008 12:14:18 -0700 (PDT)
Received: from ?10.222.147.176? ([86.53.68.233])
        by mx.google.com with ESMTPS id 5sm3399418eyf.8.2008.09.30.12.14.17
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 30 Sep 2008 12:14:17 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
In-Reply-To: <20080930190744.GO32444@josefsipek.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97146>

Josef 'Jeff' Sipek wrote:
> On Tue, Sep 30, 2008 at 07:43:50PM +0100, Alan Jenkins wrote:
>   
>> Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
>>
>> diff --git a/guilt b/guilt
>> index 1cef7b9..8d023e9 100755
>> --- a/guilt
>> +++ b/guilt
>> @@ -693,10 +693,6 @@ fi
>>  series="$GUILT_DIR/$branch/series"
>>  applied="$GUILT_DIR/$branch/status"
>>  
>> -# determine an editor to use for anything interactive (fall back to vi)
>> -editor="vi"
>> -[ ! -z "$EDITOR" ] && editor="$EDITOR"
>> -
>>     
>
> Looks good from a quick glance. Any chance there's a git_pager?
>
> Josef 'Jeff' Sipek.
>   

Not in git-sh-setup.  I did check :-).

Alan
