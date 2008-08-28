From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: Git-aware HTTP transport
Date: Thu, 28 Aug 2008 12:40:07 +0600
Message-ID: <7bfdc29a0808272340kdc2f3b0x250eef32b25dcdcb@mail.gmail.com>
References: <20080826012643.GD26523@spearce.org> <48B36BCA.8060103@zytor.com>
	 <20080826145857.GF26523@spearce.org> <48B4303C.3080409@zytor.com>
	 <20080826172648.GK26523@spearce.org> <48B485F8.5030109@zytor.com>
	 <20080828035018.GA10010@spearce.org> <48B62B6F.7010103@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 08:41:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYbBz-0002eA-7C
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 08:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbYH1GkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 02:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbYH1GkJ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 02:40:09 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:36170 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbYH1GkI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 02:40:08 -0400
Received: by yx-out-2324.google.com with SMTP id 8so136242yxm.1
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 23:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=WARbXtzeiJ+FKBgB1VMA16J4S1PHE15JA55y6magngw=;
        b=JoUckLs9qHWeLWlWoG+/5MSqxmjC8Aq3Tw/uGe3zoQZOPAtWd3hXWg/uxlKNpE7l7y
         Uao888iZ4lD9xJYDNsEdY7InViCb3ENO1fAKpCDPKnPMUTRTK2P3ypH8Wc6QSN7v1v9s
         k/ZH6SM67AbOownDcv8dmvRKAqur1jIZvsTQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=OLp6QYDiem9PXRviCTWB/oSToykeSZuVuBPVvpNE1Mu1/wEyPw3Sudcx1IQpxOx2o1
         oJ/MBDVEDG0PcZIX6XT9tsSCqKtECRBNGKWbx6u+xpBpkeseJYTosa0Opfzm9LZBHKBW
         7tDx6PYQqegYB6jsuE8K4ux9hK6QWIKWwhXJE=
Received: by 10.150.148.1 with SMTP id v1mr1604456ybd.55.1219905607160;
        Wed, 27 Aug 2008 23:40:07 -0700 (PDT)
Received: by 10.150.225.1 with HTTP; Wed, 27 Aug 2008 23:40:07 -0700 (PDT)
In-Reply-To: <48B62B6F.7010103@zytor.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 28, 2008 at 10:37 AM, H. Peter Anvin <hpa@zytor.com> wrote:
> Shawn O. Pearce wrote:
>>
>> So this is what may be the final draft of the HTTP protocol.
>> I've added stuff about capability selection between the peers for
>> future expansion support.  The upload-pack service has a better
>> use of it than receive-pack.  Otherwise it is what I think you are
>> agreeing to above.  ;-)
>>
>
> It looks good to me.  I *really* like the option of combining a redirect
> with a refs list in one reply; this will make things substantially easier do
> deploy on kernel.org, and saves a round trip to boot.

I agree, this is a very cool feature of the protocol...

- Imran

>
> Just an implementation detail for the server, however: for an *empty*
> repository (one which has no refs at all), the server needs to *not*
> transmit the redirect, or there will be a loop :)  It is unnecessary,
> anyway, since there is inherently nothing to do.
>
>        -hpa
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Blog: http://imyousuf-tech.blogs.smartitengineering.com/
Mobile: +880-1711402557
