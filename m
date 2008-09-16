From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Re: Management of opendocument (openoffice.org) files in git
Date: Tue, 16 Sep 2008 09:05:32 +0200
Message-ID: <48CF5ABC.5060507@gmail.com>
References: <48CF5127.5040507@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Sep 16 09:08:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfUeB-0002s7-9f
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 09:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbYIPHFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 03:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751991AbYIPHFl
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 03:05:41 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:9427 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945AbYIPHFk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 03:05:40 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2547226rvb.1
        for <git@vger.kernel.org>; Tue, 16 Sep 2008 00:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=UHDjxEJHeeAxNUdhoXTPgI6HOtDu9ZiOnXG4R1g/oD0=;
        b=V5X65XMmsGb+uGO5Io0Z50BR+B+AlyMOStJvVPYfBRxvvunBaZNZB9BwEnlpeuFz6Z
         0TnD2VNYQ/urv7gUjD+C/mtbUQqZRfA5IyVwcwX1PqpT9LFQgOxmdAVKnI4UNtSWPveL
         7TdJmf5LSkcZB/0FNw2BF51p+jY3KO2ilMFdg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=n2BbRWsviphbWXxSYiKaQxpRzPu9FKiCTkO+rhSkH1qsIZ01XJlr2VgHXY7qEqk7X1
         tRvRkSGbzkS8Mab3/Z7sA0sgFQ++i3QS3usrh6DHsdg4AP3Oj1yM36sL14haOOrmwFIP
         JDw3tGFMYEeuEUZ47AL09Eanx/fSkrBjQZ+kQ=
Received: by 10.114.25.19 with SMTP id 19mr421542way.225.1221548739773;
        Tue, 16 Sep 2008 00:05:39 -0700 (PDT)
Received: from ?192.168.1.103? ( [71.197.224.64])
        by mx.google.com with ESMTPS id n20sm31023003pof.0.2008.09.16.00.05.32
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 16 Sep 2008 00:05:38 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <48CF5127.5040507@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95981>

Thanks for the fixes (particularly the missing quotation!) and the 
suggestions.

With regards to

> And maybe -b,-qq,-X and -q,-r respectively could be added by default?
>
>   
I would prefer not to do so:  if you do you get something that is 
somehow "specialised", otherwise you have a totally generic "rezipper" 
that might also find other applications (who knows).
BTW, that is why I added the profiles, so that there was no need to type 
repetitive stuff.

Sergio
