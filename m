X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_URI_ONLY,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 1/2] move Git.pm build instructions into perl/Makefile
Date: Mon, 4 Dec 2006 14:52:15 +0100
Message-ID: <81b0412b0612040552w28755dd6uf168bb43bdc99bae@mail.gmail.com>
References: <20061121225911.GA24201@steel.home>
	 <81b0412b0611300827h64722fa0i7e32808994a97a51@mail.gmail.com>
	 <7vvektyi7n.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0612040156w794a276cqaa37f1734ba7a1ca@mail.gmail.com>
	 <7v64csq7e9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 4 Dec 2006 13:53:02 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V49Ng3siVi9vkMufTTYrYuXScZcpV4jc+zvRWH/+C2Farxc6zwvtxex/8eZSn7SuAUJdNvqgTkEOB8SG95y4ttHjDwekFLhIYlAizwdqdG/IIzC8ZOkrJw/rSqh3gRUhkfJCB7Ii7qlnAPddyv0IijD7f41YnUPVKlaIGntnFSY=
In-Reply-To: <7v64csq7e9.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33196>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrEFZ-0002E7-MN for gcvg-git@gmane.org; Mon, 04 Dec
 2006 14:52:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936863AbWLDNwv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 08:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936864AbWLDNwv
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 08:52:51 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:22739 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S936863AbWLDNwu
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 08:52:50 -0500
Received: by py-out-1112.google.com with SMTP id a29so2283737pyi for
 <git@vger.kernel.org>; Mon, 04 Dec 2006 05:52:16 -0800 (PST)
Received: by 10.78.158.11 with SMTP id g11mr7698204hue.1165240335835; Mon, 04
 Dec 2006 05:52:15 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Mon, 4 Dec 2006 05:52:15 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 12/4/06, Junio C Hamano <junkio@cox.net> wrote:
> "Alex Riesen" <raa.lkml@gmail.com> writes:
>
> > Updated patch attached.
>
> Will apply, thanks, but with a few tweaks while I had to hand
> munge your attachment anyway.

