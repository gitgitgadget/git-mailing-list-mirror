From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: ignoring files/directories in git
Date: Mon, 22 Sep 2008 10:37:00 +0300
Message-ID: <48D74B1C.6020408@panasas.com>
References: <19596152.post@talk.nabble.com> <19599905.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: mwolfe38 <mwolfe38@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 09:38:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Khfzs-0001N1-Kp
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 09:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbYIVHhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 03:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbYIVHhH
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 03:37:07 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:21809 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbYIVHhG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 03:37:06 -0400
Received: by ey-out-2122.google.com with SMTP id 6so378496eyi.37
        for <git@vger.kernel.org>; Mon, 22 Sep 2008 00:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender;
        bh=RfVpejLuAnvumA1uHvo+Q6CsUVUTaz0qChOwYmmnhy4=;
        b=CXUAEX233RzUypZCaMvKdJlX0/oB4/ARZX3rSXH2/VOKGlPzc8PGi40ThhFTUVZPwE
         QIlyGvsyfnBZTq1BLPKTQhb0Ik19gzjuO2j1NPG6sbR0C6jGHiZnc97a/PH4sZ+Bm0Jp
         D4Ya+jFLFauVhU/qOmroThm+6RRj6r2vjBWvY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender;
        b=Z8/+vh0h56H08Wjw4AJlzz/CGSJmUTc4QNTVIhTCobUld+IC/gm7B93pdJvkJnL3ow
         khXgLe6ZVk2V1lXP19SJi7tcjBOg0T0fxc44tO/RLJXu4fnld7pshxLTqBu3YL3baeQC
         3Hlz1Mg8znPT/y1GWAwIfO0TbTjwulvrMlJLE=
Received: by 10.210.124.15 with SMTP id w15mr4484187ebc.81.1222069023999;
        Mon, 22 Sep 2008 00:37:03 -0700 (PDT)
Received: from bh-buildlin2.bhalevy.com ( [212.235.53.3])
        by mx.google.com with ESMTPS id 7sm6932372eyb.1.2008.09.22.00.37.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Sep 2008 00:37:03 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <19599905.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96454>

mwolfe38 wrote:
> I just thought that I would add that the reason is a bug in the 1.5.4.3
> version that I am using which is the ubuntu 8.04 repository version.
> According to some developers, the current version should fix this issue.
> 
> 
[Please don't top-post]

I have 1.6.0.1 I compiled here, and it has the same problem. So it is
a very recent fix

> mwolfe38 wrote:
>> I'm working on a project by myself and using git mostly just to learn
>> about it.
>> In my project I have several directories I want to have git ignore. One of
>> them being
>> cache/ and the other log/
>> I've added them to the .gitignore file which I have in the initial
>> directory of the repository
>> The contents of my gitignore are:
>>
>> .settings
>> .cache
>> cache/
>> log/
>> .project
>>
>> However, if I do 
>> git add .
>> It will add the files from cache and log anyways.
>> I know git add . will add anything that hasn't been added but shouldn't it
>> ignore files in .gitignore?
>> If not, what is the point, I would just ignore them manually anyways. 
>> The main reason i like doing git add .
>> is because i'm using symfony php framework which makes good use of scripts
>> which generates lots if initial files for you and thus adding one at a
>> time would be a pain.
>>
>> Any idea what might be going on here?  I thought maybe I had added those
>> directories before putting them in .gitignore so i used git rm -r to
>> remove them but they still show back up with doing git add .
>>
>> Thanks in advance
>>
> 

Boaz
