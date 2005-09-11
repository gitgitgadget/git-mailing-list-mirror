From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: bogus merges
Date: Sun, 11 Sep 2005 11:11:49 -0400
Message-ID: <43244935.6060703@gmail.com>
References: <59a6e58305090507387d412b3d@mail.gmail.com>	 <Pine.LNX.4.58.0509050853080.3568@evo.osdl.org>	 <20050911112130.A7510@flint.arm.linux.org.uk> <46a038f905091104483cc01a11@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, Wayne Scott <wsc9tt@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 11 17:13:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EETV1-000661-Gi
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 17:12:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbVIKPLx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 11:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbVIKPLx
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 11:11:53 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:31299 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964799AbVIKPLx (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2005 11:11:53 -0400
Received: by wproxy.gmail.com with SMTP id 71so221081wri
        for <git@vger.kernel.org>; Sun, 11 Sep 2005 08:11:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=LMVfpj5d0RmK78sce9rVb3Pk1s7K3TsS1NZNrgX+QaRDClLmqYgMjTuIE3C8EtfR6BN0dUSmnLkRo0ZGV66ZpNz7trZVDTiVJ6+ufp32MFix2kGCJOZ0KRZcbWtkNDDu+ZRlb+qduQQ/E5zN09ETUOA7nk64tgNmoPsatjij6/Q=
Received: by 10.54.41.68 with SMTP id o68mr1865942wro;
        Sun, 11 Sep 2005 08:11:50 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.97])
        by mx.gmail.com with ESMTP id 8sm13606wrl.2005.09.11.08.11.50;
        Sun, 11 Sep 2005 08:11:50 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: martin.langhoff@gmail.com, Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <46a038f905091104483cc01a11@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8297>

Martin Langhoff wrote:
> On 9/11/05, Russell King <rmk@arm.linux.org.uk> wrote:
>>On Mon, Sep 05, 2005 at 09:01:32AM -0700, Linus Torvalds wrote:
>>>I suspect rmk is using cogito-0.13
>>Correct, and rmk will probably be extremely nervous about upgrading when
>>0.14 appears.
> 
> Well, *actually* cogito-0.13 didn't include git-core, so we have to
> look for the reasons elsewhere. Could be the leftover MERGE_HEAD
> Daniel mentions.
> 
> Russel, can you confirm what git-core version you are/were running?

Russel,

How are you updating your tree to Linus'? If you are rsyncing from 
kernel.org, you're probably getting a MERGE_HEAD with the rsync. A while 
ago I got annoyed enough add the equivalent of:

	rm -f ${LOCAL_REPOS}/.git/MERGE_HEAD

to my (very stupid) git rsync script.
