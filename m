From: alexandrul <alexandrul.ct@gmail.com>
Subject: Re: git log --pretty=format:%h prints (unrequired) abbreviated sha
Date: Fri, 25 Sep 2009 17:41:51 +0300
Message-ID: <4ABCD6AF.8080407@gmail.com>
References: <e5bfff550909250240q3351d39evbcf507af422fde43@mail.gmail.com>	 <e5bfff550909250246qed6f2ci4237bdaefd8a18a@mail.gmail.com>	 <4ABC9C5D.5030202@viscovery.net>	 <e5bfff550909250344y535a05edx7d30ad7e48a5f036@mail.gmail.com> <e5bfff550909250430x14b0d7f4w5e22467ddd66cc29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 16:45:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrBzq-0008Gw-KF
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 16:42:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836AbZIYOl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 10:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752716AbZIYOl4
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 10:41:56 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:59613 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbZIYOlz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 10:41:55 -0400
Received: by bwz6 with SMTP id 6so2073268bwz.37
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 07:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=9oimefatsmXVYa+qRX176cy1zBxWa2ixSHZcv/eCl2s=;
        b=uS9yjIq/7A2RFt5Ys6brD7FZ1GUIUwdDNufVw6aqUTJS2aNZIg4pZ4/IB1Vlmu+/Xu
         Sa1a2dSShTWoWgGt1FDP3QjbUnC4gEqQeV70W9pmXak3ucCwztAToqkTEb/q0vzhq1NN
         uy5nSvbNI4fgQzg9wxNcEXBCONEGgCLlVj8PU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=DxlbT9tSvqhbcPca+/2fT6zsmJ5V+hiH3nkhABe8x+M7+CzCWavYuxTVR78WVK9myE
         qOg1tKpR0sF3o7dGfoEwuLrmge3nt+oh6aGJ2C09YNx8Erid9zt0odHKIA20n0FbacT+
         EF9VvS3wie5XUFdvt4BkprzIw4zrJqqjd3GA0=
Received: by 10.86.41.19 with SMTP id o19mr1014053fgo.45.1253889718555;
        Fri, 25 Sep 2009 07:41:58 -0700 (PDT)
Received: from ?192.168.2.8? ([89.136.114.133])
        by mx.google.com with ESMTPS id e20sm1613740fga.22.2009.09.25.07.41.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 25 Sep 2009 07:41:57 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <e5bfff550909250430x14b0d7f4w5e22467ddd66cc29@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129088>

>> What (old) version of msgit do you suggest me to try to verify if it
>> is a new problem ?
>>
>> BTW gitk does not work correctly. It loads the revisions but doesn't
>> show the diffs.
>>
> 
> Also installing an old version I have the same wrong behaviour and the
> same version works on another PC and with the same repository I am
> testing with.

If nothing else works, you could try to uninstall your current version 
of git, clean up any traces left, and reinstall.

http://code.google.com/p/msysgit/issues/detail?id=336

Have a nice day,
   A.
