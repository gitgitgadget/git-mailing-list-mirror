From: Chris Clayton <chris2553@googlemail.com>
Subject: Re: Problem with git bisect in git-1.6.3.3
Date: Thu, 9 Jul 2009 08:13:30 +0100
Message-ID: <c6b1100b0907090013q728201d9r5f536d0433e92f2b@mail.gmail.com>
References: <c6b1100b0907082242y7b348b13m8a4607c96b1d164b@mail.gmail.com>
	 <4A5590A3.8070404@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jul 09 09:13:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOnpG-0004VH-1n
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 09:13:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759706AbZGIHNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 03:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759096AbZGIHNd
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 03:13:33 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:50356 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756810AbZGIHNc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 03:13:32 -0400
Received: by fxm18 with SMTP id 18so6196029fxm.37
        for <git@vger.kernel.org>; Thu, 09 Jul 2009 00:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=//z1DAJCmWayKnGVDFHYch1WT0UCuJ3aQOVBEQ369OM=;
        b=uzl5TGJrFnrOt8lXEegHrPJuFaYJIhPqCi2lGYWkNrKKBH9jEdgi8v3FrnLi/ZhLbv
         dFZgwK4ofxcDf0Sb1AFgyJVYZQloBicWwKNgdp5uddfjuENQJcGFMZEulWoP/niMOgoi
         XDa662qrPIYKXwABtyc5TQE4XsrgUqcrz0YtE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=g7HJGz61KDfiQNQ4OnhNUWb4b7WT6vRnc2/QX7xQ9SzAgbUIFGpZlMCACivWT+pqO4
         J3Tn4gv/O/TKJFpmkp39Vfk6cYw44oxTcMaYTnbiOX0GHjlrrzgt8K3/DeC/BCfiPC7h
         sskphaaUkPITjHec2soMqNODKWN2a+BLRDZoQ=
Received: by 10.204.118.69 with SMTP id u5mr413613bkq.77.1247123610785; Thu, 
	09 Jul 2009 00:13:30 -0700 (PDT)
In-Reply-To: <4A5590A3.8070404@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122938>

Hannes,

Thanks for your reply.

2009/7/9 Johannes Sixt <j.sixt@viscovery.net>:
> Chris Clayton schrieb:
>> git bisect start
>> # good: [07a2039b8eb0af4ff464efd3dfd95de5c02648c6] Linux 2.6.30
>> git bisect good 07a2039b8eb0af4ff464efd3dfd95de5c02648c6
>> # bad: [8e4a718ff38d8539938ec3421935904c27e00c39] Linux 2.6.31-rc2
> ...
>> but, from Makefile, it appears the last "bad" has placed me at a
>> change earlier than 2.6.30:
>>
>> [chris:~/kernel/linux-2.6]$ head Makefile
>> VERSION = 2
>> PATCHLEVEL = 6
>> SUBLEVEL = 30
>> EXTRAVERSION = -rc6
> ...
>> I'm not an experienced git user, so it may be that I have made an
>> error or false assumption.
>
> Not an error, but false assumptions:
>
> http://thread.gmane.org/gmane.comp.version-control.git/99967/focus=99977
>
> Just continue bisecting. If you can't test the version that bisect warps
> you to because the feature where the bug happens is not present, mark that
> revision as "good".
>

Ah, it makes sense now. Thanks for your help.

Chris

> -- Hannes
>
>



-- 
No, Sir; there is nothing which has yet been contrived by man, by which
so much happiness is produced as by a good tavern or inn - Doctor Samuel
Johnson
