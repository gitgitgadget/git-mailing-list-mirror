From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Thu, 02 Sep 2010 13:06:32 -0400
Message-ID: <4C7FD998.9080900@gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>	<AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>	<AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>	<4C7FC3DC.3060907@gmail.com>	<AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com> <AANLkTi=W3QwWSrNTie-K4QDDrucSVGQa5e3Ldy7m7ihy@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git <git@vger.kernel.org>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 19:06:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrDFK-0005qk-36
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 19:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825Ab0IBRGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 13:06:36 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:52333 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613Ab0IBRGf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 13:06:35 -0400
Received: by ywh1 with SMTP id 1so290097ywh.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 10:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=CbEj94kZ/b4VTmbtnW0RfH2EknhD6Q9fCBFFGo1e+DY=;
        b=Yvqzl24+xSnip5zaN3Fe2717rwp3gxKJAHNIQKdJ52xgCEUz642f99GQ2z2oppOCh+
         rcK4VURYIHueEsq57XM3FZEsW6djDQtVm+qyga6MFUqIyHHP1JgahHBKvaRFyGIlv6uF
         ZD55pKWbLcji1sUcUGOj+5+KjtARiUnEr3WLI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=V7Ywnm02ZYwP45bQy+I+j6ST9rOyhg4hA/D2kA3dfoDdLfzsLMSDbm+Dsr9m8Ctrn+
         r9d/7V4s2pINjQk+b5P9fqhGW0J5JoTUsWA/6HJF5HfXaI/Od2Y/O5eIF8uzfJIASj2V
         7unOTTYbQEkCtMmmTNS8igA73UPluGGAlA3bs=
Received: by 10.151.51.14 with SMTP id d14mr67407ybk.200.1283447194163;
        Thu, 02 Sep 2010 10:06:34 -0700 (PDT)
Received: from [10.0.1.130] (c-24-129-111-166.hsd1.fl.comcast.net [24.129.111.166])
        by mx.google.com with ESMTPS id m12sm1174590ybn.7.2010.09.02.10.06.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 10:06:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100805 Icedove/3.0.6
In-Reply-To: <AANLkTi=W3QwWSrNTie-K4QDDrucSVGQa5e3Ldy7m7ihy@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155149>

On 09/02/2010 11:51 AM, Luke Kenneth Casson Leighton wrote:
> On Thu, Sep 2, 2010 at 4:42 PM, Luke Kenneth Casson Leighton
> <luke.leighton@gmail.com>  wrote:
>> On Thu, Sep 2, 2010 at 4:33 PM, A Large Angry SCM<gitzilla@gmail.com>  wrote:
>
>> * is it possible to _make_ the repository guaranteed to produce
>> identical pack objects?
>
>   i.e. looking at these options, listed from
> Documentation/technical/protocol.txt:
>
>      00887217a7c7e582c46cec22a130adf4b9d7d950fba0 HEAD\0multi_ack
> thin-pack side-band side-band-64k ofs-delta shallow no-progress
> include-tag
>
>   is it possible to use shallow, thin-pack, side-band or side-band-64k
> to guarantee that the pack object will be identical?

No. Looking to use identical packs created on different systems is not 
something that git guarantees or, likely, will ever guarantee. If you 
need that, you need to create and implement the canonical pack-like 
definition for your transfer protocol.

>   another important question:
>
> * if after performing a "git unpack" of one pack-object, can it be
> guaranteed that performing a "git pack-object" on the *exact* same ref
> and the *exact* same object-ref, will produce the *exact* same
> pack-object that was used by "git unpack", as long as the exact same
> arguments are used?  if not, why not, and if not under _some_
> circumstances, under what circumstances _can_ the exact same
> pack-object be retrieved that was just used?

Write your own "packer" is really the best answer.

> if there is absolutely absolutely no way to guarantee that the
> pack-objects can be the same, under no circumstances or combinations
> of arguments or by forcing only compatible versions to communicate
> etc. etc., a rather awful work-around can be applied which is to share
> and permanently cache every single pack-object, rather than use what's
> gone into the repo.

Sounds ugly and inefficient.
