Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A5A12019E
	for <e@80x24.org>; Thu, 11 May 2017 15:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757618AbdEKP4R (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 11:56:17 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:33647 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757612AbdEKP4O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 11:56:14 -0400
Received: by mail-qt0-f173.google.com with SMTP id t26so20840714qtg.0
        for <git@vger.kernel.org>; Thu, 11 May 2017 08:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=b3fRgWKH8RmPwAq1OFB9pPD3+z4CbFeBr7IEk7rJNu4=;
        b=bvIBpSlQfH/LTuFTFpUq9vGTpv5dVLsi8EiFXOrNaG+ia7slk6uk+MSAYV8TDxvZRt
         cnbLedpmJWDhabHY+DL+jDe/oOHD42xTGrWgThjhjUVxqQfGlsJUlTGf+0cfLxqy+bIp
         gvl6seyahbi4Uf/F3OOEnX2vWLtRvOmPPwhJpVAVdUX3bII0v/1VKUdUOH80dnCuAcIZ
         clY2ea9cUCB5YWANx/gqeEBGhovVYdU1yOnVVkRIObzpa2XE6BW9B5aSR0qDQTf8mtOw
         kyXw8dZs8bTQAW03mUtHdc6qHdZPG6mZYNY//qDpK8bBiP4ZX6Y7DZ9ctjroWChmqKBl
         VY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b3fRgWKH8RmPwAq1OFB9pPD3+z4CbFeBr7IEk7rJNu4=;
        b=q6sH+lOgtol7b3kmibchHclGx7yIONGiUwAcN7Ow5+ZcZefGwPjkgHJ6aVqpE/SiDr
         ObjPOZd+RfK5A2idohjtswQJz+Ih0YQ2sU5/qUYXIZYkFOIZRcUZ4eGctEIsxhN4zgaY
         PcDdecQ/AfiFcZTh7E/3vDd+40Ej9OwoySVKKX73bgGUzk2sMJ/+epamn0vLz1g33wch
         QH4YrA6+zLkR7NwlziNDDpg/0yp65BR/EqxEyVXSGkJNStWzL28tbS73WV4RJsLl6Smi
         XNj2hgq5UDue6709Rf0BkKDXmL4hiX29wkydaLgv/W65osHDSZ9oVDA5zXtYmAlcfWoc
         0IQg==
X-Gm-Message-State: AODbwcAAlYEeDBlAjq4UCc+NhSqrgIeWq1vlQgjOYPOc4o/ZQJWd+3fE
        qQPPbr0RRiUHgvhrmZk=
X-Received: by 10.200.47.83 with SMTP id k19mr1282084qta.254.1494518168671;
        Thu, 11 May 2017 08:56:08 -0700 (PDT)
Received: from [192.168.1.6] (d24-150-100-81.home.cgocable.net. [24.150.100.81])
        by smtp.googlemail.com with ESMTPSA id b23sm388393qkb.31.2017.05.11.08.56.07
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 08:56:08 -0700 (PDT)
Subject: Re: Article on the branch strategy in gitworkflows(7)
From:   Raman Gupta <rocketraman@gmail.com>
To:     git@vger.kernel.org
References: <92db69d3-ca38-45da-47dc-0fb612a16e8d@gmail.com>
Message-ID: <ba55c352-0cf8-4b89-9d12-819f129a60ee@gmail.com>
Date:   Thu, 11 May 2017 11:56:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <92db69d3-ca38-45da-47dc-0fb612a16e8d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

FYI - the article mentioned below has been published @
https://medium.com/@ramangupta/how-the-creators-of-git-do-branches-e6fcc57270fb

Thank you to the two or three people that I know of that took the time
to read the draft.

Regards,
Raman

On 22/03/17 12:41 PM, Raman Gupta wrote:
> Several years ago, I contributed [1] to the gitworkflows(7)
> documentation, because I thought the process by which git.git does
> branching was really interesting.
> 
> Since then, I have found it odd that gitworkflows has mostly remained
> under the radar. Other, in my opinion, lesser flows, have become very
> popular, like GitFlow [2]. I have written an article explaining the
> "why" of gitworkflow in contrast to GitFlow and others:
> 
> https://docs.google.com/document/d/1cGNujRNVzeLV2SXkVlKwai6qJmlVT3LwlOsVYNr0FZo/edit?usp=sharing
> 
> This article is not published yet -- its still a DRAFT and only
> visible via the above URL.
> 
> I'd love to have input on the draft from the experts in this
> community. Feel free to suggest changes and add comments in the
> article via Google Docs.
> 
> Also, some explanatory illustrations to accompany the article would be
> excellent, if anyone feels like contributing. Visuals are not my
> strong suit. I'd love to include something similar to the graphic [3]
> that was a big part of making GitFlow so popular. The article can be
> partially rewritten to match illustrations, if any are contributed.
> 
> [1]
> https://github.com/git/git/commit/382e54312220ac02586a3cbb06b0e4eb7789f043
> 
> [2] http://nvie.com/posts/a-successful-git-branching-model/
> 
> [3] http://nvie.com/img/git-model@2x.png
> 
> Regards,
> Raman Gupta
> 

