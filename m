From: Marius Storm-Olsen <marius@storm-olsen.com>
Subject: Re: [PATCH 04/14] Set _O_BINARY as default fmode for both MinGW and
 MSVC
Date: Tue, 15 Sep 2009 21:12:59 +0200
Message-ID: <4AAFE73B.5010408@gmail.com>
References: <cover.1253021221.git.mstormo@gmail.com>	 <213f3c7799721c3f42ffa689498175f0495048eb.1253021728.git.mstormo@gmail.com>	 <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253021728.git.mstormo@gmail.com>	 <cover.1253021728.git.mstormo@gmail.com>	 <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253021728.git.mstormo@gmail.com>	 <badc5d24387c28c752a45f75e8aec6bce64f81fe.1253021728.git.mstormo@gmail.com> <e2480c70909151207v4d89d302m27aecff0d4a11d45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com, raa.lkml@gmail.com
To: Alexey Borzenkov <snaury@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 21:13:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MndSW-0005xT-Ee
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 21:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758377AbZIOTMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 15:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758364AbZIOTMt
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 15:12:49 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:44645 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758309AbZIOTMs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 15:12:48 -0400
Received: by ewy2 with SMTP id 2so774432ewy.17
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 12:12:50 -0700 (PDT)
Received: by 10.211.174.15 with SMTP id b15mr1382534ebp.22.1253041970152;
        Tue, 15 Sep 2009 12:12:50 -0700 (PDT)
Received: from ?192.168.0.196? (cm-84.215.55.206.getinternet.no [84.215.55.206])
        by mx.google.com with ESMTPS id 5sm165464eyh.3.2009.09.15.12.12.49
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 15 Sep 2009 12:12:49 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <e2480c70909151207v4d89d302m27aecff0d4a11d45@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128582>

Alexey Borzenkov said the following on 15.09.2009 21:07:
> GMail ate the bottom half of my message... again. :( Seems like 
> there's a strange bug in copy/pasting, I better compose long emails
> in TextMate from now on. Here's a "reconstruction":
> 
> On Tue, Sep 15, 2009 at 5:44 PM, Marius Storm-Olsen
> <mstormo@gmail.com> wrote:
>> +extern int _fmode;
> 
> And indeed. I just ported this patch to my custom msysgit branch 
> (based on v1.6.4.3) and it didn't compile:

Hmmm, I compile this fine with both MinGW from the msysgit 'devel' 
branch, and MSVC; but I see your point.

I'll give your updated patch a roll tomorrow. Thanks

--
.marius
