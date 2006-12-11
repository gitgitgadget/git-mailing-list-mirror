X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Dongsheng Song" <dongsheng.song@gmail.com>
Subject: Re: git-svnimport breakage as of git-1.4.4
Date: Tue, 12 Dec 2006 04:00:31 +0800
Message-ID: <4b3406f0612111200o65352771r454d5ced0ac99f08@mail.gmail.com>
References: <1165505193.26874.13.camel@systems03.lan.brontes3d.com>
	 <20061208203230.GA9193@sashak.voltaire.com>
	 <4b3406f0612091949qc75cb10x13f09e2017d71d91@mail.gmail.com>
	 <20061210114735.GA11107@sashak.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 20:00:43 +0000 (UTC)
Cc: "Daniel Drake" <ddrake@brontes3d.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IS2oCyw/I3x5EdGyVTrGZoZ1XYR3qF+D32Hvb9e3Py/GUALvszefdoSp8+k+Qv7JXlj+oizYSDoEX9Xg9Tw0SGICBwMkK1sxC11GKs3VSPUi72p2PaKCLDusFA1WmC/7tftb4y6UpvTgli22mDPDfX8StQNAdOchF43TrbkDuBE=
In-Reply-To: <20061210114735.GA11107@sashak.voltaire.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34030>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtrKH-0005dG-S5 for gcvg-git@gmane.org; Mon, 11 Dec
 2006 21:00:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762386AbWLKUAe (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 15:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762393AbWLKUAe
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 15:00:34 -0500
Received: from wr-out-0506.google.com ([64.233.184.233]:39436 "EHLO
 wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1762384AbWLKUAd (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec
 2006 15:00:33 -0500
Received: by wr-out-0506.google.com with SMTP id i7so1765710wra for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 12:00:33 -0800 (PST)
Received: by 10.78.172.20 with SMTP id u20mr1627395hue.1165867231650; Mon, 11
 Dec 2006 12:00:31 -0800 (PST)
Received: by 10.78.165.2 with HTTP; Mon, 11 Dec 2006 12:00:31 -0800 (PST)
To: "Sasha Khapyorsky" <sashak@voltaire.com>
Sender: git-owner@vger.kernel.org

Sorry, I assume you have see http://tortoisesvn.tigris.org/:

username : guest
password : ""

2006/12/10, Sasha Khapyorsky <sashak@voltaire.com>:
> On 11:49 Sun 10 Dec     , Dongsheng Song wrote:
> > I met the broken too, when I downgrade to 1.4.3.4, it's fine.
> >
> > I have not test your patch, but you can try your self,
> >
> > http://tortoisesvn.tigris.org/svn/tortoisesvn
> >
> > and the master branch(today) fail between r6000~r7000 too
>
> Thanks for the link. but I cannot access - this requires
> username/password authentication.
>
> Sasha
