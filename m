X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Restore a single file in the index back to HEAD
Date: Wed, 1 Nov 2006 14:58:54 +0700
Message-ID: <fcaeb9bf0610312358g1176e4d8q8962b08c2e8ff2c6@mail.gmail.com>
References: <200610261641.11239.andyparkins@gmail.com>
	 <81b0412b0610260842x52413570k3971bcdc54b3ccb5@mail.gmail.com>
	 <200610270827.17659.andyparkins@gmail.com>
	 <20061027073834.GC29057@spearce.org> <4541BE8E.5050605@op5.se>
	 <20061027081545.GF29057@spearce.org>
	 <81b0412b0610270245w6c29b3c3va7967991f53db298@mail.gmail.com>
	 <4541D670.6000900@op5.se> <7vac3igjpd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 1 Nov 2006 07:59:14 +0000 (UTC)
Cc: "Andreas Ericsson" <ae@op5.se>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hcrHn/D66SoEv5kqAdR3jPGkQNirjZLmN6NdWKlrhEgQFqw4pX96LKF22OkDpYnIqIykzi5qdNSRi2gpY8FKSZdcVkbyU1K5zbFvelJakEQv9eCnbiG3HylmHV/pHD3knRumPhd/Errd5n98Efp+aH8yAMH7J+D7Z1LizBmiWZM=
In-Reply-To: <7vac3igjpd.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30617>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfB02-0007DU-E5 for gcvg-git@gmane.org; Wed, 01 Nov
 2006 08:59:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946681AbWKAH65 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 02:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946683AbWKAH65
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 02:58:57 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:18616 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1946681AbWKAH64
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 02:58:56 -0500
Received: by nf-out-0910.google.com with SMTP id c2so702673nfe for
 <git@vger.kernel.org>; Tue, 31 Oct 2006 23:58:55 -0800 (PST)
Received: by 10.78.160.2 with SMTP id i2mr8414498hue; Tue, 31 Oct 2006
 23:58:54 -0800 (PST)
Received: by 10.78.100.8 with HTTP; Tue, 31 Oct 2006 23:58:54 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 10/27/06, Junio C Hamano <junkio@cox.net> wrote:
> On the other hand, I designed --index-info to be compatible with
> ls-tree output (it is not an accident, it was designed).  In
>
>         git ls-tree HEAD frotz | git update-index --index-info
>
> "frotz" part does not have to be the exact path but can be a
> directory name.  It means "revert everything in this directory".
>
> This is quite heavy-handed and you would probably want to run
> update-index --refresh afterwards.

I would prefer "git update-index --reset frotz" or "git checkout
--index HEAD frotz". git ls-tree|git update-index is too cryptic for
me and too long for my fingers.
-- 
