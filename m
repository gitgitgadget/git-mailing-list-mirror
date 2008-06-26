From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Errors building git-1.5.6 from source on Mac OS X 10.4.11
Date: Thu, 26 Jun 2008 20:42:31 +0200
Message-ID: <81b0412b0806261142r37f84187qf5ff043e1913b4fb@mail.gmail.com>
References: <2eb980790806250620t73ae0ff7heedb65780a66ad00@mail.gmail.com>
	 <20080625175311.GB4039@steel.home>
	 <2eb980790806260148p7713a546k641d96a956e9b0fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Ifejinelo Onyiah" <nelo.onyiah@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 20:43:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBwRL-00084m-9O
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 20:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753741AbYFZSme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 14:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753127AbYFZSme
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 14:42:34 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:59423 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709AbYFZSmc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 14:42:32 -0400
Received: by fk-out-0910.google.com with SMTP id 18so140916fkq.5
        for <git@vger.kernel.org>; Thu, 26 Jun 2008 11:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=0qmQNpJoXZxVFKHMDfp8Sz+OdtAizbVzAmO8XCX1QEk=;
        b=FGiCy9zqvwIySxauZ/hP6psCIf8WpQiS2BxFrM0tERwyuSGphpFBhl1fuZ2Tq0bUyj
         D2kUXSsrjFau/Z12hD8O6RPlPc0gwR6o1NHekcBZav9/qHc/a+6cCYxoLOvJDO1QmD8j
         FJcYzCG6XAJ/6RQYcFwXAnw9DSuz5LwOejLqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=hidyc9K8Xur6fMHzmWJSYMoKzI83EvRBzTn5qSnMo5Phckhdgpd4P7HuObpslwIT9D
         w55dlym2aT4W1NaivBPgGb9vw0EAGen+1xLmuyfN0plXFE5uG8fVmvJdcY7iUXf8NPBL
         z37GD9tp47OYnE3a1MP4ZAa905WLrBuX5QMjc=
Received: by 10.78.146.13 with SMTP id t13mr146227hud.101.1214505751064;
        Thu, 26 Jun 2008 11:42:31 -0700 (PDT)
Received: by 10.78.97.4 with HTTP; Thu, 26 Jun 2008 11:42:31 -0700 (PDT)
In-Reply-To: <2eb980790806260148p7713a546k641d96a956e9b0fa@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86474>

2008/6/26 Ifejinelo Onyiah <nelo.onyiah@googlemail.com>:
> 2008/6/25 Alex Riesen <raa.lkml@gmail.com>:
>> Ifejinelo Onyiah, Wed, Jun 25, 2008 15:20:39 +0200:
>>>
>>> They all run fine but when I issue the make test command, it dies at
>>> the following:
>>>
>>> % make test
>>>
>>> ... TRUNCATED OUTPUT ...
>>>
>>> *** t2004-checkout-cache-temp.sh ***
>>> * FAIL 1: preparation
>>>
>>
>> If you don't mind helping the investigation a bit, could you please go
>> into the t/ directory and run
>>
>>    bash -x t2004-checkout-cache-temp.sh -d -v -i
>>
>> and post the output here?
>
> I ran that command and it seemed to run with no problems. I have
> provided the output in 2 attached text files. I hope that is ok.

could you try the command _without_ "bash -x"?
Like this:

    cd t
    ./t2004-checkout-cache-temp.sh -d -v -i
