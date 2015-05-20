From: Luke Diamand <luke@diamand.org>
Subject: Re: git p4 clone - exclude file types
Date: Wed, 20 May 2015 07:49:01 +0100
Message-ID: <555C2E5D.70502@diamand.org>
References: <CAFcBi88K-HEn4JCVkONq3h4O9XS1FFX0OXch2d-VJ2bLEsPM0g@mail.gmail.com>	<555A52BD.1030802@diamand.org> <CAFcBi89XwW48Goaap=OCVQ_CJrNa_hj5+DWtOHGOsrm6jMs-mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Users <git@vger.kernel.org>
To: FusionX86 <fusionx86@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 20 08:49:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yuxp0-00007A-S6
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 08:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbbETGti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 02:49:38 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:36762 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbbETGth (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 02:49:37 -0400
Received: by wgbgq6 with SMTP id gq6so41922537wgb.3
        for <git@vger.kernel.org>; Tue, 19 May 2015 23:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=HLev7ZkpDviWvMb2nd9RZoOfP89eoqaFfEkMeee12S4=;
        b=Cln1tYcNM/RpGYvQuZvvZ+WbTS2j8odFnUa3nSrI6ndhtTkm7YtrssMX17qxNxaQFw
         MBMslTBy79DB9ztru9/Ttpqv39ieh1qfWmQDeBXYKNbA/HHIdpyzUHEPicr3e/VLsHkR
         4b2o69mOVZ8D+3meqUeq4VPDDSA6ftoe2aviU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=HLev7ZkpDviWvMb2nd9RZoOfP89eoqaFfEkMeee12S4=;
        b=jxiqI4KsnrFJg0QItrjvdTBE+MfMRQp8eQ5eOLAb52iWP1Kc1sPZg5cRcs+BdfhRZt
         I8wzHfd5CLo1oY+v9D37Z2MNFguE8ZtoVxoZG/YW0Vz/DMmBSVlmKFAqSGhGvH97KF2+
         92661sI78f4Zf/BX7fums2IOAH0UEPuO9K2a9EpNFPVk0m4gRofXkwt2c0CszeAwY5NV
         B4yG5wZ8FpEHKBTXYxPUj/fpgymr1Nw44fMr2Cd8agzmzuAd2SGl6avPHRTKtzg6V7OB
         Yxp/siqxr2YteuRUwZUCBGBR7EC424pDzu7eMFGpmGgSQRk9hhr/Chta39KYZlFIhPmz
         Ry3A==
X-Gm-Message-State: ALoCoQl2LRUFwPW0+haoJaTi+6os6mxSrym5ld8F4l0IMgtwyE0y5GQccOp6XKDI6zpm54HpueWY
X-Received: by 10.194.61.208 with SMTP id s16mr62505443wjr.135.1432104575592;
        Tue, 19 May 2015 23:49:35 -0700 (PDT)
Received: from [192.168.245.128] (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id l3sm1773330wik.16.2015.05.19.23.49.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2015 23:49:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <CAFcBi89XwW48Goaap=OCVQ_CJrNa_hj5+DWtOHGOsrm6jMs-mw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269440>

On 19/05/15 08:38, FusionX86 wrote:
> Thanks Luke, looks like this does work for excluding files when using
> git p4. Great!
>
> Unrelated question...
>
> While using git p4 I have noticed that most of the time the clone/sync
> operations hang and I have to keep retrying. The Perforce depot I'm
> currently working with is larger than I'd like and has a lot of binary
> files which might be the cause. The point it gets to in the clone/sync
> is always random and doesn't ever stop on the same files or file
> types. Sometimes it'll die soon after starting, but other times it
> almost completes and then dies. If I keep retrying, it will eventually
> complete. I haven't been able to narrow down the cause, but I do
> notice that the git-fast-import stops right as the clone/sync dies.
> I'm wondering if git is overwhelmed and terminates. Have you ever seen
> this? Any suggestions?

Running out of memory?

Is this on a 32bit or 64bit system? How much virtual memory do you have?

Luke
