From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: [PATCH 04/15] Set _O_BINARY as default fmode for both MinGW and
 MSVC
Date: Thu, 17 Sep 2009 10:14:52 +0200
Message-ID: <4AB1EFFC.1070009@gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com>	 <213f3c7799721c3f42ffa689498175f0495048eb.1253088099.git.mstormo@gmail.com>	 <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253088099.git.mstormo@gmail.com>	 <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253088099.git.mstormo@gmail.com>	 <929c5a34cd2621af24bcda7e47ff2e76b51c2e09.1253088099.git.mstormo@gmail.com>	 <4AB10F01.9010703@viscovery.net> <e2480c70909161300o3db4b416k8f33ccce2f987c55@mail.gmail.com> <4AB1E118.70504@viscovery.net> <4AB1E4C5.80102@gmail.com> <4AB1E6E4.1040100@viscovery.net> <4AB1EB02.2090308@gmail.com> <4AB1EF0E.5010600@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alexey Borzenkov <snaury@gmail.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	gitster@pobox.com, j6t@kdbg.org, lznuaa@gmail.com,
	raa.lkml@gmail.com,
	Marius Storm-Olsen <marius.storm-olsen@nokia.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Sep 17 10:15:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoC9N-0000pe-DD
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 10:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338AbZIQIPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 04:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753276AbZIQIPV
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 04:15:21 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:27950 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883AbZIQIPT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 04:15:19 -0400
Received: by ey-out-2122.google.com with SMTP id 25so61557eya.19
        for <git@vger.kernel.org>; Thu, 17 Sep 2009 01:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=UUi/9Ult5iG+yQvVNpnk3iPlvZq+o1fpFjVeDKrGVaA=;
        b=NMD0pTsqvLxbiQxxo+EPY0ljvaDrBv2msPwMdOPyYdXGtd6T7yz8c1rkL4DMDsBuFD
         QAwst6IduCsWTseH/hDBPD4FJ3SaNHd30tfbnmRpY1Tcbt8BQ+fbGH4bDsz+ivnMamki
         8rUVpRmzykrKojkpbzAYdcAb1hlE9KQqSZHsY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=o4KYTCy2MiUixoaQnU2RVQM8X/QsIwLppYNLrpRx3pn1TR8gCeqsm8va6M3gAoVcKj
         JAdYyOzqdgtPX+k+6Hs5+jxKPFDgdh4NW5gpeuw58aA+yzyLZ2efxSGFzGrHSBgaftgj
         wkh9MvGtChl9AzrOarvGzBqS+rvCkRpNppaPA=
Received: by 10.211.160.4 with SMTP id m4mr257294ebo.24.1253175320896;
        Thu, 17 Sep 2009 01:15:20 -0700 (PDT)
Received: from ?172.24.90.95? ([62.70.27.104])
        by mx.google.com with ESMTPS id 5sm1030097eyf.25.2009.09.17.01.15.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 17 Sep 2009 01:15:20 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Lightning/0.9 Thunderbird/2.0.0.23 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <4AB1EF0E.5010600@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128731>

Johannes Sixt said the following on 17.09.2009 10:10:
> Marius Storm-Olsen schrieb:
>> BTW, I ran all the tests (make /k test) before and after the
>> whole series, with msysgit 'devel' branch + plain git.git 'next',
>> and it turns out that 2 more tests pass after this series :)
> 
> Sorry to disappoint you: these 2 tests only passed by chance. For a
> work-around see e95a73ef in mingw.git (it papers over an undetected
> racily-clean index).

Ah, gotcha. Oh well, at least no regressions then, which is also a 
good thing :)

--
.marius
