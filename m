From: Michael Witten <mfwitten@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 16:44:06 -0500
Message-ID: <b4087cc51003181444i7b7dea5bgc8f4f43b365526f4@mail.gmail.com>
References: <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org> 
	<4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com> <4ba27424.9804cc0a.4b1f.11b1@mx.google.com> 
	<20100318204416.GM8256@thunk.org> <b4087cc51003181412s78d153c8t48984eb87eb75e0e@mail.gmail.com> 
	<alpine.LFD.2.00.1003181411400.18017@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: tytso@mit.edu, Nicolas Pitre <nico@fluxnic.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Mar 18 22:44:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsNW5-0006xm-V7
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 22:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164Ab0CRVo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 17:44:28 -0400
Received: from mail-fx0-f219.google.com ([209.85.220.219]:48571 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704Ab0CRVo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 17:44:27 -0400
Received: by fxm19 with SMTP id 19so102242fxm.21
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 14:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=72o8YyePbS4owP6ckJSJ9XkgaF9SFGjsPXI1iZzcW2Q=;
        b=uYEuBf9/zcL/Zo6+yKr/CQToTi2waRqrtiGXoE7p2q9BqXQbOpCbIurOtYH439rLjg
         KJrswsnWc0CGa/qeb0XGjp4RfJhFRuDoRfE1k9cKil0RH/ht2xwHLnq9fc4n8wug7yQG
         DGcCNP+elFTdikyMUVOw/FZ8+C/W//JISBL6M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=sH0UPnPgjkKz6H3xHPs10CeyBGDG6+qRELHiithV+V7JmMk9g9wvOn1Ce6ZfmrFsHV
         +y5Sb2McCy5trWWSlDQ0St11KLWhCPhJNTJy7KVcJMJVFVVNijxIvjzQshmygoFOX5LL
         xtfJxpCTam7fEp6eBcKD4bcgfqjecJVJogQus=
Received: by 10.239.185.81 with SMTP id b17mr1570030hbh.191.1268948666216; 
	Thu, 18 Mar 2010 14:44:26 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1003181411400.18017@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142525>

On Thu, Mar 18, 2010 at 16:27, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 18 Mar 2010, Michael Witten wrote:
>>
>> This is all that I'm saying: Keep git exactly the way it is, but add
>> one extra piece of identifying information for each person.
>
> The thing is, you don't seem to realize that most authorship is [sent
> over email with incomplete information].

That is a really good point, and something I'll have to consider more
thoroughly.

However, I do NOT claim that my proposal will add information where
there is none, only that it will reduce the rate at which entropy
increases.
