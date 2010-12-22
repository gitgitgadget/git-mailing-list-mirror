From: Andreas Ericsson <ae@op5.se>
Subject: Re: "git pull" doesn't respect --work-tree parameter
Date: Wed, 22 Dec 2010 12:42:31 +0100
Message-ID: <4D11E427.5040506@op5.se>
References: <AANLkTi=UtZuPQcTNnwS_fXgzRn4MHAUGS8zyTMqX9E2J@mail.gmail.com>	<AANLkTik9s0cLc_P=NWvpO=DhytOkLNASEM7sjzoscHo3@mail.gmail.com> <AANLkTinGPJRQCOVz5JeqL4xnUG9V=5fkJhz6C5Mi1A3o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git <git@vger.kernel.org>
To: Alexey Zakhlestin <indeyets@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 22 12:42:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVN5d-0005Kb-Nw
	for gcvg-git-2@lo.gmane.org; Wed, 22 Dec 2010 12:42:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996Ab0LVLmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 06:42:37 -0500
Received: from mail-ey0-f171.google.com ([209.85.215.171]:51245 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660Ab0LVLmg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 06:42:36 -0500
Received: by eyg5 with SMTP id 5so2578052eyg.2
        for <git@vger.kernel.org>; Wed, 22 Dec 2010 03:42:35 -0800 (PST)
Received: by 10.213.106.13 with SMTP id v13mr5629169ebo.21.1293018153967;
        Wed, 22 Dec 2010 03:42:33 -0800 (PST)
Received: from [192.168.1.178] (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id b52sm4627202eei.7.2010.12.22.03.42.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Dec 2010 03:42:32 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Thunderbird/3.1.7 ThunderGit/0.1a
In-Reply-To: <AANLkTinGPJRQCOVz5JeqL4xnUG9V=5fkJhz6C5Mi1A3o@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164080>

On 12/22/2010 12:40 PM, Alexey Zakhlestin wrote:
> On Wed, Dec 22, 2010 at 2:20 PM, Nguyen Thai Ngoc Duy<pclouds@gmail.com>  wrote:
>> On Tue, Dec 21, 2010 at 11:04 PM, Alexey Zakhlestin<indeyets@gmail.com>  wrote:
>>> I am trying to use the following command:
>>>
>>> git '--git-dir=/path/to/repository/.git' '--work-tree=/path/to/repository' pull
>>>
>>> and get this error:
>>> "git-pull cannot be used without a working tree"
>>
>> It works fine for me. What's the result of
>>
>> git '--git-dir=/path/to/repository/.git'
>> '--work-tree=/path/to/repository' --git-dir
> 
> No directory given for --git-dir.
> 

You added an extra --git-dir without an argument at the end of
the command. Remove it and try again.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
