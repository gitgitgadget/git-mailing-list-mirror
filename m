Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DACF41F803
	for <e@80x24.org>; Wed,  9 Jan 2019 09:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbfAIJEG (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 04:04:06 -0500
Received: from delivery.mailspamprotection.com ([96.127.190.5]:44293 "EHLO
        delivery.mailspamprotection.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729698AbfAIJEG (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 9 Jan 2019 04:04:06 -0500
X-Greylist: delayed 4959 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Jan 2019 04:04:05 EST
Received: from ns1.es7.siteground.eu ([37.60.237.241] helo=es7.siteground.eu)
        by se1.mailspamprotection.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <petko@fourcirclemarketing.com>)
        id 1gh8UH-0006LN-5a
        for git@vger.kernel.org; Wed, 09 Jan 2019 01:41:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=fourcirclemarketing.com; s=default; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dRarPMkbwlkirxdC/2OOVRfm/X2uZ4S+ySas8lUeCWE=; b=ok/dOv5vU7pmJCM953j5y5gge
        l14yInwwyNgOU1AT8BVRwUMUPaTe6VU8kZX/TIImzU43i8HXUk2qpCMvdNqP9mecxwYysWEV0EpfI
        51tJH4/OwEWifRHwYhBNZqu8tq7j8C5dWrJ9NBiw5L7yGCaEd870MVTeN7KrBXohYm7Qxh1m/5yYF
        8se3j7Cp6iSPhUaae8JxgKJIlXRFWCr+74l59xpwQrwl+C1GMkIJpFYHveadcL/MtbmaD7X3OkvID
        EepKWxPyThLCrlbO+23Sxbb7q6TeODFGHPgB5dcxXGDwU3tSFwroi789aIrRihO/q6bc6kd0/dvfu
        HKhTlzXNg==;
Received: from [84.43.188.150] (port=51686 helo=[192.168.100.56])
        by es7.siteground.eu with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.89_34-9f6032f-XX)
        (envelope-from <petko@fourcirclemarketing.com>)
        id 1gh8UG-000BVB-26
        for git@vger.kernel.org; Wed, 09 Jan 2019 08:41:16 +0100
To:     git@vger.kernel.org
From:   Petko Yanev <petko@fourcirclemarketing.com>
Subject: A quick question about donation and partnership
Organization: Four Circle Marketing
Message-ID: <2db2976a-12b1-228a-9c37-d31587af41b1@fourcirclemarketing.com>
Date:   Wed, 9 Jan 2019 09:41:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:50.0) Gecko/20100101
 Thunderbird/50.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: 37.60.237.241
X-SpamExperts-Domain: es7.siteground.eu
X-SpamExperts-Username: 37.60.237.241
Authentication-Results: mailspamprotection.com; auth=pass smtp.auth=37.60.237.241@es7.siteground.eu
X-SpamExperts-Outgoing-Class: unsure
X-SpamExperts-Outgoing-Evidence: Combined (0.87)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5jrdslh9QB94U3qhMjHaMB5602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvOxjtoUCxoWwkMTV89iv9DSlX1rvnjyehFxXXpZmNaK+h8dxQpBrFjz7HVjv2rJkkkeKV
 se1sVhWabI0/+PN3sIKUYmhS9vAb5UElM+rK74SbHDxGEF9UmqdGvQwZPjX06XgOrHGWcKc5AqOF
 qAQq4tLXieDNWzPvTX0ja2ZbdgXzo8GmGLHquT/nHFaWfgC9mezqxVN6BVd3hcP0CMzDzJ9Kbts7
 kfM/fYJjjnXfl6x+B8yl1GkTKsf4lfD/xDWhsoKjXKID47pwwjlLk88V3pYfUIsqb6DAeqawEuBR
 mO5YXN8xBSpTb4eYUC8bIPpz0ov7wtQZR2oOs9ndobyxW7KtwlUqTUnRR0H/Y1tNLqMDdcnQTJir
 59vLnO0s+j/6l0XtQhr43M8eCrxQqJFh3M72uevxyGyShWIzRoCu8dhGxRamOeYDBIwBrxIWz+W8
 eik4xAm9D8KTeKJT7gNACPeFIG5rVgSZqKqezztI0zHJGIlOeNBEZneFneto2SXKOnXW1eAGl6XP
 byiVs3ji8UiEhMa4WEn8Wo26x1msP+hhxPsOtxwH3Roif4+o+oisv+6y9jCKA0zco3Cgi9R7Xr8B
 SNM5qC16R2ze3n3YLVx7IV9V75TL3OpPOp1VQY9qINzfd1BWXLNBw0bM3eOkq7wRtucb80caIrIP
 9tTAPcUR9ChGXDVIEtqMSRW+gKM+K9pGrhu1J0mqt6HsLZtONfL55TM/KdE9TGDi6l+se0u0prea
 8tC2aXJq8TOj+7PwgQMukOSCgyj+lZNITdq8cWgULXCELp41E0m4BwBNbpKhHpNR1U3+N6t776ER
 DVKcvbpjRALSQgsUFYMNPK04GftvnBME9T3dUDY0PQXuSVOBOZ6va6aVSY6Ck+3wJ1c7H3Ti3MRg
 GkVFYFPFTe6iYsEaiE7yIDQ11LE8f6ZYbKTFn09oTGNUxO+4ZzBK5mIfOKM4jlzeBRf2XEiC1awZ
 EQt4DqxxlnCnOQKjhagEKuLSvPMaJFES+ZCu29JtXh+cETjdhCrxlpKhA5U+PcssrCNr1XnruN+a
 229WXkyXzpy1
X-Report-Abuse-To: spam@quarantine1.mailspamprotection.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

My name is Petko and I am managing the marketing of few sports betting 
and casino review websites.

I'm writing to you because git-scm.com is a great project and I want to 
help out.

I'd love to contribute with a donation or in another manner you consider 
acceptable.

In exchange, all I expect is a do-follow backlink to one of our sites.

Do let me know what you think about this proposal.

Best Regards,
Petko Yanev

