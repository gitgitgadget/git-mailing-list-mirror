X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Dongsheng Song" <dongsheng.song@gmail.com>
Subject: Re: git-svnimport breakage as of git-1.4.4
Date: Sun, 10 Dec 2006 11:49:28 +0800
Message-ID: <4b3406f0612091949qc75cb10x13f09e2017d71d91@mail.gmail.com>
References: <1165505193.26874.13.camel@systems03.lan.brontes3d.com>
	 <20061208203230.GA9193@sashak.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 03:49:38 +0000 (UTC)
Cc: "Daniel Drake" <ddrake@brontes3d.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KO/8ZIZwqufXN25lRWSfYpgiLC/4u7BfBzQG7cUmq5tH7F+8DaboXwuRNEyZYxII6VbYgxYtQAHM+/9GcfJCRvcY7E5dVzSghbTv9YlAPEquxFlBejCUIYG1bd/b6drIVMZnZoXhdBvV6tWykiKthbi0dMsZkQzj4MX/agl/ddw=
In-Reply-To: <20061208203230.GA9193@sashak.voltaire.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33865>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtFh2-0001k5-1h for gcvg-git@gmane.org; Sun, 10 Dec
 2006 04:49:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760131AbWLJDtc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 22:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760133AbWLJDtc
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 22:49:32 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:50584 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1760131AbWLJDtb (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec
 2006 22:49:31 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1588226nfa for
 <git@vger.kernel.org>; Sat, 09 Dec 2006 19:49:29 -0800 (PST)
Received: by 10.78.180.18 with SMTP id c18mr2374324huf.1165722569021; Sat, 09
 Dec 2006 19:49:29 -0800 (PST)
Received: by 10.78.165.2 with HTTP; Sat, 9 Dec 2006 19:49:28 -0800 (PST)
To: "Sasha Khapyorsky" <sashak@voltaire.com>
Sender: git-owner@vger.kernel.org

I met the broken too, when I downgrade to 1.4.3.4, it's fine.

I have not test your patch, but you can try your self,

http://tortoisesvn.tigris.org/svn/tortoisesvn

and the master branch(today) fail between r6000~r7000 too

2006/12/9, Sasha Khapyorsky <sashak@voltaire.com>:
> Hi,
>
> On 10:26 Thu 07 Dec     , Daniel Drake wrote:
> >
> > git-svnimport broken between git-1.4.3.5 and git-1.4.4
> >
>
> Is this 'server' public? Can I rerun this git-svnimport?
>
> If not, please try the patch:
