Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62520203E1
	for <e@80x24.org>; Sun, 24 Jul 2016 19:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508AbcGXTUj (ORCPT <rfc822;e@80x24.org>);
	Sun, 24 Jul 2016 15:20:39 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36712 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbcGXTUi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2016 15:20:38 -0400
Received: by mail-pa0-f65.google.com with SMTP id ez1so10114702pab.3
        for <git@vger.kernel.org>; Sun, 24 Jul 2016 12:20:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=cX4BH9V5fSYFk9HVoz5TOZmqT/XSQmW0ylxixukhK8Y=;
        b=jzkSnosdMhpUcUknp59qZaxePygcWrwXri2EmZ+LeLfqS/nenO+YCyB42S+uL9mZqg
         yXWpsrQb5+h8VRlpC+TDnSdjbE7N4goalVVh1ampL9EoFMrSmOVSyK/4PsrJgwz01ejG
         c95nY/NNn4UgVj3es87pa9TeNpOt+EgJ+BbT//UP3lxZn6BdoGKJJICE/3DCLvqff75w
         sOt22v08M5a1cVu4yGoiBieQ6tZ+AuRJ5/ShCBCg4zD/v+DJ1xh719KuNqmggUM1c/aH
         RMJRD5H5LbB+FEXycj3t439Takyi6owjSGTTd+qPhEtNmgT84DbRouiK5P0lYnfAUhwO
         APUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=cX4BH9V5fSYFk9HVoz5TOZmqT/XSQmW0ylxixukhK8Y=;
        b=H8LzeRL8HD8GbHaTM/Lwo1WFd0jOTawMMRGdf5/5QlStCiOFQzsxp3UMLzFVSSiP9m
         AvoQn0WBNdpLflBxM2dF0A2HYtMCIPxmVnwOZHog1naT1uglL3AK07tp2qxdOewZgmNn
         fusX0OrSU9aPGshnIKHVvZeICkJbOrVtu4qVJUeBaRy9EVBtjTHbhrtbhRwnk2epaOEC
         ccAMatoWu+VDWXOKZxe+0LJMRZf42JedXehDWOszRD7ZbAfxcj3BbyQ1Zygb+i1A4hMt
         WO3VhUGAcQNZGnP8sj6jmVm7zBezd/FGNrkK5zFj29Rt7P2F/D4aWvjP5wDQ7K6Rp762
         RN6g==
X-Gm-Message-State: AEkoousL6a2Xalve8GOs/4Btoxmank2iMRMxfQ8BMqQ9GY4LA3Zlgvr9jixtbkpo7duS6w==
X-Received: by 10.66.197.195 with SMTP id iw3mr23228989pac.82.1469388037339;
        Sun, 24 Jul 2016 12:20:37 -0700 (PDT)
Received: from [192.168.0.109] (c-71-202-183-39.hsd1.ca.comcast.net. [71.202.183.39])
        by smtp.googlemail.com with ESMTPSA id o5sm28246178pfb.9.2016.07.24.12.20.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jul 2016 12:20:36 -0700 (PDT)
Subject: Re: [RFC] A Change to Commit IDs Too Ridiculous to Consider?
To:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
	git@vger.kernel.org
References: <nn30dv$5sn$1@ger.gmane.org> <57950D12.2000607@gmail.com>
From:	Jon Forrest <nobozo@gmail.com>
Message-ID: <cfff11c9-e212-88a1-c00b-3e7a361e0db9@gmail.com>
Date:	Sun, 24 Jul 2016 12:20:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <57950D12.2000607@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 7/24/2016 11:46 AM, Jakub Narębski wrote:
> Please try to keep to the 80-character lines.

Sorry.

> Another possibility is to set authordate and committerdate to some
> specified time by the way of appropriate environment variables.

That sounds like a great idea. Assuming it
works the way I envision, this wouldn't require
any changes to the source code.

> What I think you don't realize is that "commit" objects are not
> treated in any way special. Object identifiers of all objects are
> SHA-1 hash of uncompressed loose representation of said object
> (type + length + contents).

I know this, but I thought that commit object IDs were the only
ones that included a date in what gets run through the SHA-1
hash function. If there are others, then you're right - they'd
need to be included in this proposal.

> Well, you could not record dates in commit object, but I think
> Git considers such objects broken.

You mean that Git could, after the fact, detect commit IDs
that didn't include a date? If this is true, then your
idea of using fixed dates from environment variables
would be the only way to do this.

> IMVHO it would require heavy surgery of Git for little benefit
> (see the beginning of reply for alternate solutions).

Even using your environment variable solution that wouldn't
require any code changes?

Jon

