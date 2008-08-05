From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: StGit: kha/{stable,safe,experimental} updated
Date: Tue, 5 Aug 2008 22:33:57 +0100
Message-ID: <b0943d9e0808051433i667f6a05iff1a5220e37602e7@mail.gmail.com>
References: <20080725013936.GA20959@diana.vm.bytemark.co.uk>
	 <b0943d9e0807270144n359e5bd3ye3e91c52b8fa7beb@mail.gmail.com>
	 <20080801102208.GA29413@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Samuel Tardieu" <sam@rfc1149.net>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 23:35:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQUBK-000792-Io
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 23:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755947AbYHEVd7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Aug 2008 17:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757209AbYHEVd7
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 17:33:59 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:39226 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755022AbYHEVd6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Aug 2008 17:33:58 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1903463waf.23
        for <git@vger.kernel.org>; Tue, 05 Aug 2008 14:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=91fyW6+JhJM9fTYh7PDuOyq1FEyb5Jl++ecah/qkONc=;
        b=t3JM2uh6ghVOu0RD4DgNFeBE194JHp6x96pSOzbOV/RjawBv8vp53sfDWbfuUBUTg0
         AkH2yfvFddwyu3Do25XdIFoEOsqitl1MIg+pcxYdiyvAN943rRJ3TkosfImf77yOsPs2
         q4/ccbNwI5hcsb4TdY/g9pED4lynA2RBXY2AM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=gedHYKaFO68o9acTZcIS9wK4diizBzvHPh62BfBid8ZgzCCqAsBTTD3TEJkDsFxNHD
         xiSCBzPB5sn43Qx1F/67AQ++ZDa38drvF7dajTsCqLYYe9iEvmazThMQGcTLbV2UF/Y7
         gsBW3oWzcluY8qhb2EGStzIYj/ei7juj58I7c=
Received: by 10.114.73.1 with SMTP id v1mr269454waa.16.1217972037983;
        Tue, 05 Aug 2008 14:33:57 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Tue, 5 Aug 2008 14:33:57 -0700 (PDT)
In-Reply-To: <20080801102208.GA29413@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91465>

2008/8/1 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-07-27 09:44:31 +0100, Catalin Marinas wrote:
>
>> 2008/7/25 Karl Hasselstr=F6m <kha@treskal.com>:
>>
>> > The big update since last time is support (in kha/experimental) fo=
r
>> > hidden patches in the new-infrastructure commands and stack log.
>>
>> I'll have a look at the new stack log format (my main worry) this
>> week but the other patches look OK.
>
> Heh. It's _always_ your main worry. But rightly so, since mistakes
> could be costly. Thanks for spending time on this with me.

I'm usually worried about performance but will give it a try with a
Linux kernel and real patches. Have you done any tests to compare it
with my master branch?

Would we even need to prune the stack history? It might get pretty
large after about 1-2 years of usage.

--=20
Catalin
