From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: git fetch,git merge and git rebase
Date: Fri, 11 Feb 2011 11:13:58 -0600
Message-ID: <4D556E56.30702@gmail.com>
References: <1297315789338-6010561.post@n2.nabble.com>	<4D5464E7.2010407@gmail.com> <AANLkTinsBz0Yi5XXYUcaJMTvkjuhtNjotx0VWRFcKX3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Akash <bcakashguru@gmail.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 11 18:14:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnwZM-0007h4-FP
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 18:14:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757778Ab1BKROD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 12:14:03 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:64587 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757114Ab1BKROB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Feb 2011 12:14:01 -0500
Received: by yib18 with SMTP id 18so1162027yib.19
        for <git@vger.kernel.org>; Fri, 11 Feb 2011 09:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=H+KsvXPYceN3/Bx7q5Yjr0AdJE6T4SMn9BU7vXbIjgE=;
        b=KjaPCnrhjL5b8RzfgqElbfH+VIP3cHLw2OcBAGTOVj7fojGlc56WwBQuafIc+JTLXQ
         bdbBnpMu+W4BZveuKrf8FbnJw/NksKCXXMROqNphTJ9QdQLxbKznNHW5CekvCPBRxVgZ
         FnlqzUWHZT8Gp4YgJ8foUUUq/VtAJNKXMxQbE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=JhfCaTFSMwMYogGQUO1G1o/TqY6pfKLJIMtgoveRQaTXWY/1GC+pA2v0lOqvPb7NFi
         nZcucGDi8szYUjisAik+99sVqmzb0gZsMPjN7ZcVVjvptc2HzJBI48rhsmKusn6bGKkK
         4tYTwKXYnnJ1SlVMsd9ycH8wPvhf9fboRtIck=
Received: by 10.150.206.2 with SMTP id d2mr794438ybg.167.1297444440893;
        Fri, 11 Feb 2011 09:14:00 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id v8sm690100ybe.13.2011.02.11.09.13.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 Feb 2011 09:13:59 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <AANLkTinsBz0Yi5XXYUcaJMTvkjuhtNjotx0VWRFcKX3d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166565>

On 2/11/2011 6:32 AM, Felipe Contreras wrote:
> On Fri, Feb 11, 2011 at 12:21 AM, Neal Kreitzinger
> <nkreitzinger@gmail.com>  wrote:
>> On 2/9/2011 11:29 PM, Akash wrote:
>>> Hi,
>>>
>>> I am new to git .Can someone explain in simple terms what git fetch,git
>>> merge and git rebase do?..I tried googling but was very confused after
>>> going
>>> thro it.
>>>
>>> Also, can someone prescribe a link which explains git in detail right from
>>> scratch.
>>>
>>>
>> another definition of git-rebase:
>>
>> git-rebase:  the MOST DANGEROUS command in git.  you can easily DESTROY your
>> repo if you don't know what you're doing!  Until you get the hang of it,
>> always make a copy of the before-image of the branch your rebasing
>> (mybranch) by doing a "git checkout mybranch" and then "git branch
>> copy-of-mybranch".  Then if you destroy mybranch you can recover it from
>> copy-of-mybranch.
> What about 'git rebase --hard', or 'git branch -D'? In all cases you
> can recover by using the reflog.
>
i take you meant 'git reset --hard'...

v/r,
neal
