Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6796D20951
	for <e@80x24.org>; Fri, 17 Mar 2017 16:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751251AbdCQQxk (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 12:53:40 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34926 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751169AbdCQQxj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 12:53:39 -0400
Received: by mail-pg0-f42.google.com with SMTP id b129so45537845pgc.2
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 09:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6VvxTLoWWHbpmwk5co+bYFMzMKqDiBnKkWLD/cUjdlQ=;
        b=tyN/aMz0Un3ijZ4rvG8HWuvapgtneW9n5PubwtxufnJ4QS8cZfs2+OunxayvfFEonB
         xf/sr9yGLw1thvJFlIMXLU/+e7b0W5rJeeKhzipkEAmOo2513OcjtDAKrKbPjjMFpejf
         MccBQ0kh+ONCTmmCEfTfv7Bnhhb9pzYmlayacwuyhY8E1hCEa7bSkUbYkuegwWbSEzfV
         GuyHU2TU9jtewfI8gmHH8vmzMmb+N/7n1FSgOXRd1kVcvGUTRG5omOHJ8VlYvSl7tmxy
         tf5qXtwCHu3cYxg9ah+hY+eN1biz5q76d1sYzCcmE7uFrAzjsajUt66LsRS+gLV5fivV
         dRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6VvxTLoWWHbpmwk5co+bYFMzMKqDiBnKkWLD/cUjdlQ=;
        b=ck39DgyTzsq8xUodFvJ5fFkaORPIBBPG44UayAV0yyUoeKGSeRUJkS7wtPo+g4CkMq
         jvgF0GsVD93mqQy1beP0YUBIX5YMSZVlptQivy+tsQSdsgQFd8dcEN3ISw2Tt1VxXDBW
         P+JcnIYIU99Pn2y3zPBgAmKNVqcOb6eTKRmt3aC4YurfTL84kQAieGGrHzKMjOp2KdlE
         dPwDk+cdvrNW08wHFsl7tcDgWbaqfnQrCicEokngwy+mrSG4KL+5HQtLZnONmAIpvk/v
         4XUFP6JbBMrHP7wA3sYq59Cmhr5fgdkdtGv+w/Aiy9tKv4/k8pVe7wA3OIDs+I4RCW/X
         w/ZQ==
X-Gm-Message-State: AFeK/H2wmuwAw/AS/Fy5NXUFbuyZz/kaC2q8KH3O6v79N7IPzKJnqsg4lh0I0YGECcD3Bw==
X-Received: by 10.99.153.1 with SMTP id d1mr17374281pge.44.1489769617904;
        Fri, 17 Mar 2017 09:53:37 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:cc9f:ca23:5f26:6394])
        by smtp.gmail.com with ESMTPSA id m12sm17996025pgc.46.2017.03.17.09.53.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 09:53:37 -0700 (PDT)
Date:   Fri, 17 Mar 2017 09:53:35 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     yanke131415 <yanke131415@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: why patch to the gitk no replay?
Message-ID: <20170317165335.GM26789@aiede.mtv.corp.google.com>
References: <e7d6f518-51aa-92fa-e685-7cde019d6e5b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7d6f518-51aa-92fa-e685-7cde019d6e5b@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

yanke131415 wrote:

>     I send a patch to gitk
> project(git://ozlabs.org/~paulus/gitk)with the target email address
> paulus@ozlabs.org. But several days later No replay of this patch i
> receive, is the  email address i send patch wrong? Anyone who knows?

Sending to this mailing list (and cc-ing Paul) is more likely to work.

Hope that helps,
Jonathan
