From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
Subject: Re: [PATCH] Teach/Fix git-pull/git-merge --quiet and --verbose
Date: Mon, 13 Oct 2008 23:44:41 +0200
Message-ID: <4ac8254d0810131444l3a3f60aaqa86b1e6f5a4af76e@mail.gmail.com>
References: <4ac8254d0810120954x2364054ahf2d49d6fbb7b0bb1@mail.gmail.com>
	 <20081012200833.GC5255@spearce.org>
	 <4ac8254d0810121431v1a67afc8ua92842b3d8c39328@mail.gmail.com>
	 <4ac8254d0810121436x6285d17ew631f04e768a6fb62@mail.gmail.com>
	 <4ac8254d0810131403i4c8c57d6r71531e34321e9b50@mail.gmail.com>
	 <20081013210607.GV4856@spearce.org>
	 <4ac8254d0810131412o34c01a4cla30eadc45e2e4e06@mail.gmail.com>
	 <20081013211327.GW4856@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 13 23:46:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpVEh-0006JQ-N8
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 23:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754454AbYJMVoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 17:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754248AbYJMVoo
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 17:44:44 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:15236 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754150AbYJMVon (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 17:44:43 -0400
Received: by yw-out-2324.google.com with SMTP id 9so451950ywe.1
        for <git@vger.kernel.org>; Mon, 13 Oct 2008 14:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=nKeMd2l8EFveHCBQ+/dhGyAn7A2Zfn9y3Ta8Aks2kdY=;
        b=A/b9qNz9m5dURe7aqzP+84zsTMqCqFrd0AXhCgSsTvJYE24VKWT7pNacoHfs0EnDj7
         lyATX3HXC2TGOxYkyqrDJjf8CUpX/ki/4sbTLmvYGg7PJOwgLVy9jI0VFp3xerV9a+T9
         JmK8dKxHeDCA3Mvyb9Xj2bf9JPwz8l+KCe2I4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=r+uAD/kd82pGmQU9xta8qBaOpuRfghtvFS6zlrmeorOeN5DouxECJynqEnFrc1LLHF
         pwk6t1p0g0DYBUaamFB88UuowQbUT+mB3859QcdOcm14M/fMJLckC1/ULNLxfVgDokUl
         idK0hXUulca18b5iTmcs/7YctiBtKdSRU+UWs=
Received: by 10.151.108.5 with SMTP id k5mr8844797ybm.209.1223934281732;
        Mon, 13 Oct 2008 14:44:41 -0700 (PDT)
Received: by 10.64.142.13 with HTTP; Mon, 13 Oct 2008 14:44:41 -0700 (PDT)
In-Reply-To: <20081013211327.GW4856@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98159>

On Mon, Oct 13, 2008 at 11:13 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Tuncer Ayaz <tuncer.ayaz@gmail.com> wrote:
>> On Mon, Oct 13, 2008 at 11:06 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
>> > Tuncer Ayaz <tuncer.ayaz@gmail.com> wrote:
>> >> Hi Shawn and list,
>> >>
>> >> I've updated the patch to current Junio master.
>> >>
>> >> Signed-off-by: Tuncer Ayaz <tuncer.ayaz@gmail.com>
>> >
>> > Looks good to me.
>>
>> GMail borked it by inserting some linebreaks :(
>> is that a problem for this single diff or should
>> I first resend it properly via SMTP?
>
> I would resend it.  For a one line diff its easy to hand apply,
> but with multiple hunks like this you don't to waste Junio's time
> by trying to fix up the patch by hand.

OK, configured my local setup for send-email to work
and used that.
