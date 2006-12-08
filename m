X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH] Add branch.*.localmerge and documentation update
Date: Fri, 8 Dec 2006 21:52:15 +0100
Message-ID: <8aa486160612081252t1e245104x58c8a6654d887af5@mail.gmail.com>
References: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com>
	 <8aa486160612071756s18f9530cr7ed26e4b7b47d1de@mail.gmail.com>
	 <200612081823.45565.Josef.Weidendorfer@gmx.de>
	 <200612082012.19167.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 20:52:24 +0000 (UTC)
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Aneesh Kumar K.V" <aneesh.kumar@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ftEskIm8BP5D4ggEz1AiSrbKUdCdQp7+2iFn5qX5u877GE0RWL2G1kNWk+9+6v+f8YlnklvCa0MkMYyxY6c238QEtabmv2Ici+7nb4icaRQA1EY3sS1Ct1k87V2RfmT9bQoewAlJVNg7FV+2YMQDHghbOMl1Tjq880qVOqdgVIY=
In-Reply-To: <200612082012.19167.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33744>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gsmhg-0003Q4-Ct for gcvg-git@gmane.org; Fri, 08 Dec
 2006 21:52:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947216AbWLHUwR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 15:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947223AbWLHUwR
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 15:52:17 -0500
Received: from wx-out-0506.google.com ([66.249.82.228]:55947 "EHLO
 wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1947216AbWLHUwQ (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec
 2006 15:52:16 -0500
Received: by wx-out-0506.google.com with SMTP id h27so913927wxd for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 12:52:16 -0800 (PST)
Received: by 10.70.125.2 with SMTP id x2mr6714177wxc.1165611135638; Fri, 08
 Dec 2006 12:52:15 -0800 (PST)
Received: by 10.70.45.1 with HTTP; Fri, 8 Dec 2006 12:52:15 -0800 (PST)
To: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

On 12/8/06, Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> Clarify the meaning of branch.*.merge option and add a similar
> branch.*.localmerge option, which can be used to specify a local
> tracking branch to be merged by default.
>
> Previously, if branch.*.merge was specified but did not match any
> ref, the message "No changes." was not really helpful regarding
> the misconfiguration. This now gives a warning.
>
> The value of branch.*.merge can be a list to get an octopus
> merge. I chose the same way for branch.*.localmerge, and if
> you specify both options, the octopus merge will have even
> more parents ;-)
>
> Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>

Ack for the documentation part. But the localmerge part is almost
equivalent to my patch to allow the branch.<name>.remote equal to ".".

