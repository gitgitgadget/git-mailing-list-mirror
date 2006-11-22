X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Store peeled refs in packed-refs (take 2).
Date: Wed, 22 Nov 2006 13:25:36 +0100
Message-ID: <e5bfff550611220425x5cf9e33ds7b7b98229c6b408a@mail.gmail.com>
References: <7vac2kvsos.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 22 Nov 2006 12:26:31 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p/bhWMTXyvFXRmSQvz10bFOSU61ftzN0WS1wl4M91DvtOQKxqH80ExBCIA8A8y0Df/+wMVO9RcmGqVni+IdkRJNp3uE3uFbrfYAoSAEOzLIufkqcuDtgsC5dRA+ujq4J4jOthy8RIMjZ091JUdniH45Vhh+b21uNQvMhX27ZTaY=
In-Reply-To: <7vac2kvsos.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32083>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmrB7-0005nr-RZ for gcvg-git@gmane.org; Wed, 22 Nov
 2006 13:26:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755084AbWKVM0K (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 07:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755094AbWKVM0K
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 07:26:10 -0500
Received: from py-out-1112.google.com ([64.233.166.176]:45834 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S1755084AbWKVM0J
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 07:26:09 -0500
Received: by py-out-1112.google.com with SMTP id u77so94876pyb for
 <git@vger.kernel.org>; Wed, 22 Nov 2006 04:26:08 -0800 (PST)
Received: by 10.35.50.9 with SMTP id c9mr861795pyk.1164198336501; Wed, 22 Nov
 2006 04:25:36 -0800 (PST)
Received: by 10.35.42.4 with HTTP; Wed, 22 Nov 2006 04:25:36 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 11/22/06, Junio C Hamano <junkio@cox.net> wrote:
> there is only one such extension defined, "peeled".  This stores
> the "peeled tag" on a line that immediately follows a line for a
> tag object itself in the format "^<sha-1>".
>

Thanks, I will try to do some performance tests this week end.

