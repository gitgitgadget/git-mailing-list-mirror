X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: How to prepend data when formatting patches ?
Date: Thu, 30 Nov 2006 17:16:55 +0100
Message-ID: <38b2ab8a0611300816r19d883a8qab93c86ff11b7ed7@mail.gmail.com>
References: <38b2ab8a0611300616j54a9f8ase9b4f1c305b7c22b@mail.gmail.com>
	 <Pine.LNX.4.63.0611301638430.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 16:17:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=derfHNycT55fS4NYFx0M9XE5fTrR+HFTMhDA2T6Vm1xj+m7cpXSMwwNnhIOC0RYkdkW+U6/ob/mOWRRfUz5vM9qzTh+JgDu0kO1BRJzl8Fy9TcpMFIPtV0l2N7jj+TF8di0cxTm7pyLIrBY0AMQKfGk8wj7REtF0soDlOqFqgaM=
In-Reply-To: <Pine.LNX.4.63.0611301638430.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32767>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpob8-0007W4-Ib for gcvg-git@gmane.org; Thu, 30 Nov
 2006 17:17:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030671AbWK3QQ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 11:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967837AbWK3QQ5
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 11:16:57 -0500
Received: from wx-out-0506.google.com ([66.249.82.235]:14928 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S967836AbWK3QQ4
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 11:16:56 -0500
Received: by wx-out-0506.google.com with SMTP id h27so2708791wxd for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 08:16:56 -0800 (PST)
Received: by 10.90.78.9 with SMTP id a9mr3859678agb.1164903415704; Thu, 30
 Nov 2006 08:16:55 -0800 (PST)
Received: by 10.90.55.9 with HTTP; Thu, 30 Nov 2006 08:16:55 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On 11/30/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 30 Nov 2006, Francis Moreau wrote:
>
> > I'd like to add to all patchs created by "git-format-patch" command
> > the following line:
> >
> >        From: xxx.yyy <foo@crazy.com>
>
> From Documentation/git-format-patch.txt:
>
> -- snip --
>
> CONFIGURATION
> -------------
> You can specify extra mail header lines to be added to each
> message in the repository configuration as follows:
>

I stupily thought that it couldn't be used to prepend message for the
message body. But since it appends the line at the end of mail header,
it does the right thing for me.

Thanks for your quick answer
-- 
