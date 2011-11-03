From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Wed, 2 Nov 2011 18:19:36 -0700
Message-ID: <CA+55aFx0oCd6-sh0psYxho-s=sHAK0RHXJHfLewRuUcdXzxZbg@mail.gmail.com>
References: <20111026202235.GA20928@havoc.gtf.org> <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <1320049150.8283.19.camel@dabdike> <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org> <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <7vwrbjlj5r.fsf@alter.siamese.dyndns.org> <CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com>
 <7vk47jld5s.fsf@alter.siamese.dyndns.org> <CA+55aFz7TeQQH3D4Tpp31cZYZoQKeK37jouo+2Kh61Wa07knfw@mail.gmail.com>
 <CAJo=hJv5nAKH_ptYSWfMvFQv0Dj+naPXK35wSzKYkfPOYsWkxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Nov 03 02:20:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLlyP-0003JY-DC
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 02:20:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754309Ab1KCBUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 21:20:00 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63391 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753474Ab1KCBT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 21:19:58 -0400
Received: by wwi36 with SMTP id 36so1080690wwi.1
        for <multiple recipients>; Wed, 02 Nov 2011 18:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=gINZCndyXr9NYGGA6WWuiHWPlw21X30LnTGoJz1MQgs=;
        b=WUzYeP1AWtaa/Td/d3ORPHBtt0uChOT3LluTKobXlknMRKotwyOyAsuCECsM4hXCMd
         99rgXTW9hFpMisnuCSXlWxdmfbpRmjRxIfr79FiCHUwLxoaWHegrK5QLhXPNNNRsdzOL
         taOb+yHZuGwu/3uIS1JFKhhz+tGWAW8S/7LRo=
Received: by 10.216.193.212 with SMTP id k62mr2112795wen.67.1320283197122;
 Wed, 02 Nov 2011 18:19:57 -0700 (PDT)
Received: by 10.216.166.3 with HTTP; Wed, 2 Nov 2011 18:19:36 -0700 (PDT)
In-Reply-To: <CAJo=hJv5nAKH_ptYSWfMvFQv0Dj+naPXK35wSzKYkfPOYsWkxg@mail.gmail.com>
X-Google-Sender-Auth: Z_t8qFLIkrjEbB712d_EYmv_2w0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184689>

On Wed, Nov 2, 2011 at 6:02 PM, Shawn Pearce <spearce@spearce.org> wrote:
>>
>> So I really think that signing the top commit itself is fundamentally wrong.
>
> I really disagree. I like the signed commit approach.

If you like it so much, go ahead and use them.

But stop with the crazy excuses for the downsides. I explained exactly
why amending is stupid and wrong, and why empty commits are f*cking
moronic. But even apart from the *technical* problems with the stupid
mis-designed feature, I explained why it was fundamentally broken from
a workflow standpoint too.

I'm not saying that you shouldn't use them - go ahead and use the
feature if you like it. But please spare me your excuses for stupid
workarounds that come from the fact that they aren't a good match for
sane workflows.

                       Linus
