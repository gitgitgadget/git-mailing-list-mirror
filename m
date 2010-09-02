From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Thu, 02 Sep 2010 12:58:14 -0400
Message-ID: <4C7FD7A6.9090402@gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>	<AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>	<AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>	<4C7FC3DC.3060907@gmail.com> <AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git <git@vger.kernel.org>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 18:58:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrD7I-0007Wo-Uj
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 18:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755952Ab0IBQ6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 12:58:18 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35202 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629Ab0IBQ6R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 12:58:17 -0400
Received: by gxk23 with SMTP id 23so291107gxk.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 09:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=j3j5LRCYsnFqTYSzlSCNUyRyZrzXsQg3yHAImEtSI+k=;
        b=XnxRiAyZTVdpPJfQ/Ml91AyWoBm6a/F/SRtGTwXzoNYuZ46qRDcgVWIqwUUYZ5+XvA
         GXHea7OauSoahbUehJigOlVX3zI/ZX634bwrZ9eayRMuW42vAfShJbEV/Ukz3c8rYF01
         ocNgQRN+zmlq4VQPRcLa+oUZHLrRGH6brrmYU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=A/TVvZLKafd2tl74TScaC2RvMgeBe/BK71lPxL8rjM6535/ojkJhBh11YfRuAmkAwh
         v3FXT4sD3hKq3RlTMK3m8V48vAu2SByxE9ddgEaT4heQqMaJ11TGIjh0Q20XV6z7y0hz
         hC1qRx35A92qIcE6Om+s81YnXleNow/qyfldk=
Received: by 10.100.48.14 with SMTP id v14mr222344anv.146.1283446696866;
        Thu, 02 Sep 2010 09:58:16 -0700 (PDT)
Received: from [10.0.1.130] (c-24-129-111-166.hsd1.fl.comcast.net [24.129.111.166])
        by mx.google.com with ESMTPS id q7sm1008298anf.26.2010.09.02.09.58.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 09:58:15 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100805 Icedove/3.0.6
In-Reply-To: <AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155148>

On 09/02/2010 11:42 AM, Luke Kenneth Casson Leighton wrote:
> On Thu, Sep 2, 2010 at 4:33 PM, A Large Angry SCM<gitzilla@gmail.com>  wrote:
>> On 09/02/2010 09:37 AM, Luke Kenneth Casson Leighton wrote:
>>>
>>> On Wed, Sep 1, 2010 at 11:04 PM, Nguyen Thai Ngoc Duy<pclouds@gmail.com>
>>>   wrote:
>>
>> [...]
>>>>
>>>> There were discussions whether a pack is stable enough to
>>>> be shared like this,
>>>
>>>   it seems to be.  as long as each version of git produces the exact
>>> same pack object, off of the command "git pack-objects --all --stdout
>>> --thin {ref}<    {objref}"
>>
>> This is not guaranteed.
>
>   ok.  greeeat.
>
>   so, some sensible questions:
>
>   * what _can_ be guaranteed?
>
>   * diffs?

Given a pre-image and a post-image, the diff/delta created will recreate 
the post-image from the pre-image. The bit level representation of the 
diff/delta is not guaranteed.

>   * git-format-patches? (which i am aware can do binary files and also
> rms)?

See above.

> * individual files in the .git/objects directory?

Uncompressed: yes. Compressed: no.

>   and, asking perhaps some silly questions:
>
> * why is it not guaranteed?

The pack format was created to move objects from one repository to 
another. To do that efficiently, it uses many heuristics to decide how 
much information is _sufficient_ to do the job but but leaves it to the 
implementation and user to decide the various trade offs. For instance, 
there is no canonical the order of the object information in a pack or 
that the pack must be minimal. This also allows for the multi-threaded 
pack implementation.

> * under what circumstances is it not guaranteed?  and, crucially, is
> it necessary to care?   i.e. if someone does a shallow git clone, i
> couldn't give a stuff.

Pretty much all of the time.

> * is it possible to _make_ the repository guaranteed to produce
> identical pack objects?

Identical code on identical systems with identical repositories without 
multi-threading _might_ work.

> * does for example "git gc" change the object store in such a way such
> that one git repo will produce a different pack-object from the same
> ref?  if so, can running "git gc" prior to producing the pack-objects
> gurantee that the pack-objects will be the same?

See above.

> * is it a versioning issue?  is it because there are different
> versions (2 and 3)?  if so, that's ok, you just force people to use
> the same pack-object versions.

No.

> etc. etc.
>
> l.
>
