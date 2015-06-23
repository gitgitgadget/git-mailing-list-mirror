From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 07/19] for-each-ref: add '--merged' and '--no-merged' options
Date: Tue, 23 Jun 2015 16:35:38 +0530
Message-ID: <CAOLa=ZRUuRM8jofM6As_=F5Lbpb2LBq=X4pTbmDfufntYeWnmg@mail.gmail.com>
References: <CAOLa=ZS_vn8ZNrb7mtqZKU4Y3RCZojcbeMYfbx=3X-aVjhdpSA@mail.gmail.com>
 <1434919705-4884-1-git-send-email-karthik.188@gmail.com> <1434919705-4884-7-git-send-email-karthik.188@gmail.com>
 <CAPig+cQLHX2spg00Zn1J=PMg_cuy2ARuWPOQQXLT1yLoQZ_SFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 13:06:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7M1t-0000kD-UJ
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 13:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754447AbbFWLGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 07:06:10 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:33473 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753540AbbFWLGI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 07:06:08 -0400
Received: by oiyy130 with SMTP id y130so4264906oiy.0
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 04:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Qii84PYvNg/MxRNUsI3rObRLwCDcxGGSLOC1647xKEE=;
        b=lnfzZzO2LtQEz7FeGVg9+jXyN18FYBjSauOVAhK29MIphooCnI5+XyrUopYJinSyqp
         a9ljn/KuBd3WcmOtm8k+ksykl5WiEgBapow6mXZcEokLAwZQBBHasPMmFUA8xevUttgu
         2AJjPz3mFjr+v1ax0w5VHiCDu/Fa15g7W5G6VwF/PE1K4YlarCBl+VtEboJTQMdIlvvV
         fcBi/4XMQ4A+mU0VK8ia20y45dtwjA5J8tEqwN7iPLztQV2YlPk7l3YgC8xAyePAUB1Q
         bp/V954bgqSBLyuj/616pU7br4br+U9dgaovkFLcQx2yeW25BRXmEVevebd/y4mPVvxy
         3zEQ==
X-Received: by 10.60.35.8 with SMTP id d8mr29314956oej.37.1435057567393; Tue,
 23 Jun 2015 04:06:07 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Tue, 23 Jun 2015 04:05:38 -0700 (PDT)
In-Reply-To: <CAPig+cQLHX2spg00Zn1J=PMg_cuy2ARuWPOQQXLT1yLoQZ_SFg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272451>

On Tue, Jun 23, 2015 at 4:11 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> According to the documentation you added to the OPTIONS section, the
> object following --merged and --no-merged is optional. Therefore,
> shouldn't this be s/<object>/[<object>]/ ?
>
> Also, in the OPTIONS section, you spelled it "commit" rather than "object".
>

>
> Ditto: s/<object>/[<object>]/
>

Noted and changed, this would apply to --contains also :)

-- 
Regards,
Karthik Nayak
